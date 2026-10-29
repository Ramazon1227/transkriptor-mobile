import 'dart:async';

import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/player/domain/entities/playable_media.dart';
import 'package:transkriptor_uz/features/player/domain/playback_engine.dart';

import '../../../helpers/editor_fakes.dart';

class _SlowFacade extends FakePlayerFacade {
  final Map<String, Completer<Either<Failure, PlayableMedia>>> pending = {};

  @override
  Future<Either<Failure, PlayableMedia>> mediaSource(String mediaId) =>
      (pending[mediaId] = Completer()).future;
}

const _audio = PlayableMedia(url: 'https://s3.test/a.m4a', mime: 'audio/mp4');

void main() {
  late FakePlayerFacade facade;
  late FakeEngineFactory engines;
  late PlayerCubit cubit;

  setUp(() {
    facade = FakePlayerFacade(const Right(_audio));
    engines = FakeEngineFactory();
    cubit = PlayerCubit(facade, engines);
  });
  tearDown(() => cubit.close());

  FakeEngine engine() => engines.made.last;

  test('opens a file: ready, the link handed to the engine', () async {
    await cubit.open('m1');
    expect(cubit.state.status, PlayerStatus.ready);
    expect(engine().opened, Uri.parse(_audio.url));
    expect(engine().calls, ['open', 'speed:1.0']);
    expect(cubit.state.duration, const Duration(minutes: 1));
    expect(cubit.state.hasVideo, isFalse);
  });

  test('the engine says whether there is a picture', () async {
    engines.made.clear();
    await cubit.open('m1');
    engine().push(
      const PlaybackSnapshot(
        duration: Duration(minutes: 1),
        hasVideo: true,
        aspectRatio: 4 / 3,
      ),
    );
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state.hasVideo, isTrue);
    expect(cubit.state.aspectRatio, 4 / 3);
  });

  test('YouTube media: a link card, no engine', () async {
    facade.answer = const Right(
      PlayableMedia(url: 'https://www.youtube.com/watch?v=x', youtubeId: 'x'),
    );
    await cubit.open('m1');
    expect(cubit.state.status, PlayerStatus.youtube);
    expect(engines.made, isEmpty);

    expect(await cubit.openLink(), isTrue);
    expect(facade.opened, ['https://www.youtube.com/watch?v=x']);

    facade.openSucceeds = false;
    expect(await cubit.openLink(), isFalse);
  });

  for (final code in [404, 410, 422]) {
    test('$code: no file, the transcript works without it', () async {
      facade.answer = Left(Failure.server(statusCode: code));
      await cubit.open('m1');
      expect(cubit.state.status, PlayerStatus.unavailable);
      expect(engines.made, isEmpty);
    });
  }

  test('an empty media id asks nothing', () async {
    await cubit.open('');
    expect(cubit.state.status, PlayerStatus.unavailable);
  });

  test('a network failure can be retried', () async {
    facade.answer = const Left(Failure.network());
    await cubit.open('m1');
    expect(cubit.state.status, PlayerStatus.failure);

    facade.answer = const Right(_audio);
    await cubit.retry();
    expect(cubit.state.status, PlayerStatus.ready);
  });

  test('an engine that cannot open is a failure and is released', () async {
    engines.failOpen = true;
    await cubit.open('m1');
    expect(cubit.state.status, PlayerStatus.failure);
    expect(engine().disposed, isTrue);
  });

  test('retry after a broken playback goes back to where it was', () async {
    await cubit.open('m1');
    await cubit.seekTo(const Duration(seconds: 20));
    engine().push(const PlaybackSnapshot(error: 'expired link'));
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state.status, PlayerStatus.failure);

    await cubit.retry();
    expect(cubit.state.status, PlayerStatus.ready);
    expect(engine().calls, contains('seek:20000'));
  });

  test('play, pause, ±5 s, clamped seeks, seek-and-play', () async {
    await cubit.open('m1');
    await cubit.togglePlay();
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state.playing, isTrue);
    await cubit.togglePlay();
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state.playing, isFalse);

    await cubit.seekBy(const Duration(seconds: -5));
    expect(cubit.state.position, Duration.zero);
    await cubit.seekTo(const Duration(hours: 1));
    expect(cubit.state.position, const Duration(minutes: 1));

    await cubit.seekTo(const Duration(seconds: 7), play: true);
    await Future<void>.delayed(Duration.zero);
    expect(engine().calls.sublist(engine().calls.length - 2), [
      'seek:7000',
      'play',
    ]);
    expect(cubit.state.playing, isTrue);
  });

  test('speed is kept and applied; folding does not touch playback', () async {
    await cubit.setSpeed(1.5);
    await cubit.open('m1');
    expect(engine().calls, contains('speed:1.5'));
    await cubit.play();
    final before = List.of(engine().calls);
    cubit.toggleFold();
    expect(cubit.state.videoFolded, isTrue);
    expect(engine().calls, before);
  });

  test('a late answer for an older file is dropped', () async {
    final slow = _SlowFacade();
    final c = PlayerCubit(slow, engines);
    addTearDown(c.close);
    final first = c.open('old');
    await Future<void>.delayed(Duration.zero);
    final second = c.open('new');
    await Future<void>.delayed(Duration.zero);
    slow.pending['new']!.complete(const Left(Failure.server(statusCode: 410)));
    await second;
    slow.pending['old']!.complete(const Right(_audio));
    await first;
    expect(c.state.status, PlayerStatus.unavailable);
    expect(engines.made, isEmpty);
  });

  test('closing releases the engine', () async {
    await cubit.open('m1');
    final e = engine();
    await cubit.close();
    expect(e.disposed, isTrue);
  });
}

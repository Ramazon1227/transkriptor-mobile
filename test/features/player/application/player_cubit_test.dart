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

  group('a speaker sample', () {
    const start = Duration(seconds: 3);
    const end = Duration(seconds: 11);

    PlaybackSnapshot at(int seconds) => PlaybackSnapshot(
      position: Duration(seconds: seconds),
      duration: const Duration(minutes: 1),
      playing: true,
    );

    test('plays from its start and stops itself at its end', () async {
      await cubit.open('m1');
      await cubit.playClip(start, end);
      expect(engine().calls, containsAllInOrder(['seek:3000', 'play']));
      expect(cubit.state.clipStart, start);

      engine().push(at(10));
      await pumpEventQueue();
      expect(engine().calls, isNot(contains('pause')));

      engine().push(at(11));
      await pumpEventQueue();
      expect(engine().calls, contains('pause'));
      expect(cubit.state.clipStart, isNull);
    });

    test('an old position from before the seek does not stop it', () async {
      await cubit.open('m1');
      await cubit.playClip(start, end);
      engine().push(at(40));
      await pumpEventQueue();
      expect(engine().calls, isNot(contains('pause')));
      expect(cubit.state.clipStart, start);
    });

    test('leaving goes back to where the player stood', () async {
      await cubit.open('m1');
      await cubit.seekTo(const Duration(seconds: 20));
      await cubit.playClip(start, end);
      await cubit.playClip(
        const Duration(seconds: 30),
        const Duration(seconds: 38),
      );
      await cubit.leaveClips();
      expect(cubit.state.clipStart, isNull);
      expect(cubit.state.playing, isFalse);
      expect(engine().calls.last, 'seek:20000');
    });

    test('leaving without a sample touches nothing', () async {
      await cubit.open('m1');
      final before = List.of(engine().calls);
      await cubit.leaveClips();
      expect(engine().calls, before);
    });

    test('a manual pause ends it', () async {
      await cubit.open('m1');
      await cubit.playClip(start, end);
      await cubit.pause();
      expect(cubit.state.clipStart, isNull);
    });
  });

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

  group('YouTube media (E-24)', () {
    const yt = PlayableMedia(
      url: 'https://www.youtube.com/watch?v=x',
      youtubeId: 'x',
    );
    setUp(() => facade.answer = const Right(yt));

    test('plays in the app through the YouTube engine', () async {
      await cubit.open('m1');
      expect(cubit.state.status, PlayerStatus.ready);
      expect(engines.youtube, [true]);
      expect(engine().opened, Uri.parse(yt.url));

      await cubit.seekTo(const Duration(seconds: 7), play: true);
      await cubit.setSpeed(1.5);
      expect(
        engine().calls,
        containsAllInOrder(['seek:7000', 'play', 'speed:1.5']),
      );
    });

    test('an audio file still gets the plain engine', () async {
      facade.answer = const Right(_audio);
      await cubit.open('m1');
      expect(engines.youtube, [false]);
    });

    for (final why in EmbedFailure.values) {
      test('$why: the link card, no reconnect', () async {
        await cubit.open('m1');
        engine().push(PlaybackSnapshot(error: 'yt', embedFailure: why));
        await pumpEventQueue();
        expect(cubit.state.status, PlayerStatus.youtube);
        expect(cubit.state.embedFailure, why);
        expect(engines.made, hasLength(1));
        expect(engine().disposed, isTrue);

        expect(await cubit.openLink(), isTrue);
        expect(facade.opened, [yt.url]);
        facade.openSucceeds = false;
        expect(await cubit.openLink(), isFalse);
      });
    }

    test(
      'a player that did not open shows the card; retry tries again',
      () async {
        engines.failOpen = true;
        await cubit.open('m1');
        expect(cubit.state.status, PlayerStatus.youtube);
        expect(cubit.state.embedFailure, EmbedFailure.other);
        expect(cubit.state.source, yt);

        engines.failOpen = false;
        await cubit.retry();
        expect(cubit.state.status, PlayerStatus.ready);
        expect(cubit.state.embedFailure, isNull);
      },
    );
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
    // The first break reconnects by itself; the second one is shown.
    engine().push(const PlaybackSnapshot(error: 'expired link'));
    await pumpEventQueue();
    engine().push(const PlaybackSnapshot(error: 'still broken'));
    await pumpEventQueue();
    expect(cubit.state.status, PlayerStatus.failure);

    await cubit.retry();
    expect(cubit.state.status, PlayerStatus.ready);
    expect(engine().calls, contains('seek:20000'));
  });

  group('an expired link (E-10)', () {
    test('reconnects by itself and plays on from that second', () async {
      await cubit.open('m1');
      await cubit.seekTo(const Duration(seconds: 42), play: true);
      final first = engine()
        ..push(
          const PlaybackSnapshot(
            position: Duration(seconds: 42),
            duration: Duration(minutes: 1),
            error: 'HTTP 403',
          ),
        );
      await pumpEventQueue();
      expect(first.disposed, isTrue);
      expect(engines.made, hasLength(2));
      expect(engine().calls, ['open', 'speed:1.0', 'seek:42000', 'play']);
      expect(cubit.state.status, PlayerStatus.ready);
      expect(cubit.state.failure, isNull);
    });

    test('a pause pressed while reconnecting wins', () async {
      final slow = _SlowFacade();
      final c = PlayerCubit(slow, engines);
      addTearDown(c.close);
      final opening = c.open('m1');
      await pumpEventQueue();
      slow.pending['m1']!.complete(const Right(_audio));
      await opening;
      await c.play();
      engine().push(const PlaybackSnapshot(error: 'HTTP 403'));
      await pumpEventQueue();
      // The fresh link is on its way; the person pauses meanwhile.
      await c.pause();
      slow.pending['m1']!.complete(const Right(_audio));
      await pumpEventQueue();
      expect(c.state.status, PlayerStatus.ready);
      expect(engine().calls, isNot(contains('play')));
    });

    test('a paused player stays paused after reconnecting', () async {
      await cubit.open('m1');
      await cubit.seekTo(const Duration(seconds: 10));
      engine().push(const PlaybackSnapshot(error: 'HTTP 403'));
      await pumpEventQueue();
      expect(cubit.state.status, PlayerStatus.ready);
      expect(engine().calls, isNot(contains('play')));
    });

    test('after playing on for a while it may reconnect again', () async {
      await cubit.open('m1');
      engine().push(const PlaybackSnapshot(error: 'HTTP 403'));
      await pumpEventQueue();
      engine().push(
        const PlaybackSnapshot(
          position: Duration(seconds: 30),
          duration: Duration(minutes: 1),
          playing: true,
        ),
      );
      await pumpEventQueue();
      engine().push(const PlaybackSnapshot(error: 'HTTP 403'));
      await pumpEventQueue();
      expect(engines.made, hasLength(3));
      expect(cubit.state.status, PlayerStatus.ready);
    });
  });

  group('volume', () {
    test('is applied to a new file and remembered', () async {
      await cubit.open('m1');
      expect(engine().volumes, [1.0]);
      await cubit.setVolume(0.4);
      expect(engine().volumes.last, 0.4);
      expect(facade.savedLevel, (volume: 0.4, muted: false));

      final next = PlayerCubit(facade, engines);
      addTearDown(next.close);
      await next.open('m2');
      expect(next.state.volume, 0.4);
      expect(engine().volumes, [0.4]);
    });

    test('mute keeps the level; raising the level unmutes', () async {
      await cubit.open('m1');
      await cubit.setVolume(0.6);
      await cubit.toggleMute();
      expect(cubit.state.muted, isTrue);
      expect(engine().volumes.last, 0);
      expect(facade.savedLevel, (volume: 0.6, muted: true));
      await cubit.setVolume(0.8);
      expect(cubit.state.muted, isFalse);
      expect(engine().volumes.last, 0.8);
    });

    test('one press brings sound back from a level of zero', () async {
      await cubit.open('m1');
      await cubit.setVolume(0);
      await cubit.toggleMute();
      expect(cubit.state.muted, isFalse);
      expect(cubit.state.volume, greaterThan(0));
      expect(engine().volumes.last, cubit.state.volume);
    });

    test('a drag applies at once and saves on release', () async {
      await cubit.open('m1');
      await cubit.setVolume(0.3, save: false);
      expect(engine().volumes.last, 0.3);
      expect(facade.savedLevel, isNull);
      await cubit.setVolume(0.3);
      expect(facade.savedLevel, (volume: 0.3, muted: false));
    });

    test('a muted choice survives a new editor', () async {
      facade.savedLevel = (volume: 0.7, muted: true);
      await cubit.open('m1');
      expect(cubit.state.muted, isTrue);
      expect(engine().volumes, [0.0]);
    });
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

  test('offers eight speeds', () {
    expect(playbackSpeeds, [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2]);
  });

  test('a choice is saved and the next file opens at it', () async {
    await cubit.open('m1');
    await cubit.setSpeed(0.5);
    expect(engine().calls.last, 'speed:0.5');
    expect(facade.saved, 0.5);

    // A new editor page is a new cubit.
    final next = PlayerCubit(facade, engines);
    addTearDown(next.close);
    await next.open('m2');
    expect(next.state.speed, 0.5);
    expect(engine().calls, ['open', 'speed:0.5']);
  });

  test('a saved value the app does not offer is ignored', () async {
    facade.saved = 7;
    await cubit.open('m1');
    expect(cubit.state.speed, 1);
    expect(engine().calls, ['open', 'speed:1.0']);
  });

  test('a choice made before the saved speed is read wins', () async {
    facade.saved = 2;
    await cubit.setSpeed(0.75);
    await cubit.open('m1');
    expect(cubit.state.speed, 0.75);
    expect(facade.saved, 0.75);
  });

  test('a file refusing the remembered speed still opens at 1×', () async {
    facade.saved = 0.25;
    engines.refusedSpeeds = {0.25};
    await cubit.open('m1');
    expect(cubit.state.status, PlayerStatus.ready);
    expect(cubit.state.speed, 1);
    expect(facade.saved, 0.25, reason: 'the next file may play it');
  });

  test('a refused choice shows the speed still playing', () async {
    engines.refusedSpeeds = {0.25};
    await cubit.open('m1');
    await cubit.setSpeed(1.5);
    await cubit.setSpeed(0.25);
    expect(cubit.state.speed, 1.5);
    expect(cubit.state.status, PlayerStatus.ready);
    expect(facade.saved, 0.25);
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

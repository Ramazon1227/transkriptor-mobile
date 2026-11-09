import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/features/player/domain/playback_engine.dart';
import 'package:transkriptor_uz/features/player/infrastructure/engine/youtube_engine.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class _MockController extends Mock implements YoutubePlayerController;

void main() {
  late _MockController c;
  late StreamController<YoutubePlayerValue> values;
  late StreamController<YoutubeVideoState> times;
  late YoutubeEngine engine;
  late List<PlaybackSnapshot> seen;

  setUp(() {
    c = _MockController();
    values = StreamController<YoutubePlayerValue>.broadcast();
    times = StreamController<YoutubeVideoState>.broadcast();
    when(() => c.stream).thenAnswer((_) => values.stream);
    when(() => c.videoStateStream).thenAnswer((_) => times.stream);
    when(() => c.cueVideoById(videoId: any(named: 'videoId')))
        .thenAnswer((_) async {});
    when(() => c.duration).thenAnswer((_) async => 0);
    when(() => c.playVideo()).thenAnswer((_) async {});
    when(() => c.pauseVideo()).thenAnswer((_) async {});
    when(
      () => c.seekTo(
        seconds: any(named: 'seconds'),
        allowSeekAhead: any(named: 'allowSeekAhead'),
      ),
    ).thenAnswer((_) async {});
    when(() => c.setPlaybackRate(any())).thenAnswer((_) async {});
    when(() => c.setVolume(any())).thenAnswer((_) async {});
    when(() => c.close()).thenAnswer((_) async {});
    engine = YoutubeEngine(controller: () => c);
    seen = [];
    engine.snapshots.listen(seen.add);
  });

  tearDown(() async {
    await engine.dispose();
    await values.close();
    await times.close();
  });

  final watch = Uri.parse('https://www.youtube.com/watch?v=jNQXAC9IVRw');

  test('a link that is not YouTube does not open', () async {
    await expectLater(
      engine.open(Uri.parse('https://s3.test/a.m4a')),
      throwsArgumentError,
    );
  });

  test('opens with a picture at once and cues the video id', () async {
    when(() => c.duration).thenAnswer((_) async => 19.5);
    await engine.open(watch);
    await pumpEventQueue();
    expect(seen.first.hasVideo, isTrue);
    verify(() => c.cueVideoById(videoId: 'jNQXAC9IVRw')).called(1);
    expect(seen.last.duration, const Duration(milliseconds: 19500));
  });

  test('player states and time become snapshots', () async {
    await engine.open(watch);
    values.add(
      YoutubePlayerValue(
        playerState: PlayerState.playing,
        metaData: const YoutubeMetaData(duration: Duration(minutes: 3)),
      ),
    );
    times.add(const YoutubeVideoState(position: Duration(seconds: 12)));
    await pumpEventQueue();
    expect(seen.last.playing, isTrue);
    expect(seen.last.position, const Duration(seconds: 12));
    expect(seen.last.duration, const Duration(minutes: 3));

    values.add(YoutubePlayerValue(playerState: PlayerState.buffering));
    await pumpEventQueue();
    expect(seen.last.buffering, isTrue);
    expect(seen.last.playing, isFalse);
    // The length is not forgotten by a value without it.
    expect(seen.last.duration, const Duration(minutes: 3));

    values.add(YoutubePlayerValue(playerState: PlayerState.ended));
    await pumpEventQueue();
    expect(seen.last.completed, isTrue);
  });

  test('error codes group as on the web', () {
    expect(
      [
        YoutubeError.notEmbeddable,
        YoutubeError.sameAsNotEmbeddable,
        YoutubeError.sameAsNotEmbeddable2,
      ].map(YoutubeEngine.failureOf).toSet(),
      {EmbedFailure.blocked},
    );
    expect(
      [
        YoutubeError.videoNotFound,
        YoutubeError.cannotFindVideo,
      ].map(YoutubeEngine.failureOf).toSet(),
      {EmbedFailure.notFound},
    );
    expect(
      [
        YoutubeError.invalidParam,
        YoutubeError.html5Error,
        YoutubeError.unknown,
      ].map(YoutubeEngine.failureOf).toSet(),
      {EmbedFailure.other},
    );
  });

  test('150 (embedding forbidden) is reported once, as final', () async {
    await engine.open(watch);
    values
      ..add(YoutubePlayerValue(error: YoutubeError.fromCode(150)))
      ..add(YoutubePlayerValue(error: YoutubeError.fromCode(150)));
    await pumpEventQueue();
    final failures = seen.where((s) => s.error != null).toList();
    expect(failures, hasLength(1));
    expect(failures.single.embedFailure, EmbedFailure.blocked);
  });

  test('a player that never becomes ready is a failure, not a hang', () async {
    when(() => c.cueVideoById(videoId: any(named: 'videoId')))
        .thenAnswer((_) async => throw TimeoutException('not ready'));
    await engine.open(watch);
    await pumpEventQueue();
    expect(seen.last.embedFailure, EmbedFailure.other);
  });

  test('commands do not wait for the player', () async {
    // Never answers: the WebView is not on screen yet.
    when(() => c.playVideo()).thenAnswer((_) => Completer<void>().future);
    await engine.open(watch);
    await engine.play().timeout(const Duration(seconds: 1));
  });

  test('seek, speed and volume reach the IFrame API in its units', () async {
    await engine.open(watch);
    await engine.seekTo(const Duration(milliseconds: 7250));
    await engine.setSpeed(1.5);
    await engine.setVolume(0.42);
    await engine.pause();
    await pumpEventQueue();
    verify(() => c.seekTo(seconds: 7.25, allowSeekAhead: true)).called(1);
    verify(() => c.setPlaybackRate(1.5)).called(1);
    verify(() => c.setVolume(42)).called(1);
    verify(() => c.pauseVideo()).called(1);
    // A paused player reports no time; the seek is kept.
    expect(seen.last.position, const Duration(milliseconds: 7250));
  });

  test('dispose does not wait for the player to stop', () async {
    when(() => c.close()).thenAnswer((_) => Completer<void>().future);
    await engine.open(watch);
    await engine.dispose().timeout(const Duration(seconds: 1));
  });
}

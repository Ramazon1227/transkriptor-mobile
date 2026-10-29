import 'dart:async';

import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/player/domain/entities/playable_media.dart';
import 'package:transkriptor_uz/features/player/domain/i_player_facade.dart';
import 'package:transkriptor_uz/features/player/domain/playback_engine.dart';

/// Answers every media link with [answer] (default: 404, no file).
class FakePlayerFacade implements IPlayerFacade {
  FakePlayerFacade([this.answer = const Left(Failure.server(statusCode: 404))]);

  Either<Failure, PlayableMedia> answer;
  final List<String> shared = [];

  @override
  Future<Either<Failure, PlayableMedia>> mediaSource(String mediaId) async =>
      answer;

  @override
  Future<Either<Failure, Unit>> shareLink(String url) async {
    shared.add(url);
    return const Right(unit);
  }
}

/// A platform-free engine: records calls, reports what the test pushes.
class FakeEngine implements PlaybackEngine {
  final StreamController<PlaybackSnapshot> _out =
      StreamController<PlaybackSnapshot>.broadcast();
  final List<String> calls = [];
  bool failOpen = false;
  Uri? opened;
  bool disposed = false;
  PlaybackSnapshot last = const PlaybackSnapshot(
    duration: Duration(minutes: 1),
  );

  void push(PlaybackSnapshot s) {
    last = s;
    _out.add(s);
  }

  @override
  Stream<PlaybackSnapshot> get snapshots => _out.stream;

  @override
  Future<void> open(Uri url) async {
    calls.add('open');
    if (failOpen) throw Exception('cannot open');
    opened = url;
    push(last);
  }

  @override
  Future<void> play() async {
    calls.add('play');
    push(_copy(playing: true));
  }

  @override
  Future<void> pause() async {
    calls.add('pause');
    push(_copy(playing: false));
  }

  @override
  Future<void> seekTo(Duration position) async {
    calls.add('seek:${position.inMilliseconds}');
    push(_copy(position: position));
  }

  @override
  Future<void> setSpeed(double speed) async => calls.add('speed:$speed');

  @override
  Widget surface() => const SizedBox.expand(key: Key('fake_surface'));

  @override
  Future<void> dispose() async {
    disposed = true;
    await _out.close();
  }

  PlaybackSnapshot _copy({bool? playing, Duration? position}) =>
      PlaybackSnapshot(
        position: position ?? last.position,
        duration: last.duration,
        playing: playing ?? last.playing,
        hasVideo: last.hasVideo,
        aspectRatio: last.aspectRatio,
      );
}

class FakeEngineFactory implements PlaybackEngineFactory {
  final List<FakeEngine> made = [];
  bool failOpen = false;

  @override
  PlaybackEngine create() {
    final e = FakeEngine()..failOpen = failOpen;
    made.add(e);
    return e;
  }
}

/// The editor page takes a [PlayerCubit] from DI; by default it finds no
/// file (404), so tests about the transcript need no player.
void registerEditorFakes({IPlayerFacade? player}) {
  getIt.registerFactory<PlayerCubit>(
    () => PlayerCubit(player ?? FakePlayerFacade(), FakeEngineFactory()),
  );
}

/// Edit mode on (the toolbar's pencil).
Future<void> enterEditMode(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key('transcript_edit_mode')));
  await tester.pumpAndSettle();
}

/// What edit mode opens a segment's editor with.
Future<void> doubleTap(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pump(kDoubleTapMinTime);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

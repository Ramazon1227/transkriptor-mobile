import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart' show Left;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record/record.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/screen_capture_event.dart';
import 'package:transkriptor_uz/features/capture/infrastructure/facades/screen_capture_facade.dart';
import 'package:transkriptor_uz/features/capture/infrastructure/sources/screen_audio_source.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/native/native_capture_channel.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/store/recordings_store.dart';

import '../../helpers/adts.dart';

class _MockSource extends Mock implements ScreenAudioSource;

class _MockRecorder extends Mock implements AudioRecorder;

class _MockNative extends Mock implements NativeCaptureChannel;

void main() {
  late Directory dir;
  late _MockSource source;
  late _MockRecorder recorder;
  late _MockNative native;
  late RecordingsStore store;
  late ScreenCaptureFacade facade;
  late StreamController<Map<String, Object?>> events;
  String? startedPath;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('screen_facade_test');
    source = _MockSource();
    recorder = _MockRecorder();
    native = _MockNative();
    store = RecordingsStore.at(dir, native);
    facade = ScreenCaptureFacade(source, recorder, native, store);
    events = StreamController<Map<String, Object?>>.broadcast();
    startedPath = null;

    when(() => source.isSupported()).thenAnswer((_) async => true);
    when(() => recorder.hasPermission()).thenAnswer((_) async => true);
    when(() => native.requestNotifications()).thenAnswer((_) async => true);
    when(() => native.durationOf(any())).thenAnswer((_) async => null);
    when(
      () => source.start(
        path: any(named: 'path'),
        withMic: any(named: 'withMic'),
      ),
    ).thenAnswer((invocation) async {
      startedPath = invocation.namedArguments[#path] as String;
      File(startedPath!).writeAsBytesSync(adtsFrames(3));
    });
    when(() => source.cancel()).thenAnswer((_) async {});
    when(() => source.events()).thenAnswer((_) => events.stream);
    when(
      () => native.finalize(
        src: any(named: 'src'),
        dst: any(named: 'dst'),
      ),
    ).thenAnswer((invocation) async {
      final dst = invocation.namedArguments[#dst] as String;
      File(dst).writeAsBytesSync([1, 2, 3, 4]);
      return const Duration(seconds: 2);
    });
  });

  tearDown(() async {
    await events.close();
    await dir.delete(recursive: true);
  });

  test('unsupported OS never asks for anything', () async {
    when(() => source.isSupported()).thenAnswer((_) async => false);
    expect(
      await facade.start(withMic: false),
      const Left<Failure, Object>(Failure.capture(CaptureError.unsupported)),
    );
    verifyNever(() => recorder.hasPermission());
  });

  test('a refused microphone is permissionDenied', () async {
    when(() => recorder.hasPermission()).thenAnswer((_) async => false);
    expect(
      await facade.start(withMic: true),
      const Left<Failure, Object>(Failure.permissionDenied()),
    );
  });

  test('native codes map to failures, and the file is removed', () async {
    final cases = {
      CaptureErrorCodes.consentDenied: const Failure.capture(
        CaptureError.consentDenied,
      ),
      CaptureErrorCodes.busy: const Failure.capture(CaptureError.busy),
      CaptureErrorCodes.micPermission: const Failure.permissionDenied(),
      CaptureErrorCodes.captureFailed: const Failure.capture(
        CaptureError.captureFailed,
      ),
      'SOMETHING_NEW': const Failure.capture(CaptureError.captureFailed),
    };
    for (final MapEntry(key: code, value: failure) in cases.entries) {
      when(
        () => source.start(
          path: any(named: 'path'),
          withMic: any(named: 'withMic'),
        ),
      ).thenThrow(PlatformException(code: code));
      expect(
        await facade.start(withMic: false),
        Left<Failure, Object>(failure),
      );
    }
    expect(dir.listSync(), isEmpty);
  });

  test('starts into the recordings folder and stops with the .m4a', () async {
    expect((await facade.start(withMic: true)).isRight(), isTrue);
    expect(startedPath, startsWith('${dir.path}/screen_'));
    expect(startedPath, endsWith('.aac'));
    // While running it is not offered for recovery.
    expect(await store.list(), isEmpty);

    final m4a = RecordingsStore.finishedPath(startedPath!);
    when(() => source.stop()).thenAnswer((_) async {
      File(m4a).writeAsBytesSync([1, 2, 3]);
      File(startedPath!).deleteSync();
      return (path: m4a, durationMs: 4000);
    });
    final recording = (await facade.stop()).getOrElse(
      () => throw StateError('none'),
    );
    expect(recording.path, m4a);
    expect(recording.sizeBytes, 3);
    expect(recording.duration, const Duration(seconds: 4));
  });

  test('a native .aac answer (remux failed there) is remuxed here', () async {
    await facade.start(withMic: false);
    when(() => source.stop())
        .thenAnswer((_) async => (path: startedPath!, durationMs: 100));
    final recording = (await facade.stop()).getOrElse(
      () => throw StateError('none'),
    );
    expect(recording.path, endsWith('.m4a'));
    expect(recording.duration, const Duration(seconds: 2));
  });

  test('cancel deletes the file', () async {
    await facade.start(withMic: false);
    await facade.cancel();
    verify(() => source.cancel()).called(1);
    expect(dir.listSync(), isEmpty);
  });

  test('events: level, silent, ended from the notification', () async {
    await facade.start(withMic: false);
    final m4a = RecordingsStore.finishedPath(startedPath!);
    final got = <ScreenCaptureEvent>[];
    final sub = facade.events().listen(got.add);
    events
      ..add({'event': 'level', 'level': 1.7, 'elapsedMs': 1200})
      ..add({'event': 'silent'});
    File(m4a).writeAsBytesSync([9, 9]);
    events.add({'event': 'ended', 'path': m4a, 'durationMs': 1200});
    await Future<void>.delayed(const Duration(milliseconds: 20));
    await sub.cancel();

    expect(
      got[0],
      const ScreenCaptureEvent.level(
        level: 1,
        elapsed: Duration(milliseconds: 1200),
      ),
    );
    expect(got[1], const ScreenCaptureEvent.silent());
    final ended = got[2] as ScreenCaptureEnded;
    expect(ended.recording?.path, m4a);
    expect(ended.failure, isNull);
  });

  test('ended with an error and no file is a failure', () async {
    final got = <ScreenCaptureEvent>[];
    final sub = facade.events().listen(got.add);
    events.add({'event': 'ended', 'error': CaptureErrorCodes.captureFailed});
    await Future<void>.delayed(const Duration(milliseconds: 20));
    await sub.cancel();
    expect(
      got.single,
      const ScreenCaptureEvent.ended(
        failure: Failure.capture(CaptureError.captureFailed),
      ),
    );
  });

  test('current() finds a capture that outlived the app UI', () async {
    when(() => source.status()).thenAnswer(
      (_) async => {'path': '/s.aac', 'elapsedMs': 61000, 'withMic': true},
    );
    final session = await facade.current();
    expect(session?.elapsed, const Duration(seconds: 61));
    expect(session?.withMic, isTrue);
    when(() => source.status()).thenAnswer((_) async => null);
    expect(await facade.current(), isNull);
  });
}

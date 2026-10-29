import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/capture/application/screen_capture_cubit.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/screen_capture_event.dart';
import 'package:transkriptor_uz/features/capture/domain/i_screen_capture_facade.dart';
import 'package:transkriptor_uz/features/recorder/application/recorder_cubit.dart'
    show recorderMeterLength;
import 'package:transkriptor_uz/features/recorder/domain/entities/recording.dart';

class _MockFacade extends Mock implements IScreenCaptureFacade;

const _recording = Recording(
  path: '/s.m4a',
  sizeBytes: 10,
  duration: Duration(seconds: 3),
);

void main() {
  late _MockFacade facade;
  late StreamController<ScreenCaptureEvent> events;

  setUp(() {
    facade = _MockFacade();
    events = StreamController<ScreenCaptureEvent>.broadcast();
    when(() => facade.isSupported()).thenAnswer((_) async => true);
    when(() => facade.current()).thenAnswer((_) async => null);
    when(() => facade.events()).thenAnswer((_) => events.stream);
    when(() => facade.start(withMic: any(named: 'withMic')))
        .thenAnswer((_) async => const Right(unit));
    when(() => facade.stop()).thenAnswer((_) async => const Right(_recording));
    when(() => facade.cancel()).thenAnswer((_) async {});
  });

  tearDown(() => events.close());

  blocTest<ScreenCaptureCubit, ScreenCaptureState>(
    'init on an unsupported phone says so',
    setUp: () =>
        when(() => facade.isSupported()).thenAnswer((_) async => false),
    build: () => ScreenCaptureCubit(facade),
    act: (c) => c.init(),
    expect: () => const [ScreenCaptureState(supported: false)],
    verify: (_) => verifyNever(() => facade.current()),
  );

  blocTest<ScreenCaptureCubit, ScreenCaptureState>(
    'init picks up a capture still running',
    setUp: () => when(() => facade.current()).thenAnswer(
      (_) async => const ScreenCaptureSession(
        elapsed: Duration(seconds: 9),
        withMic: true,
      ),
    ),
    build: () => ScreenCaptureCubit(facade),
    act: (c) => c.init(),
    expect: () => const [
      ScreenCaptureState(supported: true),
      ScreenCaptureState(
        supported: true,
        status: ScreenCaptureStatus.recording,
        elapsed: Duration(seconds: 9),
        withMic: true,
      ),
    ],
  );

  blocTest<ScreenCaptureCubit, ScreenCaptureState>(
    'a refused consent is a failure',
    setUp: () => when(() => facade.start(withMic: any(named: 'withMic')))
        .thenAnswer(
          (_) async => const Left(Failure.capture(CaptureError.consentDenied)),
        ),
    build: () => ScreenCaptureCubit(facade),
    act: (c) => c.start(withMic: false),
    expect: () => const [
      ScreenCaptureState(status: ScreenCaptureStatus.starting),
      ScreenCaptureState(
        status: ScreenCaptureStatus.failure,
        failure: Failure.capture(CaptureError.consentDenied),
      ),
    ],
  );

  test(
    'records, meters, warns about silence and stops with the file',
    () async {
      final cubit = ScreenCaptureCubit(facade);
      await cubit.start(withMic: true);
      expect(cubit.state.status, ScreenCaptureStatus.recording);
      expect(cubit.state.withMic, isTrue);

      for (var i = 0; i < recorderMeterLength + 2; i++) {
        events.add(
          ScreenCaptureEvent.level(
            level: i / 100,
            elapsed: Duration(seconds: i),
          ),
        );
      }
      events.add(const ScreenCaptureEvent.silent());
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.levels, hasLength(recorderMeterLength));
      expect(
        cubit.state.elapsed,
        const Duration(seconds: recorderMeterLength + 1),
      );
      expect(cubit.state.playbackSilent, isTrue);

      await cubit.stop();
      expect(cubit.state.status, ScreenCaptureStatus.done);
      expect(cubit.state.recording, _recording);
      await cubit.close();
      verifyNever(() => facade.cancel());
    },
  );

  test('stopped from the notification ends as done', () async {
    final cubit = ScreenCaptureCubit(facade);
    await cubit.start(withMic: false);
    events.add(const ScreenCaptureEvent.ended(recording: _recording));
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state.status, ScreenCaptureStatus.done);
    expect(cubit.state.recording, _recording);
    await cubit.close();
  });

  test('ended by a failure without a file is a failure', () async {
    final cubit = ScreenCaptureCubit(facade);
    await cubit.start(withMic: false);
    events.add(
      const ScreenCaptureEvent.ended(
        failure: Failure.capture(CaptureError.captureFailed),
      ),
    );
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state.status, ScreenCaptureStatus.failure);
    expect(
      cubit.state.failure,
      const Failure.capture(CaptureError.captureFailed),
    );
    await cubit.close();
  });

  test('closing mid-capture cancels it', () async {
    final cubit = ScreenCaptureCubit(facade);
    await cubit.start(withMic: false);
    await cubit.close();
    verify(() => facade.cancel()).called(1);
  });

  test('cancel resets but remembers support', () async {
    final cubit = ScreenCaptureCubit(facade);
    await cubit.init();
    await cubit.start(withMic: false);
    await cubit.cancel();
    expect(cubit.state, const ScreenCaptureState(supported: true));
    verify(() => facade.cancel()).called(1);
    await cubit.close();
  });
}

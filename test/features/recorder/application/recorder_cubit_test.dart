import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/recorder/application/recorder_cubit.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recording.dart';
import 'package:transkriptor_uz/features/recorder/domain/i_recorder_facade.dart';

class _MockRecorderFacade extends Mock implements IRecorderFacade;

void main() {
  late _MockRecorderFacade facade;
  late StreamController<double> levels;
  late StreamController<RecorderInterruption> interruptions;

  setUpAll(() => registerFallbackValue(Duration.zero));

  setUp(() {
    facade = _MockRecorderFacade();
    levels = StreamController<double>.broadcast();
    when(() => facade.levels()).thenAnswer((_) => levels.stream);
    interruptions = StreamController<RecorderInterruption>.broadcast();
    when(() => facade.interruptions()).thenAnswer((_) => interruptions.stream);
    when(() => facade.start()).thenAnswer((_) async => const Right(unit));
    when(() => facade.pause()).thenAnswer((_) async => const Right(unit));
    when(() => facade.resume()).thenAnswer((_) async => const Right(unit));
    when(() => facade.discard()).thenAnswer((_) async {});
    // close() mid-recording keeps the file (R-4).
    when(() => facade.stop(duration: any(named: 'duration'))).thenAnswer(
      (_) async => const Right(
        Recording(path: '/r.m4a', sizeBytes: 1000, duration: Duration.zero),
      ),
    );
  });

  tearDown(() async {
    await levels.close();
    await interruptions.close();
  });

  group('RecorderCubit', () {
    blocTest<RecorderCubit, RecorderState>(
      'a refused microphone is a failure, not a recording',
      setUp: () =>
          when(() => facade.start())
              .thenAnswer((_) async => const Left(Failure.permissionDenied())),
      build: () => RecorderCubit(facade),
      act: (cubit) => cubit.start(),
      expect: () => const [
        RecorderState(status: RecorderStatus.starting),
        RecorderState(
          status: RecorderStatus.failure,
          failure: Failure.permissionDenied(),
        ),
      ],
    );

    test('records, pauses, resumes and stops with the file', () async {
      when(() => facade.stop(duration: any(named: 'duration'))).thenAnswer(
        (invocation) async => Right(
          Recording(
            path: '/r.m4a',
            sizeBytes: 1000,
            duration: invocation.namedArguments[#duration] as Duration,
          ),
        ),
      );
      final cubit = RecorderCubit(facade);

      await cubit.start();
      expect(cubit.state.status, RecorderStatus.recording);

      levels.add(0.4);
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.levels, [0.4]);

      await cubit.togglePause();
      expect(cubit.state.status, RecorderStatus.paused);
      // Levels while paused are not drawn.
      levels.add(0.9);
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.levels, [0.4]);

      await cubit.togglePause();
      expect(cubit.state.status, RecorderStatus.recording);

      await cubit.stop();
      expect(cubit.state.status, RecorderStatus.done);
      expect(cubit.state.recording?.path, '/r.m4a');
      verify(() => facade.pause()).called(1);
      verify(() => facade.resume()).called(1);
      await cubit.close();
    });

    test('the meter keeps only the most recent samples', () async {
      final cubit = RecorderCubit(facade);
      await cubit.start();
      for (var i = 0; i < recorderMeterLength + 5; i++) {
        levels.add(i / 100);
      }
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.levels, hasLength(recorderMeterLength));
      expect(cubit.state.levels.last, (recorderMeterLength + 4) / 100);
      await cubit.close();
    });

    test('closing mid-recording turns the microphone off and keeps the file '
        '(R-4)', () async {
      final cubit = RecorderCubit(facade);
      await cubit.start();
      await cubit.close();
      verify(() => facade.stop(duration: any(named: 'duration'))).called(1);
      verifyNever(() => facade.discard());
    });

    test('closing while stop() runs does not stop the file twice', () async {
      final cubit = RecorderCubit(facade);
      await cubit.start();
      final stopping = cubit.stop();
      await cubit.close();
      await stopping;
      verify(() => facade.stop(duration: any(named: 'duration'))).called(1);
    });

    test(
      'a call pauses the recording visibly; resume clears it (MB-10)',
      () async {
        final cubit = RecorderCubit(facade);
        await cubit.start();
        interruptions.add(RecorderInterruption.paused);
        await Future<void>.delayed(Duration.zero);
        expect(cubit.state.status, RecorderStatus.paused);
        expect(cubit.state.interrupted, isTrue);
        // The clock stopped with the microphone.
        final at = cubit.state.elapsed;
        await Future<void>.delayed(const Duration(milliseconds: 250));
        expect(cubit.state.elapsed, at);

        await cubit.togglePause();
        expect(cubit.state.status, RecorderStatus.recording);
        expect(cubit.state.interrupted, isFalse);
        verify(() => facade.resume()).called(1);
        verifyNever(() => facade.pause());
        await cubit.close();
      },
    );

    test('a call during the start is not missed', () async {
      when(() => facade.start()).thenAnswer((_) async {
        interruptions.add(RecorderInterruption.paused);
        await Future<void>.delayed(Duration.zero);
        return const Right(unit);
      });
      final cubit = RecorderCubit(facade);
      await cubit.start();
      expect(cubit.state.status, RecorderStatus.paused);
      expect(cubit.state.interrupted, isTrue);
      await cubit.close();
    });

    test(
      'a new call while resuming leaves it paused, not «recording»',
      () async {
        final cubit = RecorderCubit(facade);
        await cubit.start();
        interruptions.add(RecorderInterruption.paused);
        await Future<void>.delayed(Duration.zero);
        when(() => facade.resume()).thenAnswer((_) async {
          interruptions.add(RecorderInterruption.paused);
          await Future<void>.delayed(Duration.zero);
          return const Right(unit);
        });
        await cubit.togglePause();
        expect(cubit.state.status, RecorderStatus.paused);
        expect(cubit.state.interrupted, isTrue);
        await cubit.close();
      },
    );

    test('the capture ending while interrupted still keeps the file', () async {
      final cubit = RecorderCubit(facade);
      await cubit.start();
      interruptions
        ..add(RecorderInterruption.paused)
        ..add(RecorderInterruption.stopped);
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.status, RecorderStatus.done);
      await cubit.close();
    });

    test('an interruption while paused by the user changes nothing', () async {
      final cubit = RecorderCubit(facade);
      await cubit.start();
      await cubit.togglePause();
      interruptions.add(RecorderInterruption.paused);
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.status, RecorderStatus.paused);
      expect(cubit.state.interrupted, isFalse);
      await cubit.close();
    });

    test('a capture the phone ended is saved, not left hanging', () async {
      final cubit = RecorderCubit(facade);
      await cubit.start();
      interruptions.add(RecorderInterruption.stopped);
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.status, RecorderStatus.done);
      verify(() => facade.stop(duration: any(named: 'duration'))).called(1);
      verifyNever(() => facade.discard());
      await cubit.close();
    });

    test('discard resets to idle', () async {
      final cubit = RecorderCubit(facade);
      await cubit.start();
      await cubit.discard();
      expect(cubit.state, const RecorderState());
      verify(() => facade.discard()).called(1);
      await cubit.close();
    });
  });
}

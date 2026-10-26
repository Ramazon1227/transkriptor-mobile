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

  setUpAll(() => registerFallbackValue(Duration.zero));

  setUp(() {
    facade = _MockRecorderFacade();
    levels = StreamController<double>.broadcast();
    when(() => facade.levels()).thenAnswer((_) => levels.stream);
    when(() => facade.start()).thenAnswer((_) async => const Right(unit));
    when(() => facade.pause()).thenAnswer((_) async => const Right(unit));
    when(() => facade.resume()).thenAnswer((_) async => const Right(unit));
    when(() => facade.discard()).thenAnswer((_) async {});
  });

  tearDown(() => levels.close());

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

    test('closing mid-recording turns the microphone off', () async {
      final cubit = RecorderCubit(facade);
      await cubit.start();
      await cubit.close();
      verify(() => facade.discard()).called(1);
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

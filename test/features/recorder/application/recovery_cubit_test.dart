import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/recorder/application/recovery_cubit.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recoverable_recording.dart';
import 'package:transkriptor_uz/features/recorder/domain/i_recorder_facade.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/pending_file.dart';

class _MockFacade extends Mock implements IRecorderFacade;

final RecoverableRecording _a = RecoverableRecording(
  path: '/a.aac',
  kind: RecordingKind.microphone,
  state: RecordingCompletion.interrupted,
  createdAt: DateTime(2026, 10, 29),
  sizeBytes: 100,
  duration: const Duration(seconds: 3),
);
final RecoverableRecording _b = _a.copyWith(
  path: '/b.m4a',
  state: RecordingCompletion.finished,
);
const _file = PendingFile(
  path: '/a.m4a',
  fileName: 'Yozuv.m4a',
  sizeBytes: 100,
  source: UploadSource.recording,
);

void main() {
  late _MockFacade facade;

  setUpAll(() => registerFallbackValue(_a));

  setUp(() {
    facade = _MockFacade();
    when(() => facade.recoverable()).thenAnswer((_) async => Right([_a, _b]));
  });

  blocTest<RecoveryCubit, RecoveryState>(
    'loads the leftovers',
    build: () => RecoveryCubit(facade),
    act: (c) => c.load(),
    expect: () => [
      const RecoveryState(status: RecoveryStatus.loading),
      RecoveryState(status: RecoveryStatus.success, items: [_a, _b]),
    ],
  );

  blocTest<RecoveryCubit, RecoveryState>(
    'nothing left is empty, not an error',
    setUp: () =>
        when(() => facade.recoverable())
            .thenAnswer((_) async => const Right([])),
    build: () => RecoveryCubit(facade),
    act: (c) => c.load(),
    expect: () => const [
      RecoveryState(status: RecoveryStatus.loading),
      RecoveryState(status: RecoveryStatus.empty),
    ],
  );

  blocTest<RecoveryCubit, RecoveryState>(
    'a failed listing is a failure',
    setUp: () =>
        when(() => facade.recoverable())
            .thenAnswer((_) async => const Left(Failure.storage())),
    build: () => RecoveryCubit(facade),
    act: (c) => c.load(),
    expect: () => const [
      RecoveryState(status: RecoveryStatus.loading),
      RecoveryState(status: RecoveryStatus.failure, failure: Failure.storage()),
    ],
  );

  blocTest<RecoveryCubit, RecoveryState>(
    'recover hands out the file and drops the row',
    setUp: () =>
        when(() => facade.recover(any(), title: 'Yozuv'))
            .thenAnswer((_) async => const Right(_file)),
    build: () => RecoveryCubit(facade),
    seed: () => RecoveryState(status: RecoveryStatus.success, items: [_a, _b]),
    act: (c) => c.recover(_a, title: 'Yozuv'),
    expect: () => [
      RecoveryState(
        status: RecoveryStatus.success,
        items: [_a, _b],
        busyPath: _a.path,
      ),
      RecoveryState(status: RecoveryStatus.success, items: [_b]),
      RecoveryState(
        status: RecoveryStatus.success,
        items: [_b],
        recovered: _file,
      ),
    ],
  );

  blocTest<RecoveryCubit, RecoveryState>(
    'a failed recover keeps the row',
    setUp: () =>
        when(() => facade.recover(any(), title: any(named: 'title')))
            .thenAnswer((_) async => const Left(Failure.storage())),
    build: () => RecoveryCubit(facade),
    seed: () => RecoveryState(status: RecoveryStatus.success, items: [_a]),
    act: (c) => c.recover(_a, title: 'x'),
    skip: 1,
    expect: () => [
      RecoveryState(
        status: RecoveryStatus.success,
        items: [_a],
        failure: const Failure.storage(),
      ),
    ],
  );

  blocTest<RecoveryCubit, RecoveryState>(
    'discarding the last one leaves it empty',
    setUp: () =>
        when(() => facade.discardRecoverable(any()))
            .thenAnswer((_) async => const Right(unit)),
    build: () => RecoveryCubit(facade),
    seed: () => RecoveryState(status: RecoveryStatus.success, items: [_a]),
    act: (c) => c.discard(_a),
    skip: 1,
    expect: () => const [RecoveryState(status: RecoveryStatus.empty)],
  );
}

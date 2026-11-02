import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/error/held_file.dart';
import 'package:transkriptor_uz/features/upload/application/held_files_cubit.dart';
import 'package:transkriptor_uz/features/upload/domain/i_upload_facade.dart';

class _MockFacade extends Mock implements IUploadFacade;

const _a = HeldFile(
  id: 'a',
  name: 'a.mp3',
  state: HeldFileState.failed,
  sizeBytes: 1,
  deletable: true,
);
const _b = HeldFile(
  id: 'b',
  name: 'b.mp3',
  state: HeldFileState.waiting,
  sizeBytes: 1,
  deletable: true,
);

void main() {
  late _MockFacade facade;
  late HeldFilesCubit cubit;

  setUp(() {
    facade = _MockFacade();
    cubit = HeldFilesCubit(facade)..open(const [_a, _b]);
  });
  tearDown(() => cubit.close());

  test('a deleted file leaves the list', () async {
    when(() => facade.deleteHeld('a'))
        .thenAnswer((_) async => const Right(unit));
    await cubit.delete('a');
    expect(cubit.state.items, const [_b]);
    expect(cubit.state.deletingId, isNull);
  });

  test('a refused delete keeps the file and says why', () async {
    when(() => facade.deleteHeld('a'))
        .thenAnswer((_) async => const Left(Failure.network()));
    await cubit.delete('a');
    expect(cubit.state.items, const [_a, _b]);
    expect(cubit.state.failure, const Failure.network());
    expect(cubit.state.deletingId, isNull);
  });

  test('a second delete waits for the first', () async {
    when(() => facade.deleteHeld(any()))
        .thenAnswer((_) async => const Right(unit));
    await Future.wait([cubit.delete('a'), cubit.delete('b')]);
    verify(() => facade.deleteHeld('a')).called(1);
    verifyNever(() => facade.deleteHeld('b'));
  });
}

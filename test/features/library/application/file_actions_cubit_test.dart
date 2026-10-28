import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/library/application/file_actions_cubit.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';
import 'package:transkriptor_uz/features/library/domain/tag_rules.dart';

class _MockLibraryFacade extends Mock implements ILibraryFacade;

void main() {
  late _MockLibraryFacade facade;
  late LibraryChanges changes;

  const item = LibraryItem(mediaId: 'm1', name: 'A', folderId: 'f1');

  setUp(() {
    facade = _MockLibraryFacade();
    changes = LibraryChanges();
  });

  tearDown(() => changes.dispose());

  blocTest<FileActionsCubit, FileActionsState>(
    'a move to root sends null and tells the library',
    setUp: () => when(() => facade.moveToFolder(mediaId: 'm1', folderId: null))
        .thenAnswer(
          (_) async => const Right(LibraryItem(mediaId: 'm1', name: 'A')),
        ),
    build: () => FileActionsCubit(facade, changes),
    act: (cubit) async {
      final notified = changes.stream.first;
      await cubit.move(item, null);
      await notified;
    },
    expect: () => const [
      FileActionsState(status: FileActionStatus.busy),
      FileActionsState(
        status: FileActionStatus.done,
        item: LibraryItem(mediaId: 'm1', name: 'A'),
      ),
    ],
  );

  blocTest<FileActionsCubit, FileActionsState>(
    'a move to the folder it is already in sends nothing',
    build: () => FileActionsCubit(facade, changes),
    act: (cubit) => cubit.move(item, 'f1'),
    expect: () => const [
      FileActionsState(status: FileActionStatus.done, item: item),
    ],
    verify: (_) => verifyNever(
      () => facade.moveToFolder(
        mediaId: any(named: 'mediaId'),
        folderId: any(named: 'folderId'),
      ),
    ),
  );

  blocTest<FileActionsCubit, FileActionsState>(
    'a failed tag save stays on the sheet',
    setUp: () => when(() => facade.setTags(mediaId: 'm1', tags: ['sud']))
        .thenAnswer((_) async => const Left(Failure.server(statusCode: 403))),
    build: () => FileActionsCubit(facade, changes),
    act: (cubit) => cubit.setTags(item, ['sud']),
    expect: () => const [
      FileActionsState(status: FileActionStatus.busy),
      FileActionsState(
        status: FileActionStatus.failure,
        failure: Failure.server(statusCode: 403),
      ),
    ],
  );

  group('TagRules mirrors models.NormalizeTags', () {
    test('lower case, inner spaces collapsed', () {
      expect(TagRules.normalize('  Sud   Ishlari '), 'sud ishlari');
      expect(TagRules.normalize('ОЛИЙ'), 'олий');
    });

    test('empty, a comma or more than 32 characters is refused', () {
      expect(TagRules.normalize('   '), isNull);
      expect(TagRules.normalize('a,b'), isNull);
      // 32 Cyrillic letters are 64 bytes but 32 characters: allowed.
      expect(TagRules.normalize('ж' * 32), 'ж' * 32);
      expect(TagRules.normalize('ж' * 33), isNull);
    });

    test('folder names: trimmed, 1–80 characters', () {
      expect(FolderRules.normalize('  Sud '), 'Sud');
      expect(FolderRules.normalize(' '), isNull);
      expect(FolderRules.normalize('a' * 81), isNull);
    });
  });
}

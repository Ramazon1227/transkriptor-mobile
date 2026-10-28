import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/features/library/application/folders_cubit.dart';
import 'package:transkriptor_uz/features/library/domain/entities/folder.dart';
import 'package:transkriptor_uz/features/library/domain/i_library_facade.dart';

class _MockLibraryFacade extends Mock implements ILibraryFacade;

void main() {
  late _MockLibraryFacade facade;
  late LibraryChanges changes;

  const sud = Folder(id: 'f1', name: 'Sud', fileCount: 2);

  setUp(() {
    facade = _MockLibraryFacade();
    changes = LibraryChanges();
    when(() => facade.getFolders(workspaceId: 'w1'))
        .thenAnswer((_) async => const Right([sud]));
  });

  tearDown(() => changes.dispose());

  blocTest<FoldersCubit, FoldersState>(
    'loads the folders',
    build: () => FoldersCubit(facade, changes),
    act: (cubit) => cubit.load('w1'),
    expect: () => const [
      FoldersState(status: FoldersStatus.loading),
      FoldersState(status: FoldersStatus.success, folders: [sud]),
    ],
  );

  blocTest<FoldersCubit, FoldersState>(
    'no folders is empty, not failure',
    setUp: () =>
        when(() => facade.getFolders(workspaceId: 'w1'))
            .thenAnswer((_) async => const Right(<Folder>[])),
    build: () => FoldersCubit(facade, changes),
    act: (cubit) => cubit.load('w1'),
    skip: 1,
    expect: () => const [FoldersState(status: FoldersStatus.empty)],
  );

  blocTest<FoldersCubit, FoldersState>(
    'a create tells the library, which reloads the folders too',
    setUp: () =>
        when(() => facade.createFolder(workspaceId: 'w1', name: 'Sud'))
            .thenAnswer((_) async => const Right(sud)),
    build: () => FoldersCubit(facade, changes),
    act: (cubit) async {
      await cubit.load('w1');
      final notified = changes.stream.first;
      await cubit.create('Sud');
      await notified;
      await Future<void>.delayed(Duration.zero);
    },
    skip: 2,
    expect: () => const [
      FoldersState(
        status: FoldersStatus.success,
        folders: [sud],
        actionStatus: FolderActionStatus.busy,
      ),
      FoldersState(status: FoldersStatus.success, folders: [sud]),
    ],
    verify: (_) => verify(() => facade.getFolders(workspaceId: 'w1')).called(2),
  );

  blocTest<FoldersCubit, FoldersState>(
    'a 409 stays as the action failure; the list is kept',
    setUp: () => when(
      () => facade.renameFolder(workspaceId: 'w1', folderId: 'f1', name: 'X'),
    ).thenAnswer((_) async => const Left(Failure.server(statusCode: 409))),
    build: () => FoldersCubit(facade, changes),
    act: (cubit) async {
      await cubit.load('w1');
      await cubit.rename('f1', 'X');
    },
    skip: 3,
    expect: () => const [
      FoldersState(
        status: FoldersStatus.success,
        folders: [sud],
        actionStatus: FolderActionStatus.failure,
        actionFailure: Failure.server(statusCode: 409),
      ),
    ],
  );

  blocTest<FoldersCubit, FoldersState>(
    'a delete runs once even if tapped twice',
    setUp: () =>
        when(() => facade.deleteFolder(workspaceId: 'w1', folderId: 'f1'))
            .thenAnswer((_) async => const Right(unit)),
    build: () => FoldersCubit(facade, changes),
    act: (cubit) async {
      await cubit.load('w1');
      await Future.wait([cubit.delete('f1'), cubit.delete('f1')]);
    },
    verify: (_) =>
        verify(() => facade.deleteFolder(workspaceId: 'w1', folderId: 'f1'))
            .called(1),
  );

  blocTest<FoldersCubit, FoldersState>(
    'a failed reload keeps the folders on screen',
    build: () => FoldersCubit(facade, changes),
    act: (cubit) async {
      await cubit.load('w1');
      when(() => facade.getFolders(workspaceId: 'w1'))
          .thenAnswer((_) async => const Left(Failure.network()));
      changes.notify();
      await Future<void>.delayed(Duration.zero);
    },
    skip: 2,
    expect: () => const [
      FoldersState(
        status: FoldersStatus.success,
        folders: [sud],
        failure: Failure.network(),
      ),
    ],
  );
}

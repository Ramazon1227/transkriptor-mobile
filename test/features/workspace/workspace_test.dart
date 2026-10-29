import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/workspace/application/workspace_list_cubit.dart';
import 'package:transkriptor_uz/features/workspace/domain/i_workspace_facade.dart';
import 'package:transkriptor_uz/features/workspace/infrastructure/facades/workspace_facade.dart';
import 'package:transkriptor_uz/features/workspace/infrastructure/repositories/workspace_repository.dart';
import 'package:transkriptor_uz/features/workspace/infrastructure/storage/workspace_selection_storage.dart';

import '../../helpers/fake_http_adapter.dart';

class _MockFacade extends Mock implements IWorkspaceFacade;

class _MockStorage extends Mock implements WorkspaceSelectionStorage;

void main() {
  group('WorkspaceRepository + facade', () {
    test('GET /workspaces parses role and plan', () async {
      final http = FakeHttpAdapter({
        'GET /api/v1/workspaces': (
          200,
          ok({
            'items': [
              {
                'id': 'p',
                'name': 'Shaxsiy',
                'is_personal': true,
                'balance_seconds': 600,
                'role': 'OWNER',
                'plan': {'code': 'pro', 'name': 'Pro', 'max_members': 1},
              },
              {'id': 't', 'name': 'Jamoa', 'role': 'SUPERUSER'},
            ],
          }),
        ),
      });
      final facade = WorkspaceFacade(
        WorkspaceRepository(fakeDio(http)),
        _MockStorage(),
      );

      final list = (await facade.listWorkspaces()).getOrElse(
        () => throw StateError('left'),
      );

      expect(list.first.role, WorkspaceRole.owner);
      expect(list.first.planName, 'Pro');
      expect(list.first.role.canManage, isTrue);
      // An unknown role is the least privileged, not a crash.
      expect(list.last.role, WorkspaceRole.unknown);
      expect(list.last.role.canWrite, isFalse);
    });

    test('an unreadable store means no selection', () async {
      final storage = _MockStorage();
      when(storage.read).thenThrow(Exception('keychain'));
      final facade = WorkspaceFacade(
        WorkspaceRepository(fakeDio(FakeHttpAdapter({}))),
        storage,
      );
      expect(await facade.selectedWorkspaceId(), isNull);
    });
  });

  group('WorkspaceListCubit', () {
    late _MockFacade facade;
    const items = [Workspace(id: 'p', name: 'S', isPersonal: true)];

    setUp(() => facade = _MockFacade());

    blocTest<WorkspaceListCubit, WorkspaceListState>(
      'loads the list',
      setUp: () =>
          when(() => facade.listWorkspaces())
              .thenAnswer((_) async => const Right(items)),
      build: () => WorkspaceListCubit(facade),
      act: (cubit) => cubit.load(),
      expect: () => const [
        WorkspaceListState(status: WorkspaceListStatus.loading),
        WorkspaceListState(status: WorkspaceListStatus.success, items: items),
      ],
    );

    blocTest<WorkspaceListCubit, WorkspaceListState>(
      'an empty list is empty, not an error',
      setUp: () =>
          when(() => facade.listWorkspaces())
              .thenAnswer((_) async => const Right(<Workspace>[])),
      build: () => WorkspaceListCubit(facade),
      act: (cubit) => cubit.load(),
      skip: 1,
      expect: () => const [
        WorkspaceListState(status: WorkspaceListStatus.empty),
      ],
    );

    blocTest<WorkspaceListCubit, WorkspaceListState>(
      'a failure is kept for the retry view',
      setUp: () =>
          when(() => facade.listWorkspaces())
              .thenAnswer((_) async => const Left(Failure.network())),
      build: () => WorkspaceListCubit(facade),
      act: (cubit) => cubit.load(),
      skip: 1,
      expect: () => const [
        WorkspaceListState(
          status: WorkspaceListStatus.failure,
          failure: Failure.network(),
        ),
      ],
    );
  });
}

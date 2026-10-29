import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Either, Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/core/network/session_manager.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';
import 'package:transkriptor_uz/features/push/domain/i_push_facade.dart';
import 'package:transkriptor_uz/features/workspace/domain/i_workspace_facade.dart';

class _MockAuthFacade extends Mock implements IAuthFacade;

class _MockPushFacade extends Mock implements IPushFacade;

class _MockWorkspaceFacade extends Mock implements IWorkspaceFacade;

void main() {
  late _MockAuthFacade facade;
  late LibraryChanges changes;
  late SessionManager session;
  late _MockPushFacade push;
  late _MockWorkspaceFacade workspaces;

  const before = Account(
    user: AppUser(id: 'u1', email: 'e'),
    workspaces: [Workspace(id: 'w1', name: 'S', balanceSeconds: 600)],
  );
  const after = Account(
    user: AppUser(id: 'u1', email: 'e'),
    workspaces: [Workspace(id: 'w1', name: 'S', balanceSeconds: 120)],
  );

  setUp(() {
    facade = _MockAuthFacade();
    changes = LibraryChanges();
    session = SessionManager();
    push = _MockPushFacade();
    when(() => push.unregister()).thenAnswer((_) async {});
    workspaces = _MockWorkspaceFacade();
    when(() => workspaces.selectedWorkspaceId()).thenAnswer((_) async => null);
    when(() => workspaces.saveSelectedWorkspaceId(any()))
        .thenAnswer((_) async => const Right(unit));
    when(() => workspaces.clearSelectedWorkspace()).thenAnswer((_) async {});
  });

  tearDown(() => changes.dispose());

  group('AccountCubit', () {
    blocTest<AccountCubit, AccountState>(
      'loads the account',
      setUp: () =>
          when(() => facade.loadAccount())
              .thenAnswer((_) async => const Right(before)),
      build: () => AccountCubit(facade, changes, session, push, workspaces),
      act: (cubit) => cubit.load(),
      expect: () => const [
        AccountState(status: AccountStatus.loading),
        AccountState(status: AccountStatus.success, account: before),
      ],
    );

    blocTest<AccountCubit, AccountState>(
      'keeps the last account when a reload fails',
      setUp: () =>
          when(() => facade.loadAccount())
              .thenAnswer((_) async => const Left(Failure.network())),
      build: () => AccountCubit(facade, changes, session, push, workspaces),
      seed: () =>
          const AccountState(status: AccountStatus.success, account: before),
      act: (cubit) => cubit.load(),
      expect: () => const [
        AccountState(status: AccountStatus.loading, account: before),
        AccountState(
          status: AccountStatus.failure,
          account: before,
          failure: Failure.network(),
        ),
      ],
    );

    blocTest<AccountCubit, AccountState>(
      'reloads the balance when the library changes',
      setUp: () =>
          when(() => facade.loadAccount())
              .thenAnswer((_) async => const Right(after)),
      build: () => AccountCubit(facade, changes, session, push, workspaces),
      seed: () =>
          const AccountState(status: AccountStatus.success, account: before),
      act: (_) => changes.notify(),
      expect: () => const [
        AccountState(status: AccountStatus.loading, account: before),
        AccountState(status: AccountStatus.success, account: after),
      ],
    );

    blocTest<AccountCubit, AccountState>(
      'logout clears the account',
      setUp: () =>
          when(() => facade.logout())
              .thenAnswer((_) async => const Right(unit)),
      build: () => AccountCubit(facade, changes, session, push, workspaces),
      seed: () =>
          const AccountState(status: AccountStatus.success, account: before),
      act: (cubit) => cubit.logout(),
      expect: () => const [AccountState()],
      // The phone's push token goes first, while the session still works.
      verify: (_) => verifyInOrder([push.unregister, facade.logout]),
    );

    blocTest<AccountCubit, AccountState>(
      'an expired session clears the account',
      build: () => AccountCubit(facade, changes, session, push, workspaces),
      seed: () =>
          const AccountState(status: AccountStatus.success, account: before),
      act: (_) => session.expire(),
      expect: () => const [AccountState()],
    );

    test(
      'a load answered after logout does not bring the account back',
      () async {
        final slow = Completer<Either<Failure, Account>>();
        when(() => facade.loadAccount()).thenAnswer((_) => slow.future);
        when(() => facade.logout()).thenAnswer((_) async => const Right(unit));
        final cubit = AccountCubit(facade, changes, session, push, workspaces)
          ..signedIn(before);

        final loading = cubit.load();
        await cubit.logout();
        slow.complete(const Right(after));
        await loading;

        expect(cubit.state, const AccountState());
        await cubit.close();
      },
    );

    group('workspace switching', () {
      const shared = Account(
        user: AppUser(id: 'u1', email: 'e'),
        workspaces: [
          Workspace(id: 'p', name: 'Personal', isPersonal: true),
          Workspace(id: 't', name: 'Team', role: WorkspaceRole.viewer),
        ],
      );

      blocTest<AccountCubit, AccountState>(
        'a load applies the stored workspace',
        setUp: () {
          when(() => facade.loadAccount())
              .thenAnswer((_) async => const Right(shared));
          when(() => workspaces.selectedWorkspaceId())
              .thenAnswer((_) async => 't');
        },
        build: () => AccountCubit(facade, changes, session, push, workspaces),
        act: (cubit) => cubit.load(),
        verify: (cubit) {
          final current = cubit.state.account!.currentWorkspace!;
          expect(current.id, 't');
          // Later phases hide manager-only actions by this.
          expect(current.role.canWrite, isFalse);
        },
      );

      blocTest<AccountCubit, AccountState>(
        'a stored id that is gone falls back to personal',
        setUp: () {
          when(() => facade.loadAccount())
              .thenAnswer((_) async => const Right(shared));
          when(() => workspaces.selectedWorkspaceId())
              .thenAnswer((_) async => 'gone');
        },
        build: () => AccountCubit(facade, changes, session, push, workspaces),
        act: (cubit) => cubit.load(),
        verify: (cubit) =>
            expect(cubit.state.account!.currentWorkspace!.id, 'p'),
      );

      blocTest<AccountCubit, AccountState>(
        'selecting a known workspace switches and stores it, no reload',
        build: () => AccountCubit(facade, changes, session, push, workspaces),
        seed: () =>
            const AccountState(status: AccountStatus.success, account: shared),
        act: (cubit) => cubit.selectWorkspace('t'),
        expect: () => [
          AccountState(
            status: AccountStatus.success,
            account: shared.copyWith(selectedWorkspaceId: 't'),
          ),
        ],
        verify: (_) {
          verify(() => workspaces.saveSelectedWorkspaceId('t')).called(1);
          verifyNever(() => facade.loadAccount());
        },
      );

      blocTest<AccountCubit, AccountState>(
        'selecting a workspace the account does not know reloads it',
        setUp: () =>
            when(() => facade.loadAccount())
                .thenAnswer((_) async => const Right(shared)),
        build: () => AccountCubit(facade, changes, session, push, workspaces),
        seed: () =>
            const AccountState(status: AccountStatus.success, account: before),
        act: (cubit) => cubit.selectWorkspace('t'),
        verify: (_) => verify(() => facade.loadAccount()).called(1),
      );

      blocTest<AccountCubit, AccountState>(
        'logout forgets the choice',
        setUp: () =>
            when(() => facade.logout())
                .thenAnswer((_) async => const Right(unit)),
        build: () => AccountCubit(facade, changes, session, push, workspaces),
        seed: () =>
            const AccountState(status: AccountStatus.success, account: shared),
        act: (cubit) => cubit.logout(),
        verify: (_) =>
            verify(() => workspaces.clearSelectedWorkspace()).called(1),
      );
    });
  });
}

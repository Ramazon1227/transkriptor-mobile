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

class _MockAuthFacade extends Mock implements IAuthFacade;

void main() {
  late _MockAuthFacade facade;
  late LibraryChanges changes;
  late SessionManager session;

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
  });

  tearDown(() => changes.dispose());

  group('AccountCubit', () {
    blocTest<AccountCubit, AccountState>(
      'loads the account',
      setUp: () =>
          when(() => facade.loadAccount())
              .thenAnswer((_) async => const Right(before)),
      build: () => AccountCubit(facade, changes, session),
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
      build: () => AccountCubit(facade, changes, session),
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
      build: () => AccountCubit(facade, changes, session),
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
      build: () => AccountCubit(facade, changes, session),
      seed: () =>
          const AccountState(status: AccountStatus.success, account: before),
      act: (cubit) => cubit.logout(),
      expect: () => const [AccountState()],
    );

    blocTest<AccountCubit, AccountState>(
      'an expired session clears the account',
      build: () => AccountCubit(facade, changes, session),
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
        final cubit = AccountCubit(facade, changes, session)..signedIn(before);

        final loading = cubit.load();
        await cubit.logout();
        slow.complete(const Right(after));
        await loading;

        expect(cubit.state, const AccountState());
        await cubit.close();
      },
    );
  });
}

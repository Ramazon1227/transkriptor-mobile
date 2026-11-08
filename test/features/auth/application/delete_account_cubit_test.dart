import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/application/delete_account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';

class _MockAuthFacade extends Mock implements IAuthFacade;

void main() {
  late _MockAuthFacade facade;

  setUp(() => facade = _MockAuthFacade());

  blocTest<DeleteAccountCubit, DeleteAccountState>(
    'a password account sends the password only',
    setUp: () =>
        when(() => facade.deleteAccount(password: 'parol-123'))
            .thenAnswer((_) async => const Right(unit)),
    build: () => DeleteAccountCubit(facade),
    act: (cubit) => cubit.submit(confirmation: 'parol-123', hasPassword: true),
    expect: () => const [
      DeleteAccountState(status: DeleteAccountStatus.loading),
      DeleteAccountState(status: DeleteAccountStatus.success),
    ],
  );

  blocTest<DeleteAccountCubit, DeleteAccountState>(
    'a Google account sends its trimmed email only',
    setUp: () =>
        when(() => facade.deleteAccount(email: 'e@misol.uz'))
            .thenAnswer((_) async => const Right(unit)),
    build: () => DeleteAccountCubit(facade),
    act: (cubit) =>
        cubit.submit(confirmation: '  e@misol.uz ', hasPassword: false),
    verify: (_) =>
        verify(() => facade.deleteAccount(email: 'e@misol.uz')).called(1),
  );

  blocTest<DeleteAccountCubit, DeleteAccountState>(
    'an empty field sends nothing',
    build: () => DeleteAccountCubit(facade),
    act: (cubit) => cubit.submit(confirmation: '  ', hasPassword: false),
    expect: () => const [DeleteAccountState(confirmationMissing: true)],
    verify: (_) => verifyNever(
      () => facade.deleteAccount(
        password: any(named: 'password'),
        email: any(named: 'email'),
      ),
    ),
  );

  blocTest<DeleteAccountCubit, DeleteAccountState>(
    'a wrong password is a failure the sheet can name',
    setUp: () => when(
      () => facade.deleteAccount(
        password: any(named: 'password'),
        email: any(named: 'email'),
      ),
    ).thenAnswer((_) async => const Left(Failure.server(statusCode: 403))),
    build: () => DeleteAccountCubit(facade),
    act: (cubit) => cubit.submit(confirmation: 'x', hasPassword: true),
    skip: 1,
    expect: () => const [
      DeleteAccountState(
        status: DeleteAccountStatus.failure,
        failure: Failure.server(statusCode: 403),
      ),
    ],
  );

  blocTest<DeleteAccountCubit, DeleteAccountState>(
    'the warning count is loaded and kept through a refusal (MB-12)',
    setUp: () {
      when(() => facade.unsentRecordings())
          .thenAnswer((_) async => const Right(2));
      when(() => facade.deleteAccount(password: 'x'))
          .thenAnswer((_) async => const Left(Failure.server(statusCode: 403)));
    },
    build: () => DeleteAccountCubit(facade),
    act: (cubit) async {
      await cubit.loadUnsent();
      await cubit.submit(confirmation: 'x', hasPassword: true);
    },
    expect: () => const [
      DeleteAccountState(unsentRecordings: 2),
      DeleteAccountState(
        status: DeleteAccountStatus.loading,
        unsentRecordings: 2,
      ),
      DeleteAccountState(
        status: DeleteAccountStatus.failure,
        failure: Failure.server(statusCode: 403),
        unsentRecordings: 2,
      ),
    ],
  );

  blocTest<DeleteAccountCubit, DeleteAccountState>(
    'a count that cannot be read shows no warning',
    setUp: () =>
        when(() => facade.unsentRecordings())
            .thenAnswer((_) async => const Left(Failure.storage())),
    build: () => DeleteAccountCubit(facade),
    act: (cubit) => cubit.loadUnsent(),
    expect: () => const <DeleteAccountState>[],
  );
}

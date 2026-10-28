import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/application/login_bloc.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';

class _MockAuthFacade extends Mock implements IAuthFacade;

void main() {
  late _MockAuthFacade facade;

  const account = Account(
    user: AppUser(id: 'u1', email: 'dilnoza@misol.uz', fullName: 'Dilnoza R.'),
    workspaces: [Workspace(id: 'w1', name: 'Shaxsiy', isPersonal: true)],
  );

  setUp(() => facade = _MockAuthFacade());

  group('LoginBloc with Google', () {
    blocTest<LoginBloc, LoginState>(
      'the Google button appears when the backend has a client id',
      setUp: () =>
          when(() => facade.googleClientId())
              .thenAnswer((_) async => const Right('web-id')),
      build: () => LoginBloc(facade),
      act: (bloc) => bloc.add(const LoginStarted()),
      expect: () => const [LoginState(googleClientId: 'web-id')],
    );

    blocTest<LoginBloc, LoginState>(
      'a failed provider check just leaves the button out',
      setUp: () =>
          when(() => facade.googleClientId())
              .thenAnswer((_) async => const Left(Failure.network())),
      build: () => LoginBloc(facade),
      act: (bloc) => bloc.add(const LoginStarted()),
      expect: () => const <LoginState>[],
    );

    blocTest<LoginBloc, LoginState>(
      'signs in with Google',
      setUp: () =>
          when(() => facade.signInWithGoogle(clientId: 'web-id'))
              .thenAnswer((_) async => const Right(account)),
      build: () => LoginBloc(facade),
      seed: () => const LoginState(googleClientId: 'web-id'),
      act: (bloc) => bloc.add(const LoginGoogleRequested()),
      expect: () => const [
        LoginState(
          status: LoginStatus.loading,
          googleClientId: 'web-id',
          viaGoogle: true,
        ),
        LoginState(
          status: LoginStatus.success,
          googleClientId: 'web-id',
          viaGoogle: true,
          account: account,
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'a closed picker goes back quietly',
      setUp: () =>
          when(() => facade.signInWithGoogle(clientId: 'web-id'))
              .thenAnswer((_) async => const Left(Failure.cancelled())),
      build: () => LoginBloc(facade),
      seed: () => const LoginState(googleClientId: 'web-id'),
      act: (bloc) => bloc.add(const LoginGoogleRequested()),
      skip: 1,
      expect: () => const [
        LoginState(googleClientId: 'web-id', viaGoogle: true),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'without a client id the tap does nothing',
      build: () => LoginBloc(facade),
      act: (bloc) => bloc.add(const LoginGoogleRequested()),
      expect: () => const <LoginState>[],
      verify: (_) => verifyNever(
        () => facade.signInWithGoogle(clientId: any(named: 'clientId')),
      ),
    );
  });

  group('LoginBloc', () {
    blocTest<LoginBloc, LoginState>(
      'flags empty fields and sends nothing',
      build: () => LoginBloc(facade),
      act: (bloc) => bloc.add(const LoginSubmitted(email: '  ', password: '')),
      expect: () => const [
        LoginState(emailMissing: true, passwordMissing: true),
      ],
      verify: (_) => verifyNever(
        () => facade.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ),
    );

    blocTest<LoginBloc, LoginState>(
      'trims the email and emits the account on success',
      setUp: () =>
          when(() => facade.login(email: 'dilnoza@misol.uz', password: 'parol'))
              .thenAnswer((_) async => const Right(account)),
      build: () => LoginBloc(facade),
      act: (bloc) => bloc.add(
        const LoginSubmitted(email: ' dilnoza@misol.uz ', password: 'parol'),
      ),
      expect: () => const [
        LoginState(status: LoginStatus.loading),
        LoginState(status: LoginStatus.success, account: account),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits failure for a wrong password',
      setUp: () => when(
        () => facade.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Left(Failure.unauthorized())),
      build: () => LoginBloc(facade),
      act: (bloc) =>
          bloc.add(const LoginSubmitted(email: 'a@b.uz', password: 'x')),
      expect: () => const [
        LoginState(status: LoginStatus.loading),
        LoginState(
          status: LoginStatus.failure,
          failure: Failure.unauthorized(),
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'ignores a second tap while the first login runs',
      setUp: () =>
          when(
            () => facade.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((_) async {
            await Future<void>.delayed(const Duration(milliseconds: 20));
            return const Right(account);
          }),
      build: () => LoginBloc(facade),
      act: (bloc) => bloc
        ..add(const LoginSubmitted(email: 'a@b.uz', password: 'x'))
        ..add(const LoginSubmitted(email: 'a@b.uz', password: 'x')),
      wait: const Duration(milliseconds: 50),
      verify: (_) => verify(
        () => facade.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).called(1),
    );
  });

  test('Account.currentWorkspace prefers the personal workspace', () {
    const a = Account(
      user: AppUser(id: 'u', email: 'e'),
      workspaces: [
        Workspace(id: 'team', name: 'Jamoa'),
        Workspace(id: 'me', name: 'Shaxsiy', isPersonal: true),
      ],
    );
    expect(a.currentWorkspace?.id, 'me');
    expect(
      const Account(
        user: AppUser(id: 'u', email: 'e'),
      ).currentWorkspace,
      isNull,
    );
  });
}

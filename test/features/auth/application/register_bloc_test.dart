import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/application/register_bloc.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';
import 'package:transkriptor_uz/features/auth/domain/password_rules.dart';

class _MockAuthFacade extends Mock implements IAuthFacade;

void main() {
  late _MockAuthFacade facade;

  const account = Account(
    user: AppUser(id: 'u1', email: 'yangi@misol.uz', fullName: 'Dilnoza'),
    workspaces: [Workspace(id: 'w1', name: 'Shaxsiy', isPersonal: true)],
  );

  setUp(() => facade = _MockAuthFacade());

  group('PasswordRules mirrors models.ValidatePassword', () {
    test('length is counted in bytes, 10..72', () {
      expect(PasswordRules.check('qisqa1'), PasswordProblem.tooShort);
      expect(PasswordRules.check('a' * 9 + '1'), isNull);
      // 36 two-byte letters = 72 bytes: allowed; one more is not.
      expect(PasswordRules.check('ў' * 35 + '1'), isNull);
      expect(PasswordRules.check('ў' * 36 + '1'), PasswordProblem.tooLong);
    });

    test('needs a letter and a non-letter', () {
      expect(
        PasswordRules.check('faqatharflar'),
        PasswordProblem.needsLetterAndOther,
      );
      expect(
        PasswordRules.check('1234567890'),
        PasswordProblem.needsLetterAndOther,
      );
      expect(PasswordRules.check('oʻzbekcha parol'), isNull);
      expect(PasswordRules.check('кириллица-1'), isNull);
    });
  });

  group('RegisterBloc', () {
    blocTest<RegisterBloc, RegisterState>(
      'checks the form locally and sends nothing when it is wrong',
      build: () => RegisterBloc(facade),
      act: (bloc) => bloc.add(
        const RegisterSubmitted(fullName: '', email: 'ali@', password: 'abc'),
      ),
      expect: () => const [
        RegisterState(
          emailInvalid: true,
          passwordProblem: PasswordProblem.tooShort,
        ),
      ],
      verify: (_) => verifyNever(
        () => facade.register(
          email: any(named: 'email'),
          password: any(named: 'password'),
          fullName: any(named: 'fullName'),
        ),
      ),
    );

    blocTest<RegisterBloc, RegisterState>(
      'trims name and email and signs in with the new account',
      setUp: () => when(
        () => facade.register(
          email: 'yangi@misol.uz',
          password: 'parol-12345',
          fullName: 'Dilnoza',
        ),
      ).thenAnswer((_) async => const Right(account)),
      build: () => RegisterBloc(facade),
      act: (bloc) => bloc.add(
        const RegisterSubmitted(
          fullName: ' Dilnoza ',
          email: ' yangi@misol.uz ',
          password: 'parol-12345',
        ),
      ),
      expect: () => const [
        RegisterState(status: RegisterStatus.loading),
        RegisterState(status: RegisterStatus.success, account: account),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'a taken email is a 409 failure',
      setUp: () => when(
        () => facade.register(
          email: any(named: 'email'),
          password: any(named: 'password'),
          fullName: any(named: 'fullName'),
        ),
      ).thenAnswer((_) async => const Left(Failure.server(statusCode: 409))),
      build: () => RegisterBloc(facade),
      act: (bloc) => bloc.add(
        const RegisterSubmitted(
          fullName: '',
          email: 'band@misol.uz',
          password: 'parol-12345',
        ),
      ),
      expect: () => const [
        RegisterState(status: RegisterStatus.loading),
        RegisterState(
          status: RegisterStatus.failure,
          failure: Failure.server(statusCode: 409),
        ),
      ],
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Left, Right, unit;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/application/forgot_password_bloc.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';

class _MockAuthFacade extends Mock implements IAuthFacade;

void main() {
  late _MockAuthFacade facade;

  setUp(() => facade = _MockAuthFacade());

  group('ForgotPasswordBloc', () {
    blocTest<ForgotPasswordBloc, ForgotPasswordState>(
      'sends the trimmed email and remembers where it went',
      setUp: () =>
          when(() => facade.requestPasswordReset(email: 'ali@misol.uz'))
              .thenAnswer((_) async => const Right(unit)),
      build: () => ForgotPasswordBloc(facade),
      act: (bloc) =>
          bloc.add(const ForgotPasswordSubmitted(email: '  ali@misol.uz ')),
      expect: () => const [
        ForgotPasswordState(status: ForgotPasswordStatus.loading),
        ForgotPasswordState(
          status: ForgotPasswordStatus.success,
          sentTo: 'ali@misol.uz',
        ),
      ],
    );

    blocTest<ForgotPasswordBloc, ForgotPasswordState>(
      'a malformed email is refused before any request',
      build: () => ForgotPasswordBloc(facade),
      act: (bloc) => bloc.add(const ForgotPasswordSubmitted(email: 'ali@')),
      expect: () => const [ForgotPasswordState(emailInvalid: true)],
      verify: (_) => verifyNever(
        () => facade.requestPasswordReset(email: any(named: 'email')),
      ),
    );

    blocTest<ForgotPasswordBloc, ForgotPasswordState>(
      'no mail service on the server is a failure, not a sent screen',
      setUp: () => when(
        () => facade.requestPasswordReset(email: any(named: 'email')),
      ).thenAnswer((_) async => const Left(Failure.server(statusCode: 503))),
      build: () => ForgotPasswordBloc(facade),
      act: (bloc) =>
          bloc.add(const ForgotPasswordSubmitted(email: 'ali@misol.uz')),
      skip: 1,
      expect: () => const [
        ForgotPasswordState(
          status: ForgotPasswordStatus.failure,
          failure: Failure.server(statusCode: 503),
        ),
      ],
    );

    blocTest<ForgotPasswordBloc, ForgotPasswordState>(
      'send again returns to the form',
      build: () => ForgotPasswordBloc(facade),
      seed: () => const ForgotPasswordState(
        status: ForgotPasswordStatus.success,
        sentTo: 'ali@misol.uz',
      ),
      act: (bloc) => bloc.add(const ForgotPasswordRestarted()),
      expect: () => const [ForgotPasswordState()],
    );
  });
}

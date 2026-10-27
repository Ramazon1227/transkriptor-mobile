import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';

abstract interface class IAuthFacade {
  /// Signs in, stores the token pair and returns the account. A wrong
  /// email or password is `Failure.unauthorized()`.
  Future<Either<Failure, Account>> login({
    required String email,
    required String password,
  });

  /// Creates the account and signs in with it, like [login]. A taken
  /// email is `Failure.server(statusCode: 409)`.
  Future<Either<Failure, Account>> register({
    required String email,
    required String password,
    required String fullName,
  });

  /// The current account (`GET /me`).
  Future<Either<Failure, Account>> loadAccount();

  /// Revokes the refresh token on the server when it can, and always
  /// forgets the local tokens.
  Future<Either<Failure, Unit>> logout();

  /// Asks for a reset link by mail. The answer is the same for an unknown
  /// email, so success says nothing about whether the account exists. No
  /// mail service on the server is `Failure.server(statusCode: 503)`.
  Future<Either<Failure, Unit>> requestPasswordReset({required String email});
}

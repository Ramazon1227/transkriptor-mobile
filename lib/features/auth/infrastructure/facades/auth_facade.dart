import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/models/token_pair.dart';
import 'package:transkriptor_uz/core/network/session_manager.dart';
import 'package:transkriptor_uz/core/storage/token_storage.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';
import 'package:transkriptor_uz/features/auth/infrastructure/repositories/auth_repository.dart';

@LazySingleton(as: IAuthFacade)
class AuthFacade implements IAuthFacade {
  AuthFacade(this._repository, this._storage, this._session);

  final AuthRepository _repository;
  final TokenStorage _storage;
  final SessionManager _session;

  @override
  Future<Either<Failure, Account>> login({
    required String email,
    required String password,
  }) async {
    final tokens = await _repository.login(email: email, password: password);
    return await _signIn(tokens);
  }

  @override
  Future<Either<Failure, Account>> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final tokens = await _repository.register(
      email: email,
      password: password,
      fullName: fullName,
    );
    return await _signIn(tokens);
  }

  /// Login and register end the same way: store the pair, fetch the
  /// account, and only then let the router know.
  Future<Either<Failure, Account>> _signIn(
    Either<Failure, TokenPair> tokens,
  ) async {
    return await tokens.fold((failure) async => Left(failure), (pair) async {
      if (pair.accessToken.isEmpty || pair.refreshToken.isEmpty) {
        return const Left(Failure.parsing());
      }
      try {
        await _storage.save(
          accessToken: pair.accessToken,
          refreshToken: pair.refreshToken,
        );
      } on Object {
        return const Left(Failure.storage());
      }
      final account = await loadAccount();
      if (account.isLeft()) {
        // Half a sign-in must not survive: the next start would find the
        // tokens and skip login without an account to show.
        try {
          await _storage.clear();
        } on Object {
          // The failure being returned is the one worth showing.
        }
        return account;
      }
      // Only now: resetting the flag refreshes the router, and the login
      // screen has to stay up until the account is in hand. It also arms
      // the next expiry redirect.
      _session.markAuthenticated();
      return account;
    });
  }

  @override
  Future<Either<Failure, Account>> loadAccount() async {
    final result = await _repository.me();
    return result.map((model) => model.toEntity());
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    String? refreshToken;
    try {
      refreshToken = await _storage.readRefreshToken();
    } on Object {
      refreshToken = null;
    }
    // Revoking on the server is best effort: a person who taps "log out"
    // offline must still be logged out on this device.
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _repository.logout(refreshToken: refreshToken);
    }
    try {
      await _storage.clear();
    } on Object {
      return const Left(Failure.storage());
    } finally {
      _session.expire();
    }
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> requestPasswordReset({required String email}) =>
      _repository.requestPasswordReset(email: email);
}

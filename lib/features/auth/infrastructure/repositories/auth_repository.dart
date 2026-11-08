import 'package:dartz/dartz.dart' show Either, Unit, unit;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/models/token_pair.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/auth/infrastructure/models/me_model.dart';

@lazySingleton
class AuthRepository {
  AuthRepository(this._dio);

  final Dio _dio;

  /// `data` of `POST /auth/login` carries the same token fields as refresh.
  Future<Either<Failure, TokenPair>> login({
    required String email,
    required String password,
  }) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.authLogin,
        data: {'email': email, 'password': password},
      );
      return TokenPair.fromJson(envelopeData(response.data));
    });
  }

  /// `data` of `POST /auth/register` (201) carries the same token fields:
  /// a new account is signed in at once.
  Future<Either<Failure, TokenPair>> register({
    required String email,
    required String password,
    required String fullName,
  }) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.authRegister,
        data: {
          'email': email,
          'password': password,
          'full_name': fullName,
          // The app is Uzbek-only for now (Russian UI comes later).
          'locale': 'uz',
        },
      );
      return TokenPair.fromJson(envelopeData(response.data));
    });
  }

  /// The web client id when Google sign-in is on, null when it is off.
  Future<Either<Failure, String?>> googleClientId() {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.authOAuthProviders,
      );
      final google = envelopeData(response.data)['google'];
      if (google is! Map<String, dynamic>) return null;
      final id = google['client_id'];
      return id is String && id.isNotEmpty ? id : null;
    });
  }

  /// `data` carries the token pair at the top level, plus `user` and
  /// `created`, which the app reads from `GET /me` instead.
  Future<Either<Failure, TokenPair>> googleSignIn({required String idToken}) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.authOAuthGoogle,
        data: {'id_token': idToken},
      );
      return TokenPair.fromJson(envelopeData(response.data));
    });
  }

  Future<Either<Failure, MeModel>> me() {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(Endpoints.me);
      return MeModel.fromJson(envelopeData(response.data));
    });
  }

  /// `PATCH /me` (backend `api/handler/me.go`, `UpdateMeRequest`): only
  /// the fields sent change. `data` is `{user}`.
  Future<Either<Failure, UserModel>> updateName(String fullName) {
    return runRequest(() async {
      final response = await _dio.patch<Map<String, dynamic>>(
        Endpoints.me,
        data: {'full_name': fullName},
      );
      final user = envelopeData(response.data)['user'];
      if (user is! Map<String, dynamic>) {
        throw const FormatException('no user');
      }
      return UserModel.fromJson(user);
    });
  }

  Future<Either<Failure, Unit>> logout({required String refreshToken}) {
    return runRequest(() async {
      await _dio.post<Map<String, dynamic>>(
        Endpoints.authLogout,
        data: {'refresh_token': refreshToken},
      );
      return unit;
    });
  }

  /// `DELETE /me`: a password account confirms with [password], a
  /// Google-only one with its own [email]. 403 = wrong confirmation, 409 =
  /// sole owner of a workspace that has other members, or the only
  /// platform admin.
  Future<Either<Failure, Unit>> deleteAccount({
    String? password,
    String? email,
  }) async {
    Object? body;
    final result = await runRequest(() async {
      try {
        await _dio.delete<Map<String, dynamic>>(
          Endpoints.me,
          data: {'password': ?password, 'email': ?email},
        );
      } on DioException catch (e) {
        body = e.response?.data;
        rethrow;
      }
      return unit;
    });
    return result.leftMap((f) => soleOwnerFailure(f, body));
  }

  /// W-3: a 409 with `data.code == "SOLE_OWNER"` and workspace names becomes
  /// [Failure.soleOwner]; AD-1: `"LAST_ADMIN"` becomes [Failure.lastAdmin].
  /// Anything else is left as it was — an older server's 409 has no code
  /// and keeps the generic sentence.
  @visibleForTesting
  static Failure soleOwnerFailure(Failure failure, Object? body) {
    if (failure is! ServerFailure || failure.statusCode != 409) return failure;
    if (body is! Map<String, dynamic>) return failure;
    final data = body['data'];
    if (data is! Map<String, dynamic>) return failure;
    if (data['code'] == 'LAST_ADMIN') return const Failure.lastAdmin();
    if (data['code'] != 'SOLE_OWNER') return failure;
    final names = data['workspaces'];
    if (names is! List) return failure;
    final list = names.whereType<String>().where((n) => n.trim().isNotEmpty);
    if (list.isEmpty) return failure;
    return Failure.soleOwner(list.toList());
  }

  /// 202 with the same body whether or not the email has an account.
  Future<Either<Failure, Unit>> requestPasswordReset({required String email}) {
    return runRequest(() async {
      await _dio.post<Map<String, dynamic>>(
        Endpoints.authPasswordForgot,
        data: {'email': email},
      );
      return unit;
    });
  }
}

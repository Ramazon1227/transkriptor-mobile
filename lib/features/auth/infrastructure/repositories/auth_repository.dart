import 'package:dartz/dartz.dart' show Either, Unit, unit;
import 'package:dio/dio.dart';
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

  Future<Either<Failure, MeModel>> me() {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(Endpoints.me);
      return MeModel.fromJson(envelopeData(response.data));
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
}

import 'package:dartz/dartz.dart' show Either, Unit, unit;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';

@lazySingleton
class PushRepository {
  PushRepository(this._dio);

  final Dio _dio;

  /// `POST /me/devices`. The same token sent again (or by another account
  /// on this phone) is moved, not duplicated, on the server.
  Future<Either<Failure, Unit>> register({
    required String token,
    required String platform,
  }) {
    return runRequest(() async {
      await _dio.post<Map<String, dynamic>>(
        Endpoints.meDevices,
        data: {'token': token, 'platform': platform},
      );
      return unit;
    });
  }

  /// `DELETE /me/devices`; an unknown token is still 200.
  Future<Either<Failure, Unit>> unregister({required String token}) {
    return runRequest(() async {
      await _dio.delete<Map<String, dynamic>>(
        Endpoints.meDevices,
        data: {'token': token},
      );
      return unit;
    });
  }
}

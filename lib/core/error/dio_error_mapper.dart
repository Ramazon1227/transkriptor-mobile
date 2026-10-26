import 'package:dio/dio.dart';
import 'package:transkriptor_uz/core/error/failure.dart';

/// Turns a [DioException] into a [Failure]. The only place that knows how
/// Dio reports errors.
Failure mapDioException(DioException e) {
  return switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => const Failure.timeout(),
    DioExceptionType.connectionError ||
    DioExceptionType.badCertificate => const Failure.network(),
    DioExceptionType.cancel => const Failure.cancelled(),
    DioExceptionType.badResponse => _fromResponse(e.response),
    // A body that is not valid JSON surfaces here as a FormatException.
    DioExceptionType.unknown when e.error is FormatException =>
      const Failure.parsing(),
    DioExceptionType.unknown => const Failure.unknown(),
  };
}

Failure _fromResponse(Response<dynamic>? response) {
  final statusCode = response?.statusCode;
  if (statusCode == 401) return const Failure.unauthorized();
  return Failure.server(
    statusCode: statusCode,
    message: _description(response?.data),
  );
}

/// Backend envelope: `{"status": ..., "description": ..., "data": ...}`.
String? _description(Object? body) {
  if (body is Map<String, dynamic>) {
    final description = body['description'];
    if (description is String && description.isNotEmpty) return description;
  }
  return null;
}

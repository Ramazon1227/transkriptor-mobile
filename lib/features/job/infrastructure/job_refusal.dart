import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';

/// [runRequest] for a call that opens a job (`POST /job`, `/media/youtube`,
/// `/media/cloud`). Their refusals name the reason in the envelope's
/// `data.error`, which the shared mapper does not read:
/// - `JOB_ACTIVE` (409): the file already has a queued or running job;
/// - `IDEMPOTENCY_MISMATCH` (409 / 422): the key was used with other
///   parameters.
/// Any other refusal stays as the mapper made it.
Future<Either<Failure, T>> runJobRequest<T>(Future<T> Function() call) async {
  Object? body;
  final result = await runRequest(() async {
    try {
      return await call();
    } on DioException catch (e) {
      body = e.response?.data;
      rethrow;
    }
  });
  return result.leftMap((failure) => jobRefusal(failure, body));
}

Failure jobRefusal(Failure failure, Object? body) {
  if (failure is! ServerFailure || body is! Map<String, dynamic>) {
    return failure;
  }
  final data = body['data'];
  // `status` too: PENDING_LIMIT is named there, and either place is read.
  final codes = [
    if (data is Map<String, dynamic>) data['error'],
    body['status'],
  ];
  if (codes.contains('JOB_ACTIVE')) return const Failure.jobActive();
  if (codes.contains('IDEMPOTENCY_MISMATCH')) {
    return const Failure.idempotencyMismatch();
  }
  return failure;
}

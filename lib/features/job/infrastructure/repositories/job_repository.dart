import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/job/infrastructure/job_refusal.dart';
import 'package:transkriptor_uz/features/job/infrastructure/models/job_model.dart';

@lazySingleton
class JobRepository {
  JobRepository(this._dio);

  final Dio _dio;

  Future<Either<Failure, JobModel>> getJob(String id) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.jobById(id),
      );
      return JobModel.fromJson(envelopeData(response.data));
    });
  }

  /// [idempotencyKey] belongs to the person's action (`IdempotencyKeys`),
  /// not to this call: a retry of that action sends the same one.
  Future<Either<Failure, JobModel>> createJob({
    required String mediaId,
    required String idempotencyKey,
    int? numSpeakers,
  }) {
    return runJobRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.job,
        data: {
          'media_id': mediaId,
          'num_speakers': ?numSpeakers,
          'idempotency_key': idempotencyKey,
        },
        options: Options(headers: {'Idempotency-Key': idempotencyKey}),
      );
      return JobModel.fromJson(envelopeData(response.data));
    });
  }

  Future<Either<Failure, JobModel>> cancel(String id) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.jobCancel(id),
      );
      return JobModel.fromJson(envelopeData(response.data));
    });
  }
}

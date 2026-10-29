import 'package:dartz/dartz.dart' show Either, Unit, unit;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/comments/infrastructure/models/comment_model.dart';

@lazySingleton
class CommentsRepository {
  CommentsRepository(this._dio);

  final Dio _dio;

  Future<Either<Failure, List<CommentModel>>> list(String transcriptId) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.transcriptComments(transcriptId),
      );
      return CommentListModel.fromJson(envelopeData(response.data)).items;
    });
  }

  Future<Either<Failure, CommentModel>> create({
    required String transcriptId,
    required String segmentId,
    required String body,
  }) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.transcriptComments(transcriptId),
        data: {'segment_id': segmentId, 'body': body},
      );
      return CommentEnvelopeModel.fromJson(envelopeData(response.data)).comment;
    });
  }

  /// Sends `body` only: `resolved` stays untouched.
  Future<Either<Failure, CommentModel>> update({
    required String transcriptId,
    required String commentId,
    required String body,
  }) {
    return runRequest(() async {
      final response = await _dio.patch<Map<String, dynamic>>(
        Endpoints.transcriptComment(transcriptId, commentId),
        data: {'body': body},
      );
      return CommentEnvelopeModel.fromJson(envelopeData(response.data)).comment;
    });
  }

  Future<Either<Failure, Unit>> delete({
    required String transcriptId,
    required String commentId,
  }) {
    return runRequest(() async {
      await _dio.delete<Map<String, dynamic>>(
        Endpoints.transcriptComment(transcriptId, commentId),
      );
      return unit;
    });
  }
}

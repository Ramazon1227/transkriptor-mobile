import 'package:dartz/dartz.dart' show Either, Unit, unit;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/ai_chat/infrastructure/models/ai_message_model.dart';

/// `GET` / `POST` / `DELETE /transcript/:id/chat`.
@lazySingleton
class AiChatRepository {
  AiChatRepository(this._dio);

  final Dio _dio;

  /// (items, pending). `pending` defaults to false when absent.
  Future<Either<Failure, (List<AiMessageModel>, bool)>> history(
    String transcriptId,
  ) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.transcriptChat(transcriptId),
      );
      final data = envelopeData(response.data);
      final items = (data['items'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(AiMessageModel.fromJson)
          .toList();
      return (items, data['pending'] as bool? ?? false);
    });
  }

  Future<Either<Failure, (AiMessageModel, AiMessageModel)>> ask(
    String transcriptId,
    String content,
  ) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.transcriptChat(transcriptId),
        data: {'content': content},
      );
      final data = envelopeData(response.data);
      final question = data['question'];
      final answer = data['answer'];
      if (question is! Map<String, dynamic> ||
          answer is! Map<String, dynamic>) {
        throw const FormatException('response has no question/answer');
      }
      return (
        AiMessageModel.fromJson(question),
        AiMessageModel.fromJson(answer),
      );
    });
  }

  Future<Either<Failure, Unit>> clear(String transcriptId) {
    return runRequest(() async {
      await _dio.delete<Map<String, dynamic>>(
        Endpoints.transcriptChat(transcriptId),
      );
      return unit;
    });
  }
}

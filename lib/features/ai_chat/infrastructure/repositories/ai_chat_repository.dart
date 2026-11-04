import 'package:dartz/dartz.dart' show Either, Unit, unit;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/ai_chat/infrastructure/models/ai_message_model.dart';

/// `GET` / `POST` / `DELETE /transcript/:id/chat`, plus
/// `POST …/chat/stop` and `POST …/chat/:answer_id/retry`.
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
      return _chat(response.data);
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
      return _exchange(response.data);
    });
  }

  /// The pending answer stops; what was written stays. Answers with the
  /// chat as it is now (nothing pending is not an error).
  Future<Either<Failure, (List<AiMessageModel>, bool)>> stop(
    String transcriptId,
  ) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.transcriptChatStop(transcriptId),
      );
      return _chat(response.data);
    });
  }

  /// The last answer is written again: the same question, a new `PENDING`
  /// answer row. 409 when it is not the last one or still pending.
  Future<Either<Failure, (AiMessageModel, AiMessageModel)>> retry(
    String transcriptId,
    String answerId,
  ) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.transcriptChatRetry(transcriptId, answerId),
      );
      return _exchange(response.data);
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

  static (List<AiMessageModel>, bool) _chat(Map<String, dynamic>? body) {
    final data = envelopeData(body);
    final items = (data['items'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>()
        .map(AiMessageModel.fromJson)
        .toList();
    return (items, data['pending'] as bool? ?? false);
  }

  static (AiMessageModel, AiMessageModel) _exchange(
    Map<String, dynamic>? body,
  ) {
    final data = envelopeData(body);
    final question = data['question'];
    final answer = data['answer'];
    if (question is! Map<String, dynamic> || answer is! Map<String, dynamic>) {
      throw const FormatException('response has no question/answer');
    }
    return (AiMessageModel.fromJson(question), AiMessageModel.fromJson(answer));
  }
}

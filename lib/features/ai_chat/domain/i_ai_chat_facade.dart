import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/entities/ai_message.dart';

/// The editor's AI chat. The answer is never awaited in the request: a
/// question gets a `PENDING` answer row and the client polls [history].
abstract interface class IAiChatFacade {
  /// The caller's own chat; other members never see it.
  Future<Either<Failure, AiChat>> history(String transcriptId);

  /// 409 while the previous answer is still pending; 503 when the AI is
  /// off or its queue is full.
  Future<Either<Failure, AiExchange>> ask(String transcriptId, String content);

  Future<Either<Failure, Unit>> clear(String transcriptId);
}

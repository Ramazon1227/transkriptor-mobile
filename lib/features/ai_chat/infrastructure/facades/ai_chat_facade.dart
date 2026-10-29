import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/entities/ai_message.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/i_ai_chat_facade.dart';
import 'package:transkriptor_uz/features/ai_chat/infrastructure/repositories/ai_chat_repository.dart';

@LazySingleton(as: IAiChatFacade)
class AiChatFacade implements IAiChatFacade {
  AiChatFacade(this._repository);

  final AiChatRepository _repository;

  @override
  Future<Either<Failure, AiChat>> history(String transcriptId) async {
    final result = await _repository.history(transcriptId);
    return result.map((r) {
      final items = r.$1.map((m) => m.toEntity()).toList();
      // The flag and the rows can disagree on an older server; either
      // one saying "pending" keeps the client polling.
      final pending = r.$2 || items.any((m) => m.isPendingAnswer);
      return AiChat(items: items, pending: pending);
    });
  }

  @override
  Future<Either<Failure, AiExchange>> ask(
    String transcriptId,
    String content,
  ) async {
    final result = await _repository.ask(transcriptId, content);
    return result.map(
      (r) => AiExchange(question: r.$1.toEntity(), answer: r.$2.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Unit>> clear(String transcriptId) =>
      _repository.clear(transcriptId);
}

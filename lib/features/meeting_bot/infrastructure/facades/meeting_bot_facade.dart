import 'package:dartz/dartz.dart' show Either;
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/meeting_bot/domain/entities/meeting_bot.dart';
import 'package:transkriptor_uz/features/meeting_bot/domain/i_meeting_bot_facade.dart';
import 'package:transkriptor_uz/features/meeting_bot/infrastructure/repositories/meeting_bot_repository.dart';

@LazySingleton(as: IMeetingBotFacade)
class MeetingBotFacade implements IMeetingBotFacade {
  MeetingBotFacade(this._repository);

  final MeetingBotRepository _repository;

  @override
  Future<Either<Failure, MeetingBotList>> list({
    required String workspaceId,
  }) async {
    final result = await _repository.list(workspaceId: workspaceId);
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, MeetingBot>> create({
    required String workspaceId,
    required String meetUrl,
    required bool keepVideo,
    int? numSpeakers,
    bool summarize = false,
    String? summaryTemplateId,
    bool shareInternal = false,
  }) async {
    final result = await _repository.create(
      workspaceId: workspaceId,
      meetUrl: meetUrl,
      keepVideo: keepVideo,
      numSpeakers: numSpeakers,
      summarize: summarize,
      summaryTemplateId: summaryTemplateId,
      shareInternal: shareInternal,
    );
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, MeetingBot>> get(String id) async {
    final result = await _repository.get(id);
    return result.map((m) => m.toEntity());
  }

  @override
  Future<Either<Failure, MeetingBot>> cancel(String id) async {
    final result = await _repository.cancel(id);
    return result.map((m) => m.toEntity());
  }
}

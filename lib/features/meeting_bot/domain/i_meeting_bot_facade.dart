import 'package:dartz/dartz.dart' show Either;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/meeting_bot/domain/entities/meeting_bot.dart';

/// The Google Meet bot (backend `feat/meet-bot`). A server without that
/// branch answers 404 for the route itself: `list` and `create` return
/// `Failure.server(statusCode: 404)` then.
abstract interface class IMeetingBotFacade {
  Future<Either<Failure, MeetingBotList>> list({required String workspaceId});

  /// [meetUrl] is already canonical (`canonicalMeetUrl`). [numSpeakers]
  /// null means the server decides. No language field: the workspace
  /// setting is the source (decided 2026-10-29).
  ///
  /// [summarize]: a summary is written after the meeting (T14.1, backend
  /// `feat/meeting-ai`), with [summaryTemplateId] (null: the default) and
  /// mailed to internal participants too when [shareInternal]. Those two
  /// are sent only with [summarize]; an older server ignores all three.
  Future<Either<Failure, MeetingBot>> create({
    required String workspaceId,
    required String meetUrl,
    required bool keepVideo,
    int? numSpeakers,
    bool summarize = false,
    String? summaryTemplateId,
    bool shareInternal = false,
  });

  Future<Either<Failure, MeetingBot>> get(String id);

  /// Calls the bot back. Before recording it is cancelled outright; while
  /// recording it leaves and what was recorded is still transcribed.
  Future<Either<Failure, MeetingBot>> cancel(String id);
}

import 'package:dartz/dartz.dart' show Either;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/constants/endpoints.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/network/envelope.dart';
import 'package:transkriptor_uz/core/network/run_request.dart';
import 'package:transkriptor_uz/features/meeting_bot/infrastructure/models/meeting_bot_model.dart';

@lazySingleton
class MeetingBotRepository {
  MeetingBotRepository(this._dio);

  final Dio _dio;

  Future<Either<Failure, MeetingBotListModel>> list({
    required String workspaceId,
  }) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.meetingBots,
        queryParameters: {'workspace_id': workspaceId},
      );
      return MeetingBotListModel.fromJson(envelopeData(response.data));
    });
  }

  /// `CreateMeetingBotRequest` (backend `api/handler/meeting_bot.go`).
  /// The summary fields go only with `summarize: true`: the server
  /// answers 400 for a template or `share_internal` without it, and 403
  /// for `share_internal` from an unverified email.
  Future<Either<Failure, MeetingBotModel>> create({
    required String workspaceId,
    required String meetUrl,
    required bool keepVideo,
    int? numSpeakers,
    bool summarize = false,
    String? summaryTemplateId,
    bool shareInternal = false,
  }) {
    return runRequest(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        Endpoints.meetingBots,
        data: {
          'meet_url': meetUrl,
          'workspace_id': workspaceId,
          'keep_video': keepVideo,
          'num_speakers': ?numSpeakers,
          if (summarize) ...{
            'summarize': true,
            'summary_template_id': ?summaryTemplateId,
            'share_internal': shareInternal,
          },
        },
      );
      return MeetingBotModel.fromJson(envelopeData(response.data));
    });
  }

  Future<Either<Failure, MeetingBotModel>> get(String id) {
    return runRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        Endpoints.meetingBot(id),
      );
      return MeetingBotModel.fromJson(envelopeData(response.data));
    });
  }

  Future<Either<Failure, MeetingBotModel>> cancel(String id) {
    return runRequest(() async {
      final response = await _dio.delete<Map<String, dynamic>>(
        Endpoints.meetingBot(id),
      );
      return MeetingBotModel.fromJson(envelopeData(response.data));
    });
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/meeting_bot/domain/entities/meeting_bot.dart';

part 'meeting_bot_model.freezed.dart';
part 'meeting_bot_model.g.dart';

/// `handler.MeetingBotResponse` in the backend (`feat/meet-bot`).
@freezed
abstract class MeetingBotModel with _$MeetingBotModel {
  const factory MeetingBotModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'meet_url') @Default('') String meetUrl,
    @JsonKey(name: 'status', unknownEnumValue: MeetingBotStatus.unknown)
    @Default(MeetingBotStatus.unknown)
    MeetingBotStatus status,
    @JsonKey(name: 'error_code') String? errorCode,
    @JsonKey(name: 'error_message') String? errorMessage,
    @JsonKey(name: 'cancel_requested') @Default(false) bool cancelRequested,
    @JsonKey(name: 'bot_name') @Default('') String botName,
    @JsonKey(name: 'media_id') String? mediaId,
    @JsonKey(name: 'job_id') String? jobId,
    @JsonKey(name: 'meeting_title') String? meetingTitle,
    @JsonKey(name: 'keep_video') @Default(false) bool keepVideo,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _MeetingBotModel;

  const MeetingBotModel._();

  factory MeetingBotModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingBotModelFromJson(json);

  MeetingBot toEntity() => MeetingBot(
    id: id,
    status: status,
    meetUrl: meetUrl,
    botName: botName,
    errorCode: _orNull(errorCode),
    errorMessage: _orNull(errorMessage),
    cancelRequested: cancelRequested,
    keepVideo: keepVideo,
    mediaId: _orNull(mediaId),
    jobId: _orNull(jobId),
    meetingTitle: _orNull(meetingTitle),
    createdAt: createdAt,
  );
}

/// `handler.MeetingBotList`.
@freezed
abstract class MeetingBotListModel with _$MeetingBotListModel {
  const factory MeetingBotListModel({
    @JsonKey(name: 'available') @Default(true) bool available,
    @JsonKey(name: 'default_bot_name') @Default('') String defaultBotName,
    @JsonKey(name: 'items')
    @Default(<MeetingBotModel>[])
    List<MeetingBotModel> items,
  }) = _MeetingBotListModel;

  const MeetingBotListModel._();

  factory MeetingBotListModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingBotListModelFromJson(json);

  MeetingBotList toEntity() => MeetingBotList(
    available: available,
    defaultBotName: defaultBotName,
    items: [for (final m in items) m.toEntity()],
  );
}

String? _orNull(String? s) => (s == null || s.isEmpty) ? null : s;

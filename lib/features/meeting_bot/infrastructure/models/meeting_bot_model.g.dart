// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_bot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeetingBotModel _$MeetingBotModelFromJson(Map<String, dynamic> json) =>
    _MeetingBotModel(
      id: json['id'] as String? ?? '',
      meetUrl: json['meet_url'] as String? ?? '',
      status:
          $enumDecodeNullable(
            _$MeetingBotStatusEnumMap,
            json['status'],
            unknownValue: MeetingBotStatus.unknown,
          ) ??
          MeetingBotStatus.unknown,
      errorCode: json['error_code'] as String?,
      errorMessage: json['error_message'] as String?,
      cancelRequested: json['cancel_requested'] as bool? ?? false,
      botName: json['bot_name'] as String? ?? '',
      mediaId: json['media_id'] as String?,
      jobId: json['job_id'] as String?,
      meetingTitle: json['meeting_title'] as String?,
      keepVideo: json['keep_video'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MeetingBotModelToJson(_MeetingBotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'meet_url': instance.meetUrl,
      'status': _$MeetingBotStatusEnumMap[instance.status]!,
      'error_code': instance.errorCode,
      'error_message': instance.errorMessage,
      'cancel_requested': instance.cancelRequested,
      'bot_name': instance.botName,
      'media_id': instance.mediaId,
      'job_id': instance.jobId,
      'meeting_title': instance.meetingTitle,
      'keep_video': instance.keepVideo,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$MeetingBotStatusEnumMap = {
  MeetingBotStatus.scheduled: 'SCHEDULED',
  MeetingBotStatus.joining: 'JOINING',
  MeetingBotStatus.waiting: 'WAITING',
  MeetingBotStatus.recording: 'RECORDING',
  MeetingBotStatus.uploading: 'UPLOADING',
  MeetingBotStatus.done: 'DONE',
  MeetingBotStatus.failed: 'FAILED',
  MeetingBotStatus.denied: 'DENIED',
  MeetingBotStatus.cancelled: 'CANCELLED',
  MeetingBotStatus.unknown: 'unknown',
};

_MeetingBotListModel _$MeetingBotListModelFromJson(Map<String, dynamic> json) =>
    _MeetingBotListModel(
      available: json['available'] as bool? ?? true,
      defaultBotName: json['default_bot_name'] as String? ?? '',
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => MeetingBotModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MeetingBotModel>[],
    );

Map<String, dynamic> _$MeetingBotListModelToJson(
  _MeetingBotListModel instance,
) => <String, dynamic>{
  'available': instance.available,
  'default_bot_name': instance.defaultBotName,
  'items': instance.items,
};

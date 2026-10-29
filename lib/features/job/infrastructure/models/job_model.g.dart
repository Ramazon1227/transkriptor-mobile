// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobModel _$JobModelFromJson(Map<String, dynamic> json) => _JobModel(
  id: json['id'] as String? ?? '',
  mediaId: json['media_id'] as String? ?? '',
  status:
      $enumDecodeNullable(
        _$JobStatusEnumMap,
        json['status'],
        unknownValue: JobStatus.unknown,
      ) ??
      JobStatus.unknown,
  progress: (json['progress'] as num?)?.toInt() ?? 0,
  errorMessage: json['error_message'] as String?,
  transcriptId: json['transcript_id'] as String?,
  numSpeakers: (json['num_speakers'] as num?)?.toInt(),
);

Map<String, dynamic> _$JobModelToJson(_JobModel instance) => <String, dynamic>{
  'id': instance.id,
  'media_id': instance.mediaId,
  'status': _$JobStatusEnumMap[instance.status]!,
  'progress': instance.progress,
  'error_message': instance.errorMessage,
  'transcript_id': instance.transcriptId,
  'num_speakers': instance.numSpeakers,
};

const _$JobStatusEnumMap = {
  JobStatus.queued: 'QUEUED',
  JobStatus.running: 'RUNNING',
  JobStatus.succeeded: 'SUCCEEDED',
  JobStatus.failed: 'FAILED',
  JobStatus.cancelled: 'CANCELLED',
  JobStatus.unknown: 'unknown',
};

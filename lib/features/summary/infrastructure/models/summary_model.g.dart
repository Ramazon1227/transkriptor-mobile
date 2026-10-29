// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SummaryModel _$SummaryModelFromJson(Map<String, dynamic> json) =>
    _SummaryModel(
      id: json['id'] as String? ?? '',
      transcriptId: json['transcript_id'] as String? ?? '',
      templateId: json['template_id'] as String?,
      title: json['title'] as String? ?? '',
      status:
          $enumDecodeNullable(
            _$SummaryStatusModelEnumMap,
            json['status'],
            unknownValue: SummaryStatusModel.unknown,
          ) ??
          SummaryStatusModel.unknown,
      body: json['body'],
      error: json['error'] as String? ?? '',
      revision: (json['revision'] as num?)?.toInt() ?? 0,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SummaryModelToJson(_SummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transcript_id': instance.transcriptId,
      'template_id': instance.templateId,
      'title': instance.title,
      'status': _$SummaryStatusModelEnumMap[instance.status]!,
      'body': instance.body,
      'error': instance.error,
      'revision': instance.revision,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$SummaryStatusModelEnumMap = {
  SummaryStatusModel.pending: 'PENDING',
  SummaryStatusModel.done: 'DONE',
  SummaryStatusModel.failed: 'FAILED',
  SummaryStatusModel.unknown: 'unknown',
};

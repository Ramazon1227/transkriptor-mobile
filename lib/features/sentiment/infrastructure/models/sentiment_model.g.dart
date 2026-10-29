// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sentiment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SentimentShareModel _$SentimentShareModelFromJson(Map<String, dynamic> json) =>
    _SentimentShareModel(
      positive: (json['positive'] as num?)?.toDouble() ?? 0,
      neutral: (json['neutral'] as num?)?.toDouble() ?? 0,
      negative: (json['negative'] as num?)?.toDouble() ?? 0,
      score: (json['score'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$SentimentShareModelToJson(
  _SentimentShareModel instance,
) => <String, dynamic>{
  'positive': instance.positive,
  'neutral': instance.neutral,
  'negative': instance.negative,
  'score': instance.score,
};

_SpeakerSentimentModel _$SpeakerSentimentModelFromJson(
  Map<String, dynamic> json,
) => _SpeakerSentimentModel(
  speakerId: json['speaker_id'] as String?,
  label: json['label'] as String? ?? '',
  talkMs: (json['talk_ms'] as num?)?.toInt() ?? 0,
  positive: (json['positive'] as num?)?.toDouble() ?? 0,
  neutral: (json['neutral'] as num?)?.toDouble() ?? 0,
  negative: (json['negative'] as num?)?.toDouble() ?? 0,
  score: (json['score'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$SpeakerSentimentModelToJson(
  _SpeakerSentimentModel instance,
) => <String, dynamic>{
  'speaker_id': instance.speakerId,
  'label': instance.label,
  'talk_ms': instance.talkMs,
  'positive': instance.positive,
  'neutral': instance.neutral,
  'negative': instance.negative,
  'score': instance.score,
};

_SegmentSentimentModel _$SegmentSentimentModelFromJson(
  Map<String, dynamic> json,
) => _SegmentSentimentModel(
  segmentId: json['segment_id'] as String? ?? '',
  label:
      $enumDecodeNullable(
        _$SentimentLabelModelEnumMap,
        json['label'],
        unknownValue: SentimentLabelModel.unknown,
      ) ??
      SentimentLabelModel.unknown,
);

Map<String, dynamic> _$SegmentSentimentModelToJson(
  _SegmentSentimentModel instance,
) => <String, dynamic>{
  'segment_id': instance.segmentId,
  'label': _$SentimentLabelModelEnumMap[instance.label]!,
};

const _$SentimentLabelModelEnumMap = {
  SentimentLabelModel.positive: 'POSITIVE',
  SentimentLabelModel.neutral: 'NEUTRAL',
  SentimentLabelModel.negative: 'NEGATIVE',
  SentimentLabelModel.unknown: 'unknown',
};

_SentimentModel _$SentimentModelFromJson(Map<String, dynamic> json) =>
    _SentimentModel(
      status:
          $enumDecodeNullable(
            _$SentimentStatusModelEnumMap,
            json['status'],
            unknownValue: SentimentStatusModel.unknown,
          ) ??
          SentimentStatusModel.unknown,
      note: json['note'] as String? ?? '',
      error: json['error'] as String?,
      attempt: (json['attempt'] as num?)?.toInt() ?? 0,
      model: json['model'] as String? ?? '',
      outdated: json['outdated'] as bool? ?? false,
      unlabeled: (json['unlabeled'] as num?)?.toInt() ?? 0,
      overall: json['overall'] == null
          ? null
          : SentimentShareModel.fromJson(
              json['overall'] as Map<String, dynamic>,
            ),
      speakers:
          (json['speakers'] as List<dynamic>?)
              ?.map(
                (e) =>
                    SpeakerSentimentModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <SpeakerSentimentModel>[],
      segments:
          (json['segments'] as List<dynamic>?)
              ?.map(
                (e) =>
                    SegmentSentimentModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <SegmentSentimentModel>[],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SentimentModelToJson(_SentimentModel instance) =>
    <String, dynamic>{
      'status': _$SentimentStatusModelEnumMap[instance.status]!,
      'note': instance.note,
      'error': instance.error,
      'attempt': instance.attempt,
      'model': instance.model,
      'outdated': instance.outdated,
      'unlabeled': instance.unlabeled,
      'overall': instance.overall,
      'speakers': instance.speakers,
      'segments': instance.segments,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$SentimentStatusModelEnumMap = {
  SentimentStatusModel.pending: 'PENDING',
  SentimentStatusModel.done: 'DONE',
  SentimentStatusModel.failed: 'FAILED',
  SentimentStatusModel.unknown: 'unknown',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpeakerModel _$SpeakerModelFromJson(Map<String, dynamic> json) =>
    _SpeakerModel(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? '',
      ordinal: (json['ordinal'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SpeakerModelToJson(_SpeakerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'ordinal': instance.ordinal,
    };

_SegmentModel _$SegmentModelFromJson(Map<String, dynamic> json) =>
    _SegmentModel(
      id: json['id'] as String? ?? '',
      startMs: (json['start_ms'] as num?)?.toInt() ?? 0,
      endMs: (json['end_ms'] as num?)?.toInt() ?? 0,
      text: json['text'] as String? ?? '',
      speakerId: json['speaker_id'] as String?,
      edited: json['edited'] as bool? ?? false,
    );

Map<String, dynamic> _$SegmentModelToJson(_SegmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_ms': instance.startMs,
      'end_ms': instance.endMs,
      'text': instance.text,
      'speaker_id': instance.speakerId,
      'edited': instance.edited,
    };

_TranscriptModel _$TranscriptModelFromJson(Map<String, dynamic> json) =>
    _TranscriptModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      durationMs: (json['duration_ms'] as num?)?.toInt(),
      speakers:
          (json['speakers'] as List<dynamic>?)
              ?.map((e) => SpeakerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SpeakerModel>[],
      segments:
          (json['segments'] as List<dynamic>?)
              ?.map((e) => SegmentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SegmentModel>[],
    );

Map<String, dynamic> _$TranscriptModelToJson(_TranscriptModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'duration_ms': instance.durationMs,
      'speakers': instance.speakers,
      'segments': instance.segments,
    };

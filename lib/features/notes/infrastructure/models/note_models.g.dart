// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoteSummaryModel _$NoteSummaryModelFromJson(Map<String, dynamic> json) =>
    _NoteSummaryModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      excerpt: json['excerpt'] as String? ?? '',
      sourceKind:
          $enumDecodeNullable(
            _$NoteSourceKindEnumMap,
            json['source_kind'],
            unknownValue: NoteSourceKind.unknown,
          ) ??
          NoteSourceKind.unknown,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$NoteSummaryModelToJson(_NoteSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'excerpt': instance.excerpt,
      'source_kind': _$NoteSourceKindEnumMap[instance.sourceKind]!,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

const _$NoteSourceKindEnumMap = {
  NoteSourceKind.blank: 'BLANK',
  NoteSourceKind.transcript: 'TRANSCRIPT',
  NoteSourceKind.unknown: 'unknown',
};

_NoteListModel _$NoteListModelFromJson(Map<String, dynamic> json) =>
    _NoteListModel(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => NoteSummaryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <NoteSummaryModel>[],
      nextCursor: json['next_cursor'] as String?,
    );

Map<String, dynamic> _$NoteListModelToJson(_NoteListModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'next_cursor': instance.nextCursor,
    };

_NoteOriginModel _$NoteOriginModelFromJson(Map<String, dynamic> json) =>
    _NoteOriginModel(
      transcriptId: json['transcript_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      available: json['available'] as bool? ?? false,
    );

Map<String, dynamic> _$NoteOriginModelToJson(_NoteOriginModel instance) =>
    <String, dynamic>{
      'transcript_id': instance.transcriptId,
      'title': instance.title,
      'available': instance.available,
    };

_NoteModel _$NoteModelFromJson(Map<String, dynamic> json) => _NoteModel(
  id: json['id'] as String? ?? '',
  title: json['title'] as String? ?? '',
  body: json['body'] as Map<String, dynamic>?,
  sourceKind:
      $enumDecodeNullable(
        _$NoteSourceKindEnumMap,
        json['source_kind'],
        unknownValue: NoteSourceKind.unknown,
      ) ??
      NoteSourceKind.unknown,
  source: json['source'] == null
      ? null
      : NoteOriginModel.fromJson(json['source'] as Map<String, dynamic>),
  revision: (json['revision'] as num?)?.toInt() ?? 0,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$NoteModelToJson(_NoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'source_kind': _$NoteSourceKindEnumMap[instance.sourceKind]!,
      'source': instance.source,
      'revision': instance.revision,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

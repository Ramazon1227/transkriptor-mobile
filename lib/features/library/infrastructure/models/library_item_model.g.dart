// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LibraryItemModel _$LibraryItemModelFromJson(Map<String, dynamic> json) =>
    _LibraryItemModel(
      mediaId: json['media_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      createdAt: json['created_at'] as String?,
      durationMs: (json['duration_ms'] as num?)?.toInt(),
      kind:
          $enumDecodeNullable(
            _$MediaKindEnumMap,
            json['kind'],
            unknownValue: MediaKind.unknown,
          ) ??
          MediaKind.unknown,
      source:
          $enumDecodeNullable(
            _$MediaSourceEnumMap,
            json['source'],
            unknownValue: MediaSource.unknown,
          ) ??
          MediaSource.unknown,
      linkProvider: json['link_provider'] as String?,
      jobId: json['job_id'] as String?,
      jobStatus: json['job_status'] as String?,
      transcriptId: json['transcript_id'] as String?,
      folderId: json['folder_id'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    );

Map<String, dynamic> _$LibraryItemModelToJson(_LibraryItemModel instance) =>
    <String, dynamic>{
      'media_id': instance.mediaId,
      'name': instance.name,
      'created_at': instance.createdAt,
      'duration_ms': instance.durationMs,
      'kind': _$MediaKindEnumMap[instance.kind]!,
      'source': _$MediaSourceEnumMap[instance.source]!,
      'link_provider': instance.linkProvider,
      'job_id': instance.jobId,
      'job_status': instance.jobStatus,
      'transcript_id': instance.transcriptId,
      'folder_id': instance.folderId,
      'tags': instance.tags,
    };

const _$MediaKindEnumMap = {
  MediaKind.audio: 'AUDIO',
  MediaKind.video: 'VIDEO',
  MediaKind.unknown: 'unknown',
};

const _$MediaSourceEnumMap = {
  MediaSource.upload: 'UPLOAD',
  MediaSource.recording: 'RECORDING',
  MediaSource.url: 'URL',
  MediaSource.api: 'API',
  MediaSource.unknown: 'unknown',
};

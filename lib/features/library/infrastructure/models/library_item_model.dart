import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';

part 'library_item_model.freezed.dart';
part 'library_item_model.g.dart';

/// `models.LibraryItem` in the backend.
@freezed
abstract class LibraryItemModel with _$LibraryItemModel {
  const factory LibraryItemModel({
    @JsonKey(name: 'media_id') @Default('') String mediaId,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'duration_ms') int? durationMs,
    @JsonKey(name: 'kind', unknownEnumValue: MediaKind.unknown)
    @Default(MediaKind.unknown)
    MediaKind kind,
    @JsonKey(name: 'source', unknownEnumValue: MediaSource.unknown)
    @Default(MediaSource.unknown)
    MediaSource source,
    @JsonKey(name: 'link_provider') String? linkProvider,
    @JsonKey(name: 'job_id') String? jobId,

    /// Empty string when there is no job; read as null.
    @JsonKey(name: 'job_status') String? jobStatus,
    @JsonKey(name: 'transcript_id') String? transcriptId,
    @JsonKey(name: 'folder_id') String? folderId,
    @JsonKey(name: 'tags') @Default(<String>[]) List<String> tags,
  }) = _LibraryItemModel;

  const LibraryItemModel._();

  factory LibraryItemModel.fromJson(Map<String, dynamic> json) =>
      _$LibraryItemModelFromJson(json);

  LibraryItem toEntity() => LibraryItem(
    mediaId: mediaId,
    name: name,
    createdAt: createdAt == null ? null : DateTime.tryParse(createdAt!),
    duration: durationMs == null || durationMs! <= 0
        ? null
        : Duration(milliseconds: durationMs!),
    kind: kind,
    source: source,
    linkProvider: _blankToNull(linkProvider),
    jobId: _blankToNull(jobId),
    jobStatus: _jobStatus(jobStatus),
    transcriptId: _blankToNull(transcriptId),
    folderId: _blankToNull(folderId),
    tags: tags,
  );
}

String? _blankToNull(String? s) => (s == null || s.isEmpty) ? null : s;

JobStatus? _jobStatus(String? raw) => switch (raw) {
  null || '' => null,
  'QUEUED' => JobStatus.queued,
  'RUNNING' => JobStatus.running,
  'SUCCEEDED' => JobStatus.succeeded,
  'FAILED' => JobStatus.failed,
  'CANCELLED' => JobStatus.cancelled,
  _ => JobStatus.unknown,
};

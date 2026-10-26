import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';

part 'library_item.freezed.dart';

enum MediaKind {
  @JsonValue('AUDIO')
  audio,
  @JsonValue('VIDEO')
  video,
  unknown,
}

/// Where the file came from.
enum MediaSource {
  @JsonValue('UPLOAD')
  upload,
  @JsonValue('RECORDING')
  recording,
  @JsonValue('URL')
  url,
  @JsonValue('API')
  api,
  unknown,
}

/// One row of the files list: a media file and its latest job.
@freezed
abstract class LibraryItem with _$LibraryItem {
  const factory LibraryItem({
    required String mediaId,
    required String name,
    DateTime? createdAt,
    Duration? duration,
    @Default(MediaKind.unknown) MediaKind kind,
    @Default(MediaSource.unknown) MediaSource source,

    /// YOUTUBE, GDRIVE or DROPBOX for a link; null otherwise.
    String? linkProvider,
    String? jobId,

    /// Null when the file was saved without starting transcription.
    JobStatus? jobStatus,
    String? transcriptId,
    @Default(<String>[]) List<String> tags,
  }) = _LibraryItem;
}

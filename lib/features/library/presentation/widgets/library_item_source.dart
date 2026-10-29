import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';

extension LibraryItemSource on LibraryItem {
  /// The icon a file row shows: where the file came from.
  CaptureSource get captureSource => switch (source) {
    MediaSource.recording =>
      meetingTitle != null ? CaptureSource.meeting : CaptureSource.recording,
    MediaSource.url => switch (linkProvider) {
      'YOUTUBE' => CaptureSource.youtube,
      'GDRIVE' || 'DROPBOX' => CaptureSource.cloud,
      _ => CaptureSource.url,
    },
    MediaSource.upload ||
    MediaSource.api ||
    MediaSource.unknown => CaptureSource.upload,
  };
}

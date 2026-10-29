import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';

/// The files screen's source tabs, other than «Eslatmalar» (notes have
/// their own API).
///
/// `/library?source=` knows UPLOAD, URL, RECORDING and API — no meeting
/// value. A meeting is a RECORDING with a `meeting_title`, so «Uchrashuvlar»
/// and «Yozuvlar» both ask the server for RECORDING and split the answer
/// on that title here.
enum FilesSource {
  all,
  uploads,
  meetings,
  recordings,
  links;

  /// What the server filters on; null asks for every origin.
  MediaSource? get serverSource => switch (this) {
    all => null,
    uploads => MediaSource.upload,
    meetings || recordings => MediaSource.recording,
    links => MediaSource.url,
  };

  /// The part of the filter the server cannot do.
  bool matches(LibraryItem item) => switch (this) {
    meetings => item.meetingTitle != null,
    recordings => item.meetingTitle == null,
    all || uploads || links => true,
  };
}

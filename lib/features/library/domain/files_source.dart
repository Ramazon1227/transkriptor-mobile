import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';

/// The files screen's source tabs, other than «Eslatmalar» (notes have
/// their own API).
///
/// `/library?source=` knows UPLOAD, URL, RECORDING and API — no meeting
/// value. A meeting is a RECORDING with a `meeting_title`, so «Uchrashuvlar»
/// and «Yozuvlar» both ask for RECORDING and split it with `meeting=`.
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

  /// `meeting=` on the server; null asks for both.
  bool? get meeting => switch (this) {
    meetings => true,
    recordings => false,
    all || uploads || links => null,
  };
}

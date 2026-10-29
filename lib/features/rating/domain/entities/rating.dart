import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating.freezed.dart';

/// The caller's own mark for a transcript, 1–5. Nobody else's is shown.
@freezed
abstract class Rating with _$Rating {
  const factory Rating({
    required int score,

    /// Written on the web; the phone sends it back unchanged.
    @Default('') String note,
  }) = _Rating;
}

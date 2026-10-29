import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';

/// A note on one segment. Not a task: there is no «resolved» here, the
/// server's field is neither read nor written. A reply is just another
/// comment on the same segment.
@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required String id,
    required String segmentId,
    required String body,

    /// Null when the author's account is gone.
    String? authorId,
    @Default('') String authorName,
    DateTime? createdAt,
  }) = _Comment;
}

abstract final class CommentRules {
  /// `models.MaxCommentLen`, in runes.
  static const int maxRunes = 2000;

  static String clean(String body) => body.trim();

  static bool tooLong(String body) => clean(body).runes.length > maxRunes;
}

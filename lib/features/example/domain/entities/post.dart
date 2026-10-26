import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

/// What the app works with. No JSON here — that is `PostModel`'s job.
@freezed
abstract class Post with _$Post {
  const factory Post({
    required int id,
    required String title,
    required String body,
    int? userId,
  }) = _Post;
}

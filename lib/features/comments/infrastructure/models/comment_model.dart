import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/comments/domain/entities/comment.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

/// `models.Comment` in the backend. `resolved_at` is not read: a comment
/// is a note, not a task.
@freezed
abstract class CommentModel with _$CommentModel {
  const factory CommentModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'segment_id') @Default('') String segmentId,
    @JsonKey(name: 'author_id') String? authorId,
    @JsonKey(name: 'author_name') @Default('') String authorName,
    @JsonKey(name: 'body') @Default('') String body,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _CommentModel;

  const CommentModel._();

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Comment toEntity() => Comment(
    id: id,
    segmentId: segmentId,
    body: body,
    authorId: (authorId?.isEmpty ?? true) ? null : authorId,
    authorName: authorName,
    createdAt: createdAt == null ? null : DateTime.tryParse(createdAt!),
  );
}

/// `handler.CommentListResponse`.
@freezed
abstract class CommentListModel with _$CommentListModel {
  const factory CommentListModel({
    @JsonKey(name: 'items') @Default(<CommentModel>[]) List<CommentModel> items,
  }) = _CommentListModel;

  factory CommentListModel.fromJson(Map<String, dynamic> json) =>
      _$CommentListModelFromJson(json);
}

/// `handler.CommentResponse`.
@freezed
abstract class CommentEnvelopeModel with _$CommentEnvelopeModel {
  const factory CommentEnvelopeModel({
    @JsonKey(name: 'comment') required CommentModel comment,
  }) = _CommentEnvelopeModel;

  factory CommentEnvelopeModel.fromJson(Map<String, dynamic> json) =>
      _$CommentEnvelopeModelFromJson(json);
}

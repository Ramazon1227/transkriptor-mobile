import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/example/domain/entities/post.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

/// DTO for one item of `GET /posts`. Every field has a default or is
/// nullable: the API guarantees none of them, and parsing must not crash.
@freezed
abstract class PostModel with _$PostModel {
  const factory PostModel({
    @JsonKey(name: 'id') @Default(0) int id,
    @JsonKey(name: 'userId') int? userId,
    @JsonKey(name: 'title') @Default('') String title,
    @JsonKey(name: 'body') @Default('') String body,
  }) = _PostModel;

  const PostModel._();

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Post toEntity() => Post(id: id, userId: userId, title: title, body: body);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_created_model.freezed.dart';
part 'media_created_model.g.dart';

/// `data` of `POST /api/v1/media`.
@freezed
abstract class MediaCreatedModel with _$MediaCreatedModel {
  const factory MediaCreatedModel({
    @JsonKey(name: 'id') @Default('') String id,

    /// Absolute: the API's own signed route, or an S3 pre-signed URL.
    @JsonKey(name: 'upload_url') @Default('') String uploadUrl,
  }) = _MediaCreatedModel;

  factory MediaCreatedModel.fromJson(Map<String, dynamic> json) =>
      _$MediaCreatedModelFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/player/domain/entities/media_source.dart';

part 'media_url_model.freezed.dart';
part 'media_url_model.g.dart';

/// `handler.MediaURLResponse` in the backend.
@freezed
abstract class MediaUrlModel with _$MediaUrlModel {
  const factory MediaUrlModel({
    @JsonKey(name: 'url') @Default('') String url,
    @JsonKey(name: 'mime') @Default('') String mime,
    @JsonKey(name: 'youtube_id') String? youtubeId,
  }) = _MediaUrlModel;

  const MediaUrlModel._();

  factory MediaUrlModel.fromJson(Map<String, dynamic> json) =>
      _$MediaUrlModelFromJson(json);

  MediaSource toEntity() => MediaSource(
    url: url,
    mime: mime,
    youtubeId: (youtubeId?.isEmpty ?? true) ? null : youtubeId,
  );
}

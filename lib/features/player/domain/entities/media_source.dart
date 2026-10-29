import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_source.freezed.dart';

/// Where the player reads a file from: `GET /media/:id/url`.
@freezed
abstract class MediaSource with _$MediaSource {
  const factory MediaSource({
    /// A signed read link for an upload, the canonical download link for
    /// a Drive/Dropbox file, the watch URL for YouTube.
    required String url,
    @Default('') String mime,

    /// Set for YouTube media only: no bytes on our side, and no package
    /// here plays YouTube, so there is no in-app playback.
    String? youtubeId,
  }) = _MediaSource;

  const MediaSource._();

  bool get isYoutube => (youtubeId ?? '').isNotEmpty;
}

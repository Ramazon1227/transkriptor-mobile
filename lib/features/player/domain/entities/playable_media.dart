import 'package:freezed_annotation/freezed_annotation.dart';

part 'playable_media.freezed.dart';

/// Where the player reads a file from: `GET /media/:id/url`.
@freezed
abstract class PlayableMedia with _$PlayableMedia {
  const factory PlayableMedia({
    /// A signed read link for an upload, the canonical download link for
    /// a Drive/Dropbox file, the watch URL for YouTube.
    required String url,
    @Default('') String mime,

    /// Set for YouTube media only: no bytes on our side, and no package
    /// here plays YouTube, so there is no in-app playback.
    String? youtubeId,
  }) = _PlayableMedia;

  const PlayableMedia._();

  bool get isYoutube => (youtubeId ?? '').isNotEmpty;
}

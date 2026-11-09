import 'package:flutter/widgets.dart';

/// Why an embedded player (YouTube) gave up. A fresh link would not help,
/// so the player shows the «open in YouTube» card instead of retrying.
enum EmbedFailure {
  /// The owner does not allow playing it on other sites (101, 150, 152).
  blocked,

  /// Removed or private (100, 105).
  notFound,

  /// Anything else: the player did not load, a bad id, an HTML5 error.
  other,
}

/// What the engine reports after every change; the player cubit turns it
/// into state.
@immutable
class PlaybackSnapshot {
  const PlaybackSnapshot({
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.playing = false,
    this.buffering = false,
    this.completed = false,
    this.hasVideo = false,
    this.aspectRatio = 16 / 9,
    this.error,
    this.embedFailure,
  });

  final Duration position;
  final Duration duration;
  final bool playing;
  final bool buffering;
  final bool completed;

  /// The file carries a picture. An audio file has none, whatever its
  /// container says.
  final bool hasVideo;
  final double aspectRatio;

  /// Playback broke (network, an expired link, a codec).
  final String? error;

  /// Set with [error] by an embedded player whose failure is final.
  final EmbedFailure? embedFailure;
}

/// The platform player behind an interface, so the cubit can be tested
/// without one. One engine plays one file; a new file is a new engine.
abstract interface class PlaybackEngine {
  /// Prepares [url] — a link, or a `file:` URI for a local file; throws
  /// when it cannot be opened.
  Future<void> open(Uri url);

  Stream<PlaybackSnapshot> get snapshots;

  Future<void> play();
  Future<void> pause();
  Future<void> seekTo(Duration position);
  Future<void> setSpeed(double speed);

  /// 0..1 of the phone's own volume; 0 is silent.
  Future<void> setVolume(double volume);

  /// The picture, for a file that has one. Folding the video away only
  /// stops drawing this; playback is the engine's and goes on.
  Widget surface();

  Future<void> dispose();
}

abstract interface class PlaybackEngineFactory {
  /// [youtube]: the source is a YouTube video, played in an embedded
  /// IFrame player; its `open` takes the watch URL.
  PlaybackEngine create({bool youtube = false});
}

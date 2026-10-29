import 'package:flutter/widgets.dart';

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
}

/// The platform player behind an interface, so the cubit can be tested
/// without one. One engine plays one file; a new file is a new engine.
abstract interface class PlaybackEngine {
  /// Prepares [url]; throws when it cannot be opened.
  Future<void> open(Uri url);

  Stream<PlaybackSnapshot> get snapshots;

  Future<void> play();
  Future<void> pause();
  Future<void> seekTo(Duration position);
  Future<void> setSpeed(double speed);

  /// The picture, for a file that has one. Folding the video away only
  /// stops drawing this; playback is the engine's and goes on.
  Widget surface();

  Future<void> dispose();
}

abstract interface class PlaybackEngineFactory {
  PlaybackEngine create();
}

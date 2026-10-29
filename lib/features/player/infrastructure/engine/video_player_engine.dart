import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/player/domain/playback_engine.dart';
import 'package:video_player/video_player.dart';

/// [PlaybackEngine] on the `video_player` plugin, which plays audio and
/// video alike.
class VideoPlayerEngine implements PlaybackEngine {
  VideoPlayerController? _controller;
  final StreamController<PlaybackSnapshot> _snapshots =
      StreamController<PlaybackSnapshot>.broadcast();

  @override
  Stream<PlaybackSnapshot> get snapshots => _snapshots.stream;

  @override
  Future<void> open(Uri url) async {
    final controller = VideoPlayerController.networkUrl(url);
    _controller = controller;
    await controller.initialize();
    controller.addListener(_report);
    _report();
  }

  void _report() {
    final c = _controller;
    if (c == null || _snapshots.isClosed) return;
    final v = c.value;
    _snapshots.add(
      PlaybackSnapshot(
        position: v.position,
        duration: v.duration,
        playing: v.isPlaying,
        buffering: v.isBuffering,
        completed: v.isCompleted,
        hasVideo: v.size.width > 0 && v.size.height > 0,
        aspectRatio: v.aspectRatio,
        error: v.hasError ? (v.errorDescription ?? 'error') : null,
      ),
    );
  }

  @override
  Future<void> play() async => await _controller?.play();

  @override
  Future<void> pause() async => await _controller?.pause();

  @override
  Future<void> seekTo(Duration position) async =>
      await _controller?.seekTo(position);

  @override
  Future<void> setSpeed(double speed) async =>
      await _controller?.setPlaybackSpeed(speed);

  @override
  Widget surface() {
    final c = _controller;
    return c == null ? const SizedBox.shrink() : VideoPlayer(c);
  }

  @override
  Future<void> dispose() async {
    final c = _controller;
    _controller = null;
    c?.removeListener(_report);
    await _snapshots.close();
    await c?.dispose();
  }
}

@LazySingleton(as: PlaybackEngineFactory)
class VideoPlayerEngineFactory implements PlaybackEngineFactory {
  @override
  PlaybackEngine create() => VideoPlayerEngine();
}

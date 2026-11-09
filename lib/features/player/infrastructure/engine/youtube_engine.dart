import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:transkriptor_uz/features/player/domain/playback_engine.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

/// [PlaybackEngine] on the YouTube IFrame player (E-24) — the API the web
/// editor uses (`components/youtube-player.tsx`), here inside a WebView.
///
/// The WebView loads the player only once [surface] is on screen, and the
/// controller holds every command until then. So commands are sent without
/// waiting for them: awaiting one before the cubit shows the surface would
/// never end. A command that fails comes back as a snapshot error.
class YoutubeEngine implements PlaybackEngine {
  YoutubeEngine({
    @visibleForTesting YoutubePlayerController Function()? controller,
  }) : _newController = controller ?? _defaultController;

  static YoutubePlayerController _defaultController() =>
      YoutubePlayerController(
        params: const YoutubePlayerParams(
          // Our transport drives it, as on the web (controls=0): one set of
          // controls, not two.
          showControls: false,
          strictRelatedVideos: true,
        ),
      );

  final YoutubePlayerController Function() _newController;
  YoutubePlayerController? _controller;
  StreamSubscription<YoutubePlayerValue>? _values;
  StreamSubscription<YoutubeVideoState>? _times;
  final StreamController<PlaybackSnapshot> _snapshots =
      StreamController<PlaybackSnapshot>.broadcast();
  PlaybackSnapshot _last = const PlaybackSnapshot(hasVideo: true);
  bool _failed = false;

  @override
  Stream<PlaybackSnapshot> get snapshots => _snapshots.stream;

  @override
  Future<void> open(Uri url) async {
    final id = YoutubePlayerController.convertUrlToId(url.toString());
    if (id == null) throw ArgumentError.value(url, 'url', 'not YouTube');
    final c = _newController();
    _controller = c;
    _values = c.stream.listen(_onValue);
    _times = c.videoStateStream.listen((v) => _push(position: v.position));
    // A picture: the cubit shows [surface], which loads the player.
    _push();
    _send((c) async {
      await c.cueVideoById(videoId: id);
      // Known once cued for most videos; otherwise on the first play.
      final seconds = await c.duration;
      if (seconds > 0) {
        _push(duration: Duration(milliseconds: (seconds * 1000).round()));
      }
    });
  }

  void _onValue(YoutubePlayerValue v) {
    if (v.hasError) return _fail(failureOf(v.error));
    final d = v.metaData.duration;
    _push(
      playing: v.playerState == PlayerState.playing,
      buffering: v.playerState == PlayerState.buffering,
      completed: v.playerState == PlayerState.ended,
      duration: d > Duration.zero ? d : null,
    );
  }

  /// The IFrame API's error codes, as the web's `errorText` groups them.
  static EmbedFailure failureOf(YoutubeError error) => switch (error) {
    YoutubeError.notEmbeddable ||
    YoutubeError.sameAsNotEmbeddable ||
    YoutubeError.sameAsNotEmbeddable2 => EmbedFailure.blocked,
    YoutubeError.videoNotFound ||
    YoutubeError.cannotFindVideo => EmbedFailure.notFound,
    YoutubeError.none ||
    YoutubeError.invalidParam ||
    YoutubeError.html5Error ||
    YoutubeError.unknown => EmbedFailure.other,
  };

  void _push({
    Duration? position,
    Duration? duration,
    bool? playing,
    bool? buffering,
    bool? completed,
  }) {
    if (_failed || _snapshots.isClosed) return;
    _last = PlaybackSnapshot(
      position: position ?? _last.position,
      duration: duration ?? _last.duration,
      playing: playing ?? _last.playing,
      buffering: buffering ?? _last.buffering,
      completed: completed ?? _last.completed,
      hasVideo: true,
    );
    _snapshots.add(_last);
  }

  void _fail(EmbedFailure why) {
    if (_failed || _snapshots.isClosed) return;
    _failed = true;
    _snapshots.add(
      PlaybackSnapshot(
        position: _last.position,
        duration: _last.duration,
        hasVideo: true,
        error: 'youtube: ${why.name}',
        embedFailure: why,
      ),
    );
  }

  /// Fire and forget, see the class comment. The controller's own timeout
  /// (the player never became ready) lands here too.
  void _send(Future<void> Function(YoutubePlayerController c) command) {
    final c = _controller;
    if (c == null) return;
    unawaited(
      command(c).then((_) {}, onError: (Object _) => _fail(EmbedFailure.other)),
    );
  }

  @override
  Future<void> play() async => _send((c) => c.playVideo());

  @override
  Future<void> pause() async => _send((c) => c.pauseVideo());

  @override
  Future<void> seekTo(Duration position) async {
    // Kept now: a paused player reports no time, and the next state change
    // must not carry the old position back.
    _push(position: position);
    _send(
      (c) => c.seekTo(
        seconds: position.inMilliseconds / 1000,
        allowSeekAhead: true,
      ),
    );
  }

  // shortcut: sent without checking getAvailablePlaybackRates (the web
  // does); YouTube's usual rates are exactly `playbackSpeeds`, so only an
  // odd video keeps its own rate while the button shows the choice.
  @override
  Future<void> setSpeed(double speed) async =>
      _send((c) => c.setPlaybackRate(speed));

  /// The IFrame API takes 0..100.
  @override
  Future<void> setVolume(double volume) async =>
      _send((c) => c.setVolume((volume.clamp(0.0, 1.0) * 100).round()));

  @override
  Widget surface() {
    final c = _controller;
    if (c == null) return const SizedBox.shrink();
    // Stays in the editor's layout: no fullscreen on rotation or drag.
    return YoutubePlayer(
      controller: c,
      autoFullScreen: false,
      enableFullScreenOnVerticalDrag: false,
    );
  }

  @override
  Future<void> dispose() async {
    final c = _controller;
    _controller = null;
    await _values?.cancel();
    await _times?.cancel();
    await _snapshots.close();
    // Not awaited: close() stops the video first, which waits up to 30 s
    // for a player that never became ready.
    unawaited(c?.close().then((_) {}, onError: (Object _) {}));
  }
}

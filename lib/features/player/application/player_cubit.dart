import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/player/domain/entities/playable_media.dart';
import 'package:transkriptor_uz/features/player/domain/i_player_facade.dart';
import 'package:transkriptor_uz/features/player/domain/playback_engine.dart';

part 'player_cubit.freezed.dart';

enum PlayerStatus {
  initial,
  loading,

  /// The engine has the file; the transport works.
  ready,

  /// YouTube media the embedded player could not play (the owner forbids
  /// embedding, removed, did not load): a link card instead.
  youtube,

  /// No file to play — removed by retention (410), not uploaded (422),
  /// gone (404). The transcript works without it.
  unavailable,

  /// The link or the engine failed (network, an expired link); a retry
  /// can fix it.
  failure,
}

/// The playback speeds the transport and the file actions offer.
const List<double> playbackSpeeds = [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2];

@freezed
abstract class PlayerState with _$PlayerState {
  const factory PlayerState({
    @Default(PlayerStatus.initial) PlayerStatus status,
    PlayableMedia? source,
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration duration,
    @Default(false) bool playing,
    @Default(false) bool buffering,
    @Default(false) bool hasVideo,
    @Default(16 / 9) double aspectRatio,
    @Default(1.0) double speed,

    /// 0..1 of the phone's volume; [muted] silences without forgetting it.
    @Default(1.0) double volume,
    @Default(false) bool muted,

    /// The video surface is folded away. Playback does not notice.
    @Default(false) bool videoFolded,

    /// Where the sample playing now starts; null when none is.
    Duration? clipStart,
    Failure? failure,

    /// Why the YouTube card shows ([PlayerStatus.youtube]).
    EmbedFailure? embedFailure,
  }) = _PlayerState;

  const PlayerState._();

  bool get canPlay => status == PlayerStatus.ready;
}

/// The editor's player: one file, one engine. The UI talks to this cubit
/// only; the engine stays behind [PlaybackEngine].
@injectable
class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit(this._facade, this._engines) : super(const PlayerState());

  final IPlayerFacade _facade;
  final PlaybackEngineFactory _engines;

  PlaybackEngine? _engine;

  // Cancelled in _release, which close() and every open() run.
  // ignore: cancel_subscriptions
  StreamSubscription<PlaybackSnapshot>? _sub;
  String? _mediaId;

  /// Bumped on every [open]; a late answer for an older one is dropped.
  int _generation = 0;

  /// The saved speed is read once; a choice made meanwhile outranks it.
  bool _speedKnown = false;

  /// What the open engine really plays at. A new engine starts at 1×.
  double _engineSpeed = 1;

  /// Like [_speedKnown], for the volume.
  bool _volumeKnown = false;

  /// The person wants sound: pressed play and has not paused since. A
  /// broken playback does not change it.
  bool _wantsPlay = false;

  /// A playback that broke reconnects by itself once (an expired link);
  /// it may again after it has played on for [_healthyAfter].
  bool _reconnected = false;
  Duration _reconnectedAt = Duration.zero;
  static const Duration _healthyAfter = Duration(seconds: 10);

  /// Where the playing sample stops itself, and where the player stood
  /// before the first one.
  Duration? _clipEnd;
  Duration? _clipReturn;

  /// Further past a sample's end than this is an old position, reported
  /// from before the seek: the new sample must not stop at once.
  static const Duration _clipSlack = Duration(seconds: 5);

  /// [mediaId] is the transcript's. Empty: there is no file to play.
  Future<void> open(String mediaId) => _load(mediaId, Duration.zero);

  /// After a failure: fetches a fresh link and goes back to where it was.
  Future<void> retry() async {
    final id = _mediaId;
    _reconnected = false;
    if (id != null) await _load(id, state.position);
  }

  /// The link expired mid-file (or the network dropped): a fresh link, the
  /// same second, playing again if it was.
  Future<void> _reconnect() async {
    final id = _mediaId;
    if (id == null) return;
    _reconnected = true;
    _reconnectedAt = state.position;
    await _load(id, state.position, play: _wantsPlay);
  }

  Future<void> _load(
    String mediaId,
    Duration resumeAt, {
    bool play = false,
  }) async {
    final generation = ++_generation;
    _mediaId = mediaId;
    await _release();
    if (isClosed || generation != _generation) return;
    if (mediaId.isEmpty) {
      emit(state.copyWith(status: PlayerStatus.unavailable, source: null));
      return;
    }
    emit(
      state.copyWith(
        status: PlayerStatus.loading,
        failure: null,
        embedFailure: null,
        playing: false,
        position: resumeAt,
      ),
    );
    final result = await _facade.mediaSource(mediaId);
    if (isClosed || generation != _generation) return;
    await result.fold(
      (failure) async => emit(
        state.copyWith(
          status: _isGone(failure)
              ? PlayerStatus.unavailable
              : PlayerStatus.failure,
          failure: failure,
        ),
      ),
      (source) => _start(generation, source, resumeAt, play: play),
    );
  }

  Future<void> _start(
    int generation,
    PlayableMedia source,
    Duration resumeAt, {
    bool play = false,
  }) async {
    await _restoreSpeed();
    await _restoreVolume();
    if (isClosed || generation != _generation) return;
    final engine = _engines.create(youtube: source.isYoutube);
    _engine = engine;
    _engineSpeed = 1;
    _sub = engine.snapshots.listen(_onSnapshot);
    try {
      await engine.open(Uri.parse(source.url));
      if (isClosed || generation != _generation) return;
      await _applySpeed(engine);
      if (isClosed || generation != _generation) return;
      await _applyVolume(engine);
      if (isClosed || generation != _generation) return;
      if (resumeAt > Duration.zero) await engine.seekTo(resumeAt);
      if (isClosed || generation != _generation) return;
      // A pause pressed (or the app sent to the background) while the fresh
      // link was fetched wins.
      if (play && _wantsPlay) await engine.play();
    } on Object {
      if (isClosed || generation != _generation) return;
      await _release();
      emit(
        source.isYoutube
            ? state.copyWith(
                status: PlayerStatus.youtube,
                source: source,
                embedFailure: EmbedFailure.other,
              )
            : state.copyWith(
                status: PlayerStatus.failure,
                failure: const Failure.unknown(),
              ),
      );
      return;
    }
    if (isClosed || generation != _generation) return;
    emit(
      state.copyWith(status: PlayerStatus.ready, source: source, failure: null),
    );
  }

  void _onSnapshot(PlaybackSnapshot s) {
    if (isClosed) return;
    final embed = s.embedFailure;
    if (embed != null) {
      unawaited(_embedFailed(embed));
      return;
    }
    if (s.error != null) {
      if (!_reconnected) {
        unawaited(_reconnect());
        return;
      }
      emit(
        state.copyWith(
          status: PlayerStatus.failure,
          playing: false,
          failure: const Failure.unknown(),
        ),
      );
      return;
    }
    if (s.completed) _wantsPlay = false;
    if (_reconnected &&
        s.playing &&
        s.position > _reconnectedAt + _healthyAfter) {
      _reconnected = false;
    }
    _checkClip(s);
    emit(
      state.copyWith(
        position: s.position,
        duration: s.duration,
        playing: s.playing,
        buffering: s.buffering,
        hasVideo: s.hasVideo,
        aspectRatio: s.aspectRatio > 0 ? s.aspectRatio : 16 / 9,
      ),
    );
  }

  /// YouTube refused (embedding forbidden, removed) or did not load: a fresh
  /// link would not help, so the card with «open in YouTube» takes over.
  Future<void> _embedFailed(EmbedFailure why) async {
    // Bumped: a _start still running for this engine must not show «ready»
    // over the card.
    final generation = ++_generation;
    _wantsPlay = false;
    await _release();
    if (isClosed || generation != _generation) return;
    emit(
      state.copyWith(
        status: PlayerStatus.youtube,
        embedFailure: why,
        playing: false,
        buffering: false,
      ),
    );
  }

  /// Stops by position, not by a timer: a slow network would eat the
  /// timer's seconds, and the chosen speed would stretch them.
  void _checkClip(PlaybackSnapshot s) {
    final end = _clipEnd;
    if (end == null) return;
    final atFileEnd = s.duration > Duration.zero && s.position >= s.duration;
    if (atFileEnd || (s.position >= end && s.position < end + _clipSlack)) {
      unawaited(stopClip());
    }
  }

  /// A speaker's voice: from [start] until [end], then it pauses by itself.
  Future<void> playClip(Duration start, Duration end) async {
    if (_engine == null || !state.canPlay) return;
    _clipReturn ??= state.position;
    _clipEnd = end;
    emit(state.copyWith(clipStart: start));
    await seekTo(start, play: true);
  }

  Future<void> stopClip() async {
    _clipEnd = null;
    emit(state.copyWith(clipStart: null));
    await pause();
  }

  /// The sheet closed: back to where the player stood before the samples.
  Future<void> leaveClips() async {
    final back = _clipReturn;
    if (back == null) return;
    _clipReturn = null;
    await stopClip();
    await seekTo(back);
  }

  Future<void> togglePlay() => state.playing ? pause() : play();

  /// From the end, playing starts over.
  Future<void> play() async {
    final engine = _engine;
    if (engine == null || !state.canPlay) return;
    if (state.duration > Duration.zero && state.position >= state.duration) {
      await engine.seekTo(Duration.zero);
    }
    _wantsPlay = true;
    await engine.play();
  }

  /// Also what the page calls when the app leaves the screen.
  Future<void> pause() async {
    if (_clipEnd != null) {
      _clipEnd = null;
      emit(state.copyWith(clipStart: null));
    }
    final wanted = _wantsPlay;
    _wantsPlay = false;
    final engine = _engine;
    // [wanted]: a play just sent may not have reported back yet (YouTube
    // answers through a WebView); the pause must still reach it.
    if (engine == null || !(state.playing || wanted)) return;
    await engine.pause();
  }

  Future<void> seekBy(Duration delta) => seekTo(state.position + delta);

  /// Clamped to the file. [play] starts playback from there — a tap on a
  /// segment's timecode.
  Future<void> seekTo(Duration position, {bool play = false}) async {
    final engine = _engine;
    if (engine == null || !state.canPlay) return;
    final end = state.duration;
    final at = position < Duration.zero
        ? Duration.zero
        : (end > Duration.zero && position > end ? end : position);
    // Shown at once; the engine's next snapshot confirms it.
    emit(state.copyWith(position: at));
    await engine.seekTo(at);
    if (play && !state.playing) {
      _wantsPlay = true;
      await engine.play();
    }
  }

  /// The choice is saved even if this file refuses it: the next one may not.
  Future<void> setSpeed(double speed) async {
    _speedKnown = true;
    emit(state.copyWith(speed: speed));
    final engine = _engine;
    if (engine != null) await _applySpeed(engine);
    await _facade.saveSpeed(speed);
  }

  Future<void> _restoreSpeed() async {
    if (_speedKnown) return;
    final saved = await _facade.savedSpeed();
    if (isClosed || _speedKnown) return;
    _speedKnown = true;
    if (playbackSpeeds.contains(saved)) emit(state.copyWith(speed: saved!));
  }

  /// Raising the level is «I want to hear it»: it unmutes. [save] false
  /// while a finger drags the slider; the release saves.
  Future<void> setVolume(double volume, {bool save = true}) async {
    _volumeKnown = true;
    final v = volume.clamp(0.0, 1.0);
    emit(state.copyWith(volume: v, muted: state.muted && v == 0));
    await _volumeChanged(save: save);
  }

  /// One press brings sound back from a level of zero, muted or not.
  Future<void> toggleMute() async {
    if (!state.muted && state.volume == 0) {
      await setVolume(0.5);
      return;
    }
    _volumeKnown = true;
    final muted = !state.muted;
    emit(
      state.copyWith(
        muted: muted,
        volume: !muted && state.volume == 0 ? 0.5 : state.volume,
      ),
    );
    await _volumeChanged();
  }

  Future<void> _volumeChanged({bool save = true}) async {
    final engine = _engine;
    if (engine != null) await _applyVolume(engine);
    if (save) await _facade.saveVolume(state.volume, muted: state.muted);
  }

  Future<void> _restoreVolume() async {
    if (_volumeKnown) return;
    final saved = await _facade.savedVolume();
    if (isClosed || _volumeKnown) return;
    _volumeKnown = true;
    if (saved != null) {
      emit(state.copyWith(volume: saved.volume, muted: saved.muted));
    }
  }

  /// A refused volume leaves the file playing at the phone's own level.
  Future<void> _applyVolume(PlaybackEngine engine) async {
    try {
      await engine.setVolume(state.muted ? 0 : state.volume);
    } on Object {
      // The phone's volume buttons still work.
    }
  }

  /// A file that refuses a speed still plays — a remembered 0,25× must not
  /// make it unopenable. The transport then shows the speed it really has.
  Future<void> _applySpeed(PlaybackEngine engine) async {
    final speed = state.speed;
    try {
      await engine.setSpeed(speed);
      _engineSpeed = speed;
    } on Object {
      if (!isClosed && identical(engine, _engine) && state.speed == speed) {
        emit(state.copyWith(speed: _engineSpeed));
      }
    }
  }

  /// YouTube media: opens the link in the YouTube app or the browser.
  /// False when nothing opened it — the card then copies the link.
  Future<bool> openLink() async {
    final url = state.source?.url;
    if (url == null || url.isEmpty) return false;
    return (await _facade.openLink(url)).isRight();
  }

  void toggleFold() => emit(state.copyWith(videoFolded: !state.videoFolded));

  /// The picture of a video file; null when there is no engine.
  Widget? surface() => _engine?.surface();

  static bool _isGone(Failure f) => switch (f) {
    ServerFailure(statusCode: 404 || 410 || 422) => true,
    _ => false,
  };

  Future<void> _release() async {
    final sub = _sub;
    final engine = _engine;
    _sub = null;
    _engine = null;
    // Not awaited: a broadcast subscription's cancel takes effect at once,
    // and its future (a root-zone one) never completes under fake async.
    unawaited(sub?.cancel());
    await engine?.dispose();
  }

  @override
  Future<void> close() async {
    await _release();
    await super.close();
  }
}

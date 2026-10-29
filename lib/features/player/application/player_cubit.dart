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

  /// YouTube media: no bytes on our side, a link card instead.
  youtube,

  /// No file to play — removed by retention (410), not uploaded (422),
  /// gone (404). The transcript works without it.
  unavailable,

  /// The link or the engine failed (network, an expired link); a retry
  /// can fix it.
  failure,
}

/// The playback speeds the transport and the file actions offer.
const List<double> playbackSpeeds = [0.75, 1, 1.25, 1.5, 2];

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

    /// The video surface is folded away. Playback does not notice.
    @Default(false) bool videoFolded,
    Failure? failure,
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

  /// [mediaId] is the transcript's. Empty: there is no file to play.
  Future<void> open(String mediaId) => _load(mediaId, Duration.zero);

  /// After a failure: fetches a fresh link and goes back to where it was.
  Future<void> retry() async {
    final id = _mediaId;
    if (id != null) await _load(id, state.position);
  }

  Future<void> _load(String mediaId, Duration resumeAt) async {
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
      (source) async {
        if (source.isYoutube) {
          emit(state.copyWith(status: PlayerStatus.youtube, source: source));
          return;
        }
        await _start(generation, source, resumeAt);
      },
    );
  }

  Future<void> _start(
    int generation,
    PlayableMedia source,
    Duration resumeAt,
  ) async {
    final engine = _engines.create();
    _engine = engine;
    _sub = engine.snapshots.listen(_onSnapshot);
    try {
      await engine.open(Uri.parse(source.url));
      if (isClosed || generation != _generation) return;
      await engine.setSpeed(state.speed);
      if (resumeAt > Duration.zero) await engine.seekTo(resumeAt);
    } on Object {
      if (isClosed || generation != _generation) return;
      await _release();
      emit(
        state.copyWith(
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
    if (s.error != null) {
      emit(
        state.copyWith(
          status: PlayerStatus.failure,
          playing: false,
          failure: const Failure.unknown(),
        ),
      );
      return;
    }
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

  Future<void> togglePlay() => state.playing ? pause() : play();

  /// From the end, playing starts over.
  Future<void> play() async {
    final engine = _engine;
    if (engine == null || !state.canPlay) return;
    if (state.duration > Duration.zero && state.position >= state.duration) {
      await engine.seekTo(Duration.zero);
    }
    await engine.play();
  }

  /// Also what the page calls when the app leaves the screen.
  Future<void> pause() async {
    final engine = _engine;
    if (engine == null || !state.playing) return;
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
    if (play && !state.playing) await engine.play();
  }

  Future<void> setSpeed(double speed) async {
    emit(state.copyWith(speed: speed));
    await _engine?.setSpeed(speed);
  }

  /// YouTube media: hands the link to the system share sheet. A failure
  /// there is the system's to show; nothing changes here.
  Future<void> shareLink() async {
    final url = state.source?.url;
    if (url == null || url.isEmpty) return;
    await _facade.shareLink(url);
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
    await sub?.cancel();
    await engine?.dispose();
  }

  @override
  Future<void> close() async {
    await _release();
    await super.close();
  }
}

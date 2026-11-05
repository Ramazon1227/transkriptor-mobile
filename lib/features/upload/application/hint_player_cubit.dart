import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/player/domain/playback_engine.dart';

part 'hint_player_cubit.freezed.dart';

enum HintPlayerStatus { initial, loading, ready, failure }

@freezed
abstract class HintPlayerState with _$HintPlayerState {
  const factory HintPlayerState({
    @Default(HintPlayerStatus.initial) HintPlayerStatus status,
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration duration,
    @Default(false) bool playing,
  }) = _HintPlayerState;
}

/// Plays a picked file before it is uploaded, so the person can mark who
/// speaks where (ClickUp A-3). The editor's `PlayerCubit` fetches a link
/// by media id; this one opens the local path, with a plain transport.
@injectable
class HintPlayerCubit extends Cubit<HintPlayerState> {
  HintPlayerCubit(this._engines) : super(const HintPlayerState());

  final PlaybackEngineFactory _engines;
  PlaybackEngine? _engine;

  // Cancelled in _release, which close() and every open() run.
  // ignore: cancel_subscriptions
  StreamSubscription<PlaybackSnapshot>? _sub;

  /// Bumped on every [open]; a late open of an older file is dropped.
  int _generation = 0;

  Future<void> open(String path) async {
    final generation = ++_generation;
    await _release();
    if (isClosed || generation != _generation) return;
    emit(const HintPlayerState(status: HintPlayerStatus.loading));
    final engine = _engines.create();
    _engine = engine;
    // Listening first: the engine reports the length as it opens.
    _sub = engine.snapshots.listen((s) {
      if (isClosed || generation != _generation) return;
      emit(
        state.copyWith(
          status: s.error == null
              ? HintPlayerStatus.ready
              : HintPlayerStatus.failure,
          position: s.position,
          duration: s.duration,
          playing: s.playing,
        ),
      );
    });
    try {
      await engine.open(Uri.file(path));
    } on Object {
      if (!isClosed && generation == _generation) {
        await _release();
        emit(const HintPlayerState(status: HintPlayerStatus.failure));
      }
      return;
    }
    if (isClosed || generation != _generation) return;
    if (state.status == HintPlayerStatus.loading) {
      emit(state.copyWith(status: HintPlayerStatus.ready));
    }
  }

  Future<void> toggle() async {
    final engine = _engine;
    if (engine == null) return;
    if (state.playing) {
      await engine.pause();
    } else {
      // At the end, play starts over.
      if (state.duration > Duration.zero && state.position >= state.duration) {
        await engine.seekTo(Duration.zero);
      }
      await engine.play();
    }
  }

  Future<void> pause() async => await _engine?.pause();

  /// ±5 s from the transport; clamped to the file.
  Future<void> seekBy(Duration delta) => seekTo(state.position + delta);

  Future<void> seekTo(Duration position) async {
    final engine = _engine;
    if (engine == null) return;
    var to = position < Duration.zero ? Duration.zero : position;
    if (state.duration > Duration.zero && to > state.duration) {
      to = state.duration;
    }
    // The slider moves at once; the engine's own report follows.
    emit(state.copyWith(position: to));
    await engine.seekTo(to);
  }

  /// Plays from [position] (a hint's start in the list).
  Future<void> playFrom(Duration position) async {
    await seekTo(position);
    await _engine?.play();
  }

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
    _generation++;
    await _release();
    await super.close();
  }
}

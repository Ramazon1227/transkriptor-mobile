import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recording.dart';
import 'package:transkriptor_uz/features/recorder/domain/i_recorder_facade.dart';

part 'recorder_cubit.freezed.dart';

enum RecorderStatus {
  idle,
  starting,
  recording,
  paused,
  stopping,
  done,
  failure,
}

/// How many recent level samples the meter draws.
const int recorderMeterLength = 48;

@freezed
abstract class RecorderState with _$RecorderState {
  const factory RecorderState({
    @Default(RecorderStatus.idle) RecorderStatus status,
    @Default(Duration.zero) Duration elapsed,

    /// Most recent last, each 0–1.
    @Default(<double>[]) List<double> levels,
    Recording? recording,
    Failure? failure,
  }) = _RecorderState;
}

@injectable
class RecorderCubit extends Cubit<RecorderState> {
  RecorderCubit(this._facade) : super(const RecorderState());

  final IRecorderFacade _facade;

  /// Counts only time spent recording; paused while paused.
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _ticker;
  StreamSubscription<double>? _levels;

  bool get _active =>
      state.status == RecorderStatus.recording ||
      state.status == RecorderStatus.paused;

  Future<void> start() async {
    if (state.status == RecorderStatus.starting || _active) return;
    emit(const RecorderState(status: RecorderStatus.starting));
    final result = await _facade.start();
    if (isClosed) {
      // The screen went away while the permission dialog was up; the
      // recorder started anyway, so turn it off.
      if (result.isRight()) await _facade.discard();
      return;
    }
    result.fold(
      (failure) => emit(
        state.copyWith(status: RecorderStatus.failure, failure: failure),
      ),
      (_) {
        _stopwatch
          ..reset()
          ..start();
        _ticker = Timer.periodic(const Duration(milliseconds: 200), (_) {
          if (!isClosed) emit(state.copyWith(elapsed: _stopwatch.elapsed));
        });
        _levels = _facade.levels().listen(_onLevel);
        emit(state.copyWith(status: RecorderStatus.recording));
      },
    );
  }

  void _onLevel(double level) {
    if (isClosed || state.status != RecorderStatus.recording) return;
    final next = [...state.levels, level];
    final start = next.length > recorderMeterLength
        ? next.length - recorderMeterLength
        : 0;
    emit(state.copyWith(levels: next.sublist(start)));
  }

  Future<void> togglePause() async {
    if (state.status == RecorderStatus.recording) {
      final result = await _facade.pause();
      if (isClosed) return;
      result.fold((f) => emit(state.copyWith(failure: f)), (_) {
        _stopwatch.stop();
        emit(
          state.copyWith(
            status: RecorderStatus.paused,
            elapsed: _stopwatch.elapsed,
            failure: null,
          ),
        );
      });
    } else if (state.status == RecorderStatus.paused) {
      final result = await _facade.resume();
      if (isClosed) return;
      result.fold((f) => emit(state.copyWith(failure: f)), (_) {
        _stopwatch.start();
        emit(state.copyWith(status: RecorderStatus.recording, failure: null));
      });
    }
  }

  Future<void> stop() async {
    if (!_active) return;
    _stopwatch.stop();
    await _stopTicking();
    if (isClosed) return;
    emit(
      state.copyWith(
        status: RecorderStatus.stopping,
        elapsed: _stopwatch.elapsed,
      ),
    );
    final result = await _facade.stop(duration: _stopwatch.elapsed);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(status: RecorderStatus.failure, failure: failure),
      ),
      (recording) => emit(
        state.copyWith(status: RecorderStatus.done, recording: recording),
      ),
    );
  }

  /// Throws the recording away.
  Future<void> discard() async {
    final wasActive = _active;
    _stopwatch.stop();
    await _stopTicking();
    if (wasActive) await _facade.discard();
    if (!isClosed) emit(const RecorderState());
  }

  Future<void> _stopTicking() async {
    _ticker?.cancel();
    _ticker = null;
    await _levels?.cancel();
    _levels = null;
  }

  @override
  Future<void> close() async {
    // Leaving the screen mid-recording must not leave the microphone on.
    if (_active) await _facade.discard();
    await _stopTicking();
    await super.close();
  }
}

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

    /// Paused by a call or another app, not by the user (MB-10).
    @Default(false) bool interrupted,
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
  StreamSubscription<RecorderInterruption>? _interruptions;

  /// An interruption that arrived while starting or resuming; applied once
  /// that is over.
  RecorderInterruption? _early;
  bool _resuming = false;

  bool get _active =>
      state.status == RecorderStatus.recording ||
      state.status == RecorderStatus.paused;

  Future<void> start() async {
    if (state.status == RecorderStatus.starting || _active) return;
    emit(const RecorderState(status: RecorderStatus.starting));
    // Before start: a call during the start must not be missed.
    _early = null;
    await _interruptions?.cancel();
    _interruptions = _facade.interruptions().listen(_onInterruption);
    final result = await _facade.start();
    if (result.isLeft()) {
      await _interruptions?.cancel();
      _interruptions = null;
    }
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
        _applyEarly();
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

  void _onInterruption(RecorderInterruption kind) {
    if (isClosed) return;
    if (state.status == RecorderStatus.starting || _resuming) {
      if (_early != RecorderInterruption.stopped) _early = kind;
      return;
    }
    switch (kind) {
      case RecorderInterruption.paused:
        if (state.status != RecorderStatus.recording) return;
        _stopwatch.stop();
        emit(
          state.copyWith(
            status: RecorderStatus.paused,
            elapsed: _stopwatch.elapsed,
            interrupted: true,
          ),
        );
      case RecorderInterruption.stopped:
        // Nothing more will be recorded: keep what the file holds.
        unawaited(stop());
    }
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
      _early = null;
      _resuming = true;
      final result = await _facade.resume();
      _resuming = false;
      if (isClosed) return;
      result.fold((f) => emit(state.copyWith(failure: f)), (_) {
        _stopwatch.start();
        emit(
          state.copyWith(
            status: RecorderStatus.recording,
            failure: null,
            interrupted: false,
          ),
        );
      });
      _applyEarly();
    }
  }

  void _applyEarly() {
    final early = _early;
    _early = null;
    if (early != null) _onInterruption(early);
  }

  Future<void> stop() async {
    if (isClosed || !_active) return;
    _stopwatch.stop();
    // `stopping` before the first await: a close() landing meanwhile (session
    // expiry) then sees nothing active and does not stop the same file twice.
    emit(
      state.copyWith(
        status: RecorderStatus.stopping,
        elapsed: _stopwatch.elapsed,
      ),
    );
    await _stopTicking();
    if (isClosed) return;
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
    await _interruptions?.cancel();
    _interruptions = null;
  }

  @override
  Future<void> close() async {
    // Leaving the screen mid-recording must not leave the microphone on —
    // and must not lose the recording either (R-4): an expired session sends
    // the router to login past the PopScope. The file is closed and kept;
    // the recovery card offers it after the next sign-in.
    if (_active) {
      _stopwatch.stop();
      await _facade.stop(duration: _stopwatch.elapsed);
    }
    await _stopTicking();
    await super.close();
  }
}

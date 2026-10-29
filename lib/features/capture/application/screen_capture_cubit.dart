import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/screen_capture_event.dart';
import 'package:transkriptor_uz/features/capture/domain/i_screen_capture_facade.dart';
import 'package:transkriptor_uz/features/recorder/application/recorder_cubit.dart'
    show recorderMeterLength;
import 'package:transkriptor_uz/features/recorder/domain/entities/recording.dart';

part 'screen_capture_cubit.freezed.dart';

enum ScreenCaptureStatus { idle, starting, recording, stopping, done, failure }

@freezed
abstract class ScreenCaptureState with _$ScreenCaptureState {
  const factory ScreenCaptureState({
    @Default(ScreenCaptureStatus.idle) ScreenCaptureStatus status,

    /// Null until [ScreenCaptureCubit.init] has asked. False on iOS and
    /// Android below 10: the page says why instead of offering a button.
    bool? supported,
    @Default(false) bool withMic,
    @Default(Duration.zero) Duration elapsed,

    /// Most recent last, each 0–1.
    @Default(<double>[]) List<double> levels,

    /// Nothing came from playback in the first seconds: nothing is
    /// playing, or the app playing forbids capture (call apps do).
    @Default(false) bool playbackSilent,

    /// Set with [ScreenCaptureStatus.done]: send it like a microphone
    /// recording (`UploadSource.recording`).
    Recording? recording,
    Failure? failure,
  }) = _ScreenCaptureState;
}

@injectable
class ScreenCaptureCubit extends Cubit<ScreenCaptureState> {
  ScreenCaptureCubit(this._facade) : super(const ScreenCaptureState());

  final IScreenCaptureFacade _facade;
  StreamSubscription<ScreenCaptureEvent>? _events;

  bool get _active =>
      state.status == ScreenCaptureStatus.recording ||
      state.status == ScreenCaptureStatus.starting;

  /// Reads support, and picks up a capture that kept running while the
  /// app's UI was gone.
  Future<void> init() async {
    final supported = await _facade.isSupported();
    if (isClosed) return;
    emit(state.copyWith(supported: supported));
    if (!supported) return;
    final session = await _facade.current();
    if (isClosed || session == null) return;
    _listen();
    emit(
      state.copyWith(
        status: ScreenCaptureStatus.recording,
        elapsed: session.elapsed,
        withMic: session.withMic,
      ),
    );
  }

  Future<void> start({required bool withMic}) async {
    if (_active || state.status == ScreenCaptureStatus.stopping) return;
    emit(
      ScreenCaptureState(
        status: ScreenCaptureStatus.starting,
        supported: state.supported,
        withMic: withMic,
      ),
    );
    _listen();
    final result = await _facade.start(withMic: withMic);
    if (isClosed) {
      // Left while the consent dialog was up; it started anyway.
      if (result.isRight()) await _facade.cancel();
      return;
    }
    result.fold((failure) {
      unawaited(_stopListening());
      emit(
        state.copyWith(status: ScreenCaptureStatus.failure, failure: failure),
      );
    }, (_) => emit(state.copyWith(status: ScreenCaptureStatus.recording)));
  }

  Future<void> stop() async {
    if (state.status != ScreenCaptureStatus.recording) return;
    emit(state.copyWith(status: ScreenCaptureStatus.stopping));
    final result = await _facade.stop();
    await _stopListening();
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(status: ScreenCaptureStatus.failure, failure: failure),
      ),
      (recording) => emit(
        state.copyWith(status: ScreenCaptureStatus.done, recording: recording),
      ),
    );
  }

  /// Stops and throws the recording away.
  Future<void> cancel() async {
    final wasActive = _active || state.status == ScreenCaptureStatus.stopping;
    await _stopListening();
    if (wasActive) await _facade.cancel();
    if (!isClosed) emit(ScreenCaptureState(supported: state.supported));
  }

  void _listen() {
    _events ??= _facade.events().listen(_onEvent);
  }

  Future<void> _stopListening() async {
    await _events?.cancel();
    _events = null;
  }

  void _onEvent(ScreenCaptureEvent event) {
    if (isClosed) return;
    switch (event) {
      case ScreenCaptureLevel(:final level, :final elapsed):
        if (state.status != ScreenCaptureStatus.recording) return;
        final next = [...state.levels, level];
        final from = next.length > recorderMeterLength
            ? next.length - recorderMeterLength
            : 0;
        emit(state.copyWith(elapsed: elapsed, levels: next.sublist(from)));
      case ScreenCaptureSilent():
        emit(state.copyWith(playbackSilent: true));
      case ScreenCaptureEnded(:final recording, :final failure):
        if (state.status == ScreenCaptureStatus.stopping) return;
        unawaited(_stopListening());
        emit(
          recording != null
              ? state.copyWith(
                  status: ScreenCaptureStatus.done,
                  recording: recording,
                  failure: failure,
                )
              : state.copyWith(
                  status: ScreenCaptureStatus.failure,
                  failure: failure ?? const Failure.storage(),
                ),
        );
    }
  }

  @override
  Future<void> close() async {
    // Leaving the screen mid-capture must not leave capture running
    // unseen; the notification's stop button covers the app being killed.
    if (_active) await _facade.cancel();
    await _stopListening();
    await super.close();
  }
}

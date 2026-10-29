import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recording.dart';

part 'screen_capture_event.freezed.dart';

/// What a running screen-audio capture reports.
@freezed
sealed class ScreenCaptureEvent with _$ScreenCaptureEvent {
  /// About ten a second. [level] is 0 (silence) to 1 (loud), of what is
  /// being written (playback plus microphone when mixed).
  const factory ScreenCaptureEvent.level({
    required double level,
    required Duration elapsed,
  }) = ScreenCaptureLevel;

  /// Five seconds and not one sample from playback: nothing is playing,
  /// or the app playing has opted out of capture (most call apps do).
  /// The capture goes on.
  const factory ScreenCaptureEvent.silent() = ScreenCaptureSilent;

  /// Stopped without being asked from Dart: the notification's stop
  /// button, "stop sharing" in the system UI, or a failure. [recording] is
  /// what was kept, if anything.
  const factory ScreenCaptureEvent.ended({
    Recording? recording,
    Failure? failure,
  }) = ScreenCaptureEnded;
}

/// A capture already running natively, e.g. after the app was reopened.
@freezed
abstract class ScreenCaptureSession with _$ScreenCaptureSession {
  const factory ScreenCaptureSession({
    required Duration elapsed,
    required bool withMic,
  }) = _ScreenCaptureSession;
}

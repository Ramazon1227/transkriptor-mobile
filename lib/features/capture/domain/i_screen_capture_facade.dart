import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/capture/domain/entities/screen_capture_event.dart';
import 'package:transkriptor_uz/features/recorder/domain/entities/recording.dart';

/// Records what the phone plays ("Ekranni yozish": audio only, no video),
/// optionally mixed with the microphone. Android 10+ only.
///
/// Apps may forbid capture of their audio; voice-call apps nearly always
/// do, so this is not call recording. Such audio is just missing (silence),
/// which [ScreenCaptureEvent.silent] hints at.
abstract interface class IScreenCaptureFacade {
  /// False on iOS and on Android below 10.
  Future<bool> isSupported();

  /// Asks for the microphone (playback capture needs it even when the
  /// microphone is not mixed in), then for screen-capture consent, then
  /// starts. Failures: `permissionDenied`, `capture(unsupported)`,
  /// `capture(consentDenied)`, `capture(busy)`, `capture(captureFailed)`,
  /// `storage`.
  Future<Either<Failure, Unit>> start({required bool withMic});

  /// Stops and returns the .m4a, ready for the send flow.
  Future<Either<Failure, Recording>> stop();

  /// Stops and deletes the file.
  Future<void> cancel();

  /// The capture still running natively (it outlives the app's UI), or
  /// null.
  Future<ScreenCaptureSession?> current();

  Stream<ScreenCaptureEvent> events();
}

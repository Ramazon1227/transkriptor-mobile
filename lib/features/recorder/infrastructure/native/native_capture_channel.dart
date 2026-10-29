import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

/// Method channel to the app's own Android code
/// (`android/app/src/main/kotlin/.../capture/CaptureChannel.kt`).
const String captureMethodChannel = 'uz.transkriptor/capture';

/// Screen-audio events (`level`, `silent`, `ended`).
const String captureEventChannel = 'uz.transkriptor/capture/screen';

/// Error codes the native side answers with (`CaptureErrors`).
abstract final class CaptureErrorCodes {
  static const unsupported = 'UNSUPPORTED';
  static const consentDenied = 'CONSENT_DENIED';
  static const micPermission = 'MIC_PERMISSION';
  static const captureFailed = 'CAPTURE_FAILED';
  static const busy = 'BUSY';
  static const notRunning = 'NOT_RUNNING';
  static const storage = 'STORAGE';
}

/// The parts of the native channel the recorder needs: the keep-alive
/// service for microphone recording and the file helpers. Methods throw
/// [PlatformException] / [MissingPluginException]; callers catch.
@lazySingleton
class NativeCaptureChannel {
  NativeCaptureChannel() : _channel = const MethodChannel(captureMethodChannel);

  final MethodChannel _channel;

  /// Starts the microphone foreground service (ongoing notification).
  /// Must be called while the app is visible (Android 14).
  Future<void> startMicService() =>
      _channel.invokeMethod<void>('mic.startService');

  Future<void> stopMicService() =>
      _channel.invokeMethod<void>('mic.stopService');

  /// Android 13+ notification permission; true below 13 or when granted.
  /// A refusal only hides the notification, the recording still runs.
  Future<bool> requestNotifications() async =>
      await _channel.invokeMethod<bool>('notifications.request') ?? false;

  /// Remuxes the ADTS file [src] into the .m4a [dst]; returns its length.
  /// Stops at a truncated last frame.
  Future<Duration> finalize({required String src, required String dst}) async {
    final ms = await _channel.invokeMethod<int>('file.finalize', {
      'src': src,
      'dst': dst,
    });
    if (ms == null) throw PlatformException(code: CaptureErrorCodes.storage);
    return Duration(milliseconds: ms);
  }

  /// The length of a playable media file, null when unknown.
  Future<Duration?> durationOf(String path) async {
    final ms = await _channel.invokeMethod<int>('file.durationMs', {
      'path': path,
    });
    return ms == null ? null : Duration(milliseconds: ms);
  }

  /// The file a running native screen capture is writing, if any. It can
  /// outlive the Flutter engine (app swiped away), so recovery asks here
  /// instead of trusting memory.
  Future<String?> activeScreenPath() async {
    final status = await _channel.invokeMapMethod<String, Object?>(
      'screen.status',
    );
    return status?['path'] as String?;
  }
}

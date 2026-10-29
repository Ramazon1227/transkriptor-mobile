import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/recorder/infrastructure/native/native_capture_channel.dart';

/// What the native side answers on stop: the file and its length.
typedef ScreenAudioResult = ({String path, int durationMs});

/// The raw screen-audio half of the native channel
/// (`CaptureChannel.kt` / `ScreenAudioService.kt`). Throws
/// [PlatformException] with a `CaptureErrorCodes` code; the facade maps.
@lazySingleton
class ScreenAudioSource {
  ScreenAudioSource()
    : _methods = const MethodChannel(captureMethodChannel),
      _events = const EventChannel(captureEventChannel);

  final MethodChannel _methods;
  final EventChannel _events;

  /// False where the channel does not exist (iOS, tests without a mock).
  Future<bool> isSupported() async {
    try {
      return await _methods.invokeMethod<bool>('screen.isSupported') ?? false;
    } on MissingPluginException {
      return false;
    }
  }

  /// Opens the system consent dialog, then starts the foreground service
  /// writing ADTS to [path]. Completes once the capture runs.
  Future<void> start({required String path, required bool withMic}) => _methods
      .invokeMethod<void>('screen.start', {'path': path, 'withMic': withMic});

  /// The .m4a (or the .aac when remuxing failed).
  Future<ScreenAudioResult> stop() async {
    final map = await _methods.invokeMapMethod<String, Object?>('screen.stop');
    final result = _result(map);
    if (result == null) {
      throw PlatformException(code: CaptureErrorCodes.storage);
    }
    return result;
  }

  Future<void> cancel() => _methods.invokeMethod<void>('screen.cancel');

  /// `{path, elapsedMs, withMic}` of a running capture, or null.
  Future<Map<String, Object?>?> status() =>
      _methods.invokeMapMethod<String, Object?>('screen.status');

  /// Raw maps: `{event: level, level, elapsedMs}`, `{event: silent}`,
  /// `{event: ended, path?, durationMs?, error?}`.
  Stream<Map<String, Object?>> events() => _events
      .receiveBroadcastStream()
      .where((e) => e is Map)
      .map((e) => Map<String, Object?>.from(e as Map));

  static ScreenAudioResult? _result(Map<String, Object?>? map) {
    final path = map?['path'];
    if (path is! String || path.isEmpty) return null;
    final ms = map?['durationMs'];
    return (path: path, durationMs: ms is int ? ms : 0);
  }

  /// For `ended` events, which carry the same fields.
  static ScreenAudioResult? resultOf(Map<String, Object?> event) =>
      _result(event);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'recoverable_recording.freezed.dart';

/// Where a recording came from.
enum RecordingKind { microphone, screen }

/// How far a leftover recording got.
enum RecordingCompletion {
  /// Raw AAC (ADTS) from a session that never stopped — the app was
  /// killed or crashed. Readable up to its last whole frame; turned into
  /// an .m4a when recovered.
  interrupted,

  /// A finished .m4a that was never uploaded.
  finished,
}

/// A recording left on this device from an earlier session, not yet sent.
@freezed
abstract class RecoverableRecording with _$RecoverableRecording {
  const factory RecoverableRecording({
    required String path,
    required RecordingKind kind,
    required RecordingCompletion state,
    required DateTime createdAt,
    required int sizeBytes,

    /// Exact for interrupted ones (counted from the frames); read from the
    /// file for finished ones; null when it could not be read.
    Duration? duration,
  }) = _RecoverableRecording;
}

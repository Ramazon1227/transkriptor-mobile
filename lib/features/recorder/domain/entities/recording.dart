import 'package:freezed_annotation/freezed_annotation.dart';

part 'recording.freezed.dart';

/// A finished recording on this device, waiting to be sent.
@freezed
abstract class Recording with _$Recording {
  const factory Recording({
    required String path,
    required int sizeBytes,
    required Duration duration,
  }) = _Recording;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'held_file.freezed.dart';

enum HeldFileState { unconfirmed, waiting, failed, cancelled }

/// A file holding a place in the workspace's limit of files not yet
/// transcribed (`data.held` of a 409 PENDING_LIMIT).
@freezed
abstract class HeldFile with _$HeldFile {
  const factory HeldFile({
    required String id,
    required String name,
    required HeldFileState state,
    required int sizeBytes,

    /// The server deletes it by itself at this time.
    DateTime? expiresAt,

    /// False for someone else's unfinished upload and a running recording.
    @Default(false) bool deletable,
  }) = _HeldFile;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'folder.freezed.dart';

/// A flat folder of the workspace (folders do not nest).
@freezed
abstract class Folder with _$Folder {
  const factory Folder({
    required String id,
    required String name,

    /// Live files inside; uploads still in progress are not counted.
    @Default(0) int fileCount,
  }) = _Folder;
}

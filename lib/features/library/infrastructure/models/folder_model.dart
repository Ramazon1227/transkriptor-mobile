import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/library/domain/entities/folder.dart';

part 'folder_model.freezed.dart';
part 'folder_model.g.dart';

/// `models.Folder` in the backend.
@freezed
abstract class FolderModel with _$FolderModel {
  const factory FolderModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'file_count') @Default(0) int fileCount,
  }) = _FolderModel;

  const FolderModel._();

  factory FolderModel.fromJson(Map<String, dynamic> json) =>
      _$FolderModelFromJson(json);

  Folder toEntity() => Folder(id: id, name: name, fileCount: fileCount);
}

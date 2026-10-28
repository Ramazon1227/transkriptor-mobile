// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FolderModel _$FolderModelFromJson(Map<String, dynamic> json) => _FolderModel(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  fileCount: (json['file_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$FolderModelToJson(_FolderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'file_count': instance.fileCount,
    };

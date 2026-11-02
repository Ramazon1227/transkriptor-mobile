// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'held_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HeldFileModel _$HeldFileModelFromJson(Map<String, dynamic> json) =>
    _HeldFileModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      sizeBytes: (json['size_bytes'] as num?)?.toInt() ?? 0,
      state: json['state'] as String? ?? '',
      expiresAt: json['expires_at'] as String?,
      deletable: json['deletable'] as bool? ?? false,
    );

Map<String, dynamic> _$HeldFileModelToJson(_HeldFileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'size_bytes': instance.sizeBytes,
      'state': instance.state,
      'expires_at': instance.expiresAt,
      'deletable': instance.deletable,
    };

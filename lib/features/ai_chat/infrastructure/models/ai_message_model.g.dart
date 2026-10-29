// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiMessageModel _$AiMessageModelFromJson(Map<String, dynamic> json) =>
    _AiMessageModel(
      id: json['id'] as String? ?? '',
      role:
          $enumDecodeNullable(
            _$AiRoleModelEnumMap,
            json['role'],
            unknownValue: AiRoleModel.unknown,
          ) ??
          AiRoleModel.unknown,
      status:
          $enumDecodeNullable(
            _$AiStatusModelEnumMap,
            json['status'],
            unknownValue: AiStatusModel.unknown,
          ) ??
          AiStatusModel.unknown,
      content: json['content'] as String? ?? '',
      error: json['error'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AiMessageModelToJson(_AiMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': _$AiRoleModelEnumMap[instance.role]!,
      'status': _$AiStatusModelEnumMap[instance.status]!,
      'content': instance.content,
      'error': instance.error,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$AiRoleModelEnumMap = {
  AiRoleModel.user: 'USER',
  AiRoleModel.assistant: 'ASSISTANT',
  AiRoleModel.unknown: 'unknown',
};

const _$AiStatusModelEnumMap = {
  AiStatusModel.pending: 'PENDING',
  AiStatusModel.done: 'DONE',
  AiStatusModel.failed: 'FAILED',
  AiStatusModel.unknown: 'unknown',
};

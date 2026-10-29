// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String? ?? '',
  email: json['email'] as String? ?? '',
  fullName: json['full_name'] as String? ?? '',
  hasPassword: json['has_password'] as bool? ?? true,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'full_name': instance.fullName,
      'has_password': instance.hasPassword,
    };

_WorkspacePlanModel _$WorkspacePlanModelFromJson(Map<String, dynamic> json) =>
    _WorkspacePlanModel(
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$WorkspacePlanModelToJson(_WorkspacePlanModel instance) =>
    <String, dynamic>{'code': instance.code, 'name': instance.name};

_WorkspaceModel _$WorkspaceModelFromJson(Map<String, dynamic> json) =>
    _WorkspaceModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      isPersonal: json['is_personal'] as bool? ?? false,
      balanceSeconds: (json['balance_seconds'] as num?)?.toInt() ?? 0,
      role:
          $enumDecodeNullable(
            _$WorkspaceRoleEnumMap,
            json['role'],
            unknownValue: WorkspaceRole.unknown,
          ) ??
          WorkspaceRole.unknown,
      plan: json['plan'] == null
          ? null
          : WorkspacePlanModel.fromJson(json['plan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkspaceModelToJson(_WorkspaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_personal': instance.isPersonal,
      'balance_seconds': instance.balanceSeconds,
      'role': _$WorkspaceRoleEnumMap[instance.role]!,
      'plan': instance.plan,
    };

const _$WorkspaceRoleEnumMap = {
  WorkspaceRole.owner: 'OWNER',
  WorkspaceRole.admin: 'ADMIN',
  WorkspaceRole.member: 'MEMBER',
  WorkspaceRole.viewer: 'VIEWER',
  WorkspaceRole.unknown: 'unknown',
};

_MeModel _$MeModelFromJson(Map<String, dynamic> json) => _MeModel(
  user: json['user'] == null
      ? const UserModel()
      : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  workspaces:
      (json['workspaces'] as List<dynamic>?)
          ?.map((e) => WorkspaceModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <WorkspaceModel>[],
);

Map<String, dynamic> _$MeModelToJson(_MeModel instance) => <String, dynamic>{
  'user': instance.user,
  'workspaces': instance.workspaces,
};

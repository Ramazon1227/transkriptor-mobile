// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String? ?? '',
  email: json['email'] as String? ?? '',
  fullName: json['full_name'] as String? ?? '',
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'full_name': instance.fullName,
    };

_WorkspaceModel _$WorkspaceModelFromJson(Map<String, dynamic> json) =>
    _WorkspaceModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      isPersonal: json['is_personal'] as bool? ?? false,
      balanceSeconds: (json['balance_seconds'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$WorkspaceModelToJson(_WorkspaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_personal': instance.isPersonal,
      'balance_seconds': instance.balanceSeconds,
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkspaceListModel _$WorkspaceListModelFromJson(Map<String, dynamic> json) =>
    _WorkspaceListModel(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => WorkspaceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <WorkspaceModel>[],
    );

Map<String, dynamic> _$WorkspaceListModelToJson(_WorkspaceListModel instance) =>
    <String, dynamic>{'items': instance.items};

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/auth/infrastructure/models/me_model.dart';

part 'workspace_list_model.freezed.dart';
part 'workspace_list_model.g.dart';

/// `data` of `GET /api/v1/workspaces`.
@freezed
abstract class WorkspaceListModel with _$WorkspaceListModel {
  const factory WorkspaceListModel({
    @JsonKey(name: 'items')
    @Default(<WorkspaceModel>[])
    List<WorkspaceModel> items,
  }) = _WorkspaceListModel;

  factory WorkspaceListModel.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceListModelFromJson(json);
}

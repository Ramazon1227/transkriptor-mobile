import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';

part 'me_model.freezed.dart';
part 'me_model.g.dart';

/// `models.User` in the backend.
@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'email') @Default('') String email,
    @JsonKey(name: 'full_name') @Default('') String fullName,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  AppUser toEntity() => AppUser(id: id, email: email, fullName: fullName);
}

/// `models.Workspace` in the backend.
@freezed
abstract class WorkspaceModel with _$WorkspaceModel {
  const factory WorkspaceModel({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'is_personal') @Default(false) bool isPersonal,
    @JsonKey(name: 'balance_seconds') @Default(0) int balanceSeconds,
  }) = _WorkspaceModel;

  const WorkspaceModel._();

  factory WorkspaceModel.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceModelFromJson(json);

  Workspace toEntity() => Workspace(
    id: id,
    name: name,
    isPersonal: isPersonal,
    balanceSeconds: balanceSeconds,
  );
}

/// `data` of `GET /api/v1/me`.
@freezed
abstract class MeModel with _$MeModel {
  const factory MeModel({
    @JsonKey(name: 'user') @Default(UserModel()) UserModel user,
    @JsonKey(name: 'workspaces')
    @Default(<WorkspaceModel>[])
    List<WorkspaceModel> workspaces,
  }) = _MeModel;

  const MeModel._();

  factory MeModel.fromJson(Map<String, dynamic> json) =>
      _$MeModelFromJson(json);

  Account toEntity() => Account(
    user: user.toEntity(),
    workspaces: workspaces.map((w) => w.toEntity()).toList(),
  );
}

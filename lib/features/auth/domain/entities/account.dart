import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    @Default('') String fullName,

    /// False when the account was opened with Google only. Deleting the
    /// account then asks for the email instead of a password.
    @Default(true) bool hasPassword,
  }) = _AppUser;
}

/// The caller's role in a workspace. The server never puts it in the
/// token; it comes with every workspace list.
enum WorkspaceRole {
  @JsonValue('OWNER')
  owner,
  @JsonValue('ADMIN')
  admin,
  @JsonValue('MEMBER')
  member,
  @JsonValue('VIEWER')
  viewer,
  unknown;

  /// May upload, edit and organise files. Mirrors the backend's
  /// `CanWriteWorkspace`: VIEWER cannot, and an unknown role is treated
  /// as the least privileged.
  bool get canWrite => this == owner || this == admin || this == member;

  /// May rename or delete shared things (tags, members). Mirrors
  /// `CanManageWorkspace`.
  bool get canManage => this == owner || this == admin;
}

@freezed
abstract class Workspace with _$Workspace {
  const factory Workspace({
    required String id,
    required String name,
    @Default(false) bool isPersonal,

    /// Minutes are the currency: what is left to transcribe, in seconds.
    @Default(0) int balanceSeconds,
    @Default(WorkspaceRole.unknown) WorkspaceRole role,

    /// The current plan's code (`free`, `pro`, `team`) and display name;
    /// empty when the server did not send one.
    @Default('') String planCode,
    @Default('') String planName,
  }) = _Workspace;
}

/// The signed-in person and the workspaces they belong to (`GET /me`).
@freezed
abstract class Account with _$Account {
  const factory Account({
    required AppUser user,
    @Default(<Workspace>[]) List<Workspace> workspaces,

    /// The workspace the person switched to; null or gone means the
    /// personal one.
    String? selectedWorkspaceId,
  }) = _Account;

  const Account._();

  /// Where new files go and which files are listed: the selected
  /// workspace if it is still one of theirs, else the personal one, else
  /// the first.
  Workspace? get currentWorkspace {
    final selected = selectedWorkspaceId;
    if (selected != null) {
      for (final w in workspaces) {
        if (w.id == selected) return w;
      }
    }
    for (final w in workspaces) {
      if (w.isPersonal) return w;
    }
    return workspaces.isEmpty ? null : workspaces.first;
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    @Default('') String fullName,
  }) = _AppUser;
}

@freezed
abstract class Workspace with _$Workspace {
  const factory Workspace({
    required String id,
    required String name,
    @Default(false) bool isPersonal,

    /// Minutes are the currency: what is left to transcribe, in seconds.
    @Default(0) int balanceSeconds,
  }) = _Workspace;
}

/// The signed-in person and the workspaces they belong to (`GET /me`).
@freezed
abstract class Account with _$Account {
  const factory Account({
    required AppUser user,
    @Default(<Workspace>[]) List<Workspace> workspaces,
  }) = _Account;

  const Account._();

  /// Where new files go: the personal workspace, else the first one.
  Workspace? get currentWorkspace {
    for (final w in workspaces) {
      if (w.isPersonal) return w;
    }
    return workspaces.isEmpty ? null : workspaces.first;
  }
}

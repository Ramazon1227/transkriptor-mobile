import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';

extension WorkspaceRoleLabel on WorkspaceRole {
  /// Null for a role the app does not know: nothing is better than a
  /// wrong word.
  String? label(AppLocalizations l10n) => switch (this) {
    WorkspaceRole.owner => l10n.roleOwner,
    WorkspaceRole.admin => l10n.roleAdmin,
    WorkspaceRole.member => l10n.roleMember,
    WorkspaceRole.viewer => l10n.roleViewer,
    WorkspaceRole.unknown => null,
  };
}

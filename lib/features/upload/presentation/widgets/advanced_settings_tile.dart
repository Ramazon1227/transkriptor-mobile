import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/widgets/action_row.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/upload/domain/entities/advanced_options.dart';

/// The «Qoʻshimcha sozlamalar» row of an upload page and, under it, a
/// one-line summary of what is chosen — a hidden choice must not be
/// forgotten (A-0).
class AdvancedSettingsTile extends StatelessWidget {
  const AdvancedSettingsTile({
    required this.value,
    required this.currentWorkspaceId,
    required this.onTap,
    super.key,
  });

  final AdvancedOptions value;

  /// The app's workspace: another destination is named in the summary.
  final String currentWorkspaceId;

  /// Null disables the row (an upload is running).
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ActionGroup(
      children: [
        ActionRow(
          key: const Key('advanced_open'),
          icon: Icons.tune_rounded,
          label: context.l10n.advancedOpen,
          subtitle: advancedSummary(context.l10n, value, currentWorkspaceId),
          onTap: onTap,
        ),
      ],
    );
  }
}

/// «Fayllar · Maʼruzachi: avtomatik», «‹Jamoa› › Hisobotlar · Maʼruzachi:
/// 2 kishi · Atamalar: Kengash +3 · Belgi: 4».
String advancedSummary(
  AppLocalizations l10n,
  AdvancedOptions value,
  String currentWorkspaceId,
) {
  final folder = value.folderId == null || value.folderName.isEmpty
      ? l10n.advancedSummaryFiles
      : value.folderName;
  final other =
      value.workspaceId != currentWorkspaceId && value.workspaceName.isNotEmpty;
  final speakers = value.numSpeakers;
  final terms = value.terms.length;
  final list = value.glossaryId == null ? '' : value.glossaryName;
  final hints = value.hintCount;
  return [
    if (other) '«${value.workspaceName}» › $folder' else folder,
    if (speakers == null)
      l10n.advancedSummarySpeakersAuto
    else
      l10n.advancedSummarySpeakers(speakers),
    if (list.isNotEmpty || terms > 0)
      l10n.advancedSummaryTerms(
        [if (list.isNotEmpty) list, if (terms > 0) '+$terms'].join(' '),
      ),
    if (hints > 0) l10n.advancedSummaryHints(hints),
  ].join(' · ');
}

/// The balance of the chosen destination [workspaceId]; the app's current
/// workspace when that one is not in the account (any more).
int? destinationBalance(Account? account, String workspaceId) {
  if (account == null) return null;
  for (final w in account.workspaces) {
    if (w.id == workspaceId) return w.balanceSeconds;
  }
  return account.currentWorkspace?.balanceSeconds;
}

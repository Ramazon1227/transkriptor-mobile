import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/home/presentation/widgets/capture_actions.dart';
import 'package:transkriptor_uz/features/home/presentation/widgets/source_sheet.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/source_tabs.dart';

/// A tab with nothing in it: the tab's source icon, one line, and the way
/// to make the first one. Scrollable, so it can be pulled to refresh. A
/// VIEWER cannot add files and gets no button; notes are not made on the
/// phone.
class FilesEmptyView extends StatelessWidget {
  const FilesEmptyView({required this.tab, required this.canWrite, super.key});

  final FilesTab tab;
  final bool canWrite;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final action = canWrite ? _action(l10n) : null;
    return ListView(
      padding: const EdgeInsets.fromLTRB(32, 72, 32, 32),
      children: [
        Center(child: SourceIcon(source: tab.icon, size: 56)),
        const SizedBox(height: 16),
        Text(
          _message(l10n),
          textAlign: TextAlign.center,
          style: AppText.body,
        ),
        if (action != null) ...[
          const SizedBox(height: 20),
          Center(
            child: FilledButton(
              key: const Key('files_empty_action'),
              onPressed: () => _start(context),
              child: Text(action),
            ),
          ),
        ],
      ],
    );
  }

  String _message(AppLocalizations l10n) => switch (tab) {
    FilesTab.all => l10n.filesEmptyTitle,
    FilesTab.uploads => l10n.filesEmptyUploads,
    FilesTab.meetings => l10n.filesEmptyMeetings,
    FilesTab.recordings => l10n.filesEmptyRecordings,
    FilesTab.links => l10n.filesEmptyLinks,
    FilesTab.notes => l10n.filesEmptyNotes,
  };

  String? _action(AppLocalizations l10n) => switch (tab) {
    FilesTab.all => l10n.navNew,
    FilesTab.uploads => l10n.sourceUploadTitle,
    FilesTab.meetings => l10n.sourceMeetingTitle,
    FilesTab.recordings => l10n.sourceRecordTitle,
    FilesTab.links => l10n.sourceYoutubeTitle,
    FilesTab.notes => null,
  };

  Future<void> _start(BuildContext context) async {
    if (tab != FilesTab.all) {
      startCapture(context, tab.icon);
      return;
    }
    final source = await showSourceSheet(context);
    if (source != null && context.mounted) startCapture(context, source);
  }
}

/// The search matched nothing on this tab.
class FilesNoMatchView extends StatelessWidget {
  const FilesNoMatchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(32, 72, 32, 32),
      children: [
        Text(
          context.l10n.filesSearchEmpty,
          textAlign: TextAlign.center,
          style: AppText.muted,
        ),
      ],
    );
  }
}

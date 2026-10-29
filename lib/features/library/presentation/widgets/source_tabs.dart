import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/library/domain/files_source.dart';

/// The files screen's tabs: five views of `/library` and the notes.
enum FilesTab {
  all,
  uploads,
  meetings,
  recordings,
  links,
  notes;

  /// The library filter behind the tab; null for notes.
  FilesSource? get source => switch (this) {
    all => FilesSource.all,
    uploads => FilesSource.uploads,
    meetings => FilesSource.meetings,
    recordings => FilesSource.recordings,
    links => FilesSource.links,
    notes => null,
  };

  /// The icon of the tab's empty state, and the source its call to action
  /// starts (null: notes are not made on the phone).
  CaptureSource get icon => switch (this) {
    all || uploads => CaptureSource.upload,
    meetings => CaptureSource.meeting,
    recordings => CaptureSource.recording,
    links => CaptureSource.youtube,
    notes => CaptureSource.note,
  };

  String label(AppLocalizations l10n) => switch (this) {
    all => l10n.filesAll,
    uploads => l10n.filesTabUploads,
    meetings => l10n.filesTabMeetings,
    recordings => l10n.filesTabRecordings,
    links => l10n.filesTabLinks,
    notes => l10n.filesTabNotes,
  };
}

/// A horizontally scrolling row of [FilesTab]s; the active one is
/// underlined in saffron.
class SourceTabs extends StatelessWidget {
  const SourceTabs({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final FilesTab selected;
  final ValueChanged<FilesTab> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // The row's height is fixed; large text must not push labels out.
    final scaler = MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 1.3);
    return Container(
      height: 44,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.sf2)),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          for (final tab in FilesTab.values)
            Semantics(
              selected: tab == selected,
              button: true,
              child: InkWell(
                key: Key('files_tab_${tab.name}'),
                onTap: () => onSelected(tab),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: tab == selected
                            ? AppColors.accent
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    tab.label(l10n),
                    textScaler: scaler,
                    style: AppText.body.copyWith(
                      fontSize: 14,
                      color: tab == selected
                          ? AppColors.cotton
                          : AppColors.mutedDark,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

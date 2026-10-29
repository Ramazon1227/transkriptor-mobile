import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';

/// The «+» sheet: every way in, in this order. Answers the chosen source,
/// or null when closed; the caller starts it once the sheet is gone.
Future<CaptureSource?> showSourceSheet(BuildContext context) =>
    showAppSheet<CaptureSource>(context, builder: (_) => const SourceSheet());

class SourceSheet extends StatelessWidget {
  const SourceSheet({super.key});

  static const List<CaptureSource> order = [
    CaptureSource.upload,
    CaptureSource.youtube,
    CaptureSource.recording,
    CaptureSource.dictation,
    CaptureSource.screen,
    CaptureSource.cloud,
    CaptureSource.meeting,
    CaptureSource.url,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppSheet(
      title: l10n.sourceSheetTitle,
      child: Column(
        children: [
          for (final source in order) ...[
            _SourceRow(
              source: source,
              title: _title(l10n, source),
              body: _body(l10n, source),
              badge: source == CaptureSource.dictation
                  ? l10n.sourceRealtimeBadge
                  : null,
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  static String _title(AppLocalizations l10n, CaptureSource s) => switch (s) {
    CaptureSource.upload => l10n.sourceUploadTitle,
    CaptureSource.youtube => l10n.sourceYoutubeTitle,
    CaptureSource.recording => l10n.sourceRecordTitle,
    CaptureSource.dictation => l10n.sourceDictationTitle,
    CaptureSource.screen => l10n.sourceScreenTitle,
    CaptureSource.cloud => l10n.sourceCloudTitle,
    CaptureSource.meeting => l10n.sourceMeetingTitle,
    CaptureSource.url || CaptureSource.note => l10n.sourceUrlTitle,
  };

  static String _body(AppLocalizations l10n, CaptureSource s) => switch (s) {
    CaptureSource.upload => l10n.sourceUploadBody,
    CaptureSource.youtube => l10n.sourceYoutubeBody,
    CaptureSource.recording => l10n.sourceRecordBody,
    CaptureSource.dictation => l10n.sourceDictationBody,
    CaptureSource.screen => l10n.sourceScreenBody,
    CaptureSource.cloud => l10n.sourceCloudBody,
    CaptureSource.meeting => l10n.sourceMeetingBody,
    CaptureSource.url || CaptureSource.note => l10n.sourceUrlBody,
  };
}

class _SourceRow extends StatelessWidget {
  const _SourceRow({
    required this.source,
    required this.title,
    required this.body,
    this.badge,
  });

  final CaptureSource source;
  final String title;
  final String body;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadii.card);
    final badge = this.badge;
    return Material(
      color: AppColors.sf2,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: () => Navigator.of(context).pop(source),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              SourceIcon(source: source, size: 44),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(title, style: AppText.bodyStrong),
                        if (badge != null) _MintBadge(badge),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(body, style: AppText.caption),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A machine marker: real-time output is the model's, so mint.
class _MintBadge extends StatelessWidget {
  const _MintBadge(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.mint.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: AppText.label.copyWith(color: AppColors.mint, letterSpacing: .4),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/job/presentation/widgets/job_status_chip.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';

class LibraryTile extends StatelessWidget {
  const LibraryTile({
    required this.item,
    this.showTags = true,
    this.onLongPress,
    super.key,
  });

  final LibraryItem item;
  final bool showTags;

  /// The files screen's move / tags menu; null elsewhere.
  final VoidCallback? onLongPress;

  /// Where tapping [item] leads: a finished transcript opens, anything
  /// with a job shows its progress, a file without a job goes nowhere.
  static String? targetOf(LibraryItem item) {
    final transcriptId = item.transcriptId;
    if (item.jobStatus == JobStatus.succeeded && transcriptId != null) {
      return Routes.transcriptOf(transcriptId);
    }
    final jobId = item.jobId;
    return jobId == null ? null : Routes.jobOf(jobId);
  }

  @override
  Widget build(BuildContext context) {
    final target = targetOf(item);
    return InkWell(
      onTap: target == null ? null : () => context.push(target),
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _KindIcon(kind: item.kind),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontVariations: [FontVariation('wght', 500)],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      JobStatusChip(status: item.jobStatus),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(_meta(context.l10n), style: AppText.mono),
                  if (showTags && item.tags.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [for (final t in item.tags) _Tag(t)],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _meta(AppLocalizations l10n) {
    final created = item.createdAt;
    final duration = item.duration;
    return [
      if (created != null) Formatters.date(created),
      if (duration != null) Formatters.timecode(duration),
      _source(l10n),
    ].join(' · ');
  }

  String _source(AppLocalizations l10n) => switch (item.source) {
    MediaSource.recording => l10n.sourceRecording,
    MediaSource.url => switch (item.linkProvider) {
      'YOUTUBE' => l10n.sourceYoutube,
      'GDRIVE' => l10n.sourceDrive,
      'DROPBOX' => l10n.sourceDropbox,
      _ => l10n.sourceLink,
    },
    MediaSource.api => l10n.sourceApi,
    MediaSource.upload || MediaSource.unknown => l10n.sourceUpload,
  };
}

class _KindIcon extends StatelessWidget {
  const _KindIcon({required this.kind});

  final MediaKind kind;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final video = kind == MediaKind.video;
    return Semantics(
      label: video ? l10n.kindVideo : l10n.kindAudio,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.sf1,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          video ? Icons.play_arrow_rounded : Icons.graphic_eq_rounded,
          size: 18,
          color: AppColors.mutedDark,
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
      decoration: BoxDecoration(
        color: AppColors.sf2,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, color: AppColors.mutedDark),
      ),
    );
  }
}

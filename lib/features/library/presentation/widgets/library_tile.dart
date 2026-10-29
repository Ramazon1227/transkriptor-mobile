import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/library_item_source.dart';

/// One file: where it came from, its name (two lines at most), date and
/// length, and a marker while it is in progress or when it failed. A
/// finished file carries no marker — finished is the normal state.
class LibraryTile extends StatelessWidget {
  const LibraryTile({
    required this.item,
    this.showTags = true,
    this.onMore,
    super.key,
  });

  final LibraryItem item;
  final bool showTags;

  /// The row's «…» menu; null hides the button (nothing the caller may do).
  final VoidCallback? onMore;

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
    final more = onMore;
    return InkWell(
      onTap: target == null ? null : () => context.push(target),
      onLongPress: more,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SourceIcon(source: item.captureSource),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 10,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (_meta().isNotEmpty)
                        Text(_meta(), style: AppText.mono),
                      ?_StatusMarker.of(item.jobStatus),
                    ],
                  ),
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
            if (more != null)
              IconButton(
                key: Key('file_more_${item.mediaId}'),
                tooltip: context.l10n.filesMore,
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  Icons.more_horiz_rounded,
                  color: AppColors.mutedDark,
                ),
                onPressed: more,
              ),
          ],
        ),
      ),
    );
  }

  String _meta() {
    final created = item.createdAt;
    final duration = item.duration;
    return [
      if (created != null) Formatters.date(created),
      if (duration != null) Formatters.timecode(duration),
    ].join(' · ');
  }
}

/// Coral spinner while queued or running, red «Bajarilmadi» on failure,
/// a muted word when cancelled.
class _StatusMarker extends StatelessWidget {
  const _StatusMarker(this.status);

  final JobStatus status;

  static Widget? of(JobStatus? status) => switch (status) {
    JobStatus.queued ||
    JobStatus.running ||
    JobStatus.failed ||
    JobStatus.cancelled => _StatusMarker(status!),
    JobStatus.succeeded || JobStatus.unknown || null => null,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (Widget glyph, Color color, String text) = switch (status) {
      JobStatus.queued || JobStatus.running => (
        const SizedBox.square(
          dimension: 10,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            color: AppColors.warn,
          ),
        ),
        AppColors.warn,
        status == JobStatus.queued ? l10n.statusQueued : l10n.statusRunning,
      ),
      JobStatus.failed => (
        const Icon(Icons.error_outline_rounded, size: 14, color: AppColors.bad),
        AppColors.bad,
        l10n.filesFailed,
      ),
      _ => (
        const Icon(Icons.block_rounded, size: 13, color: AppColors.mutedDark),
        AppColors.mutedDark,
        l10n.statusCancelled,
      ),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        glyph,
        const SizedBox(width: 5),
        Flexible(
          child: Text(text, style: AppText.caption.copyWith(color: color)),
        ),
      ],
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
        style: AppText.caption.copyWith(fontSize: 11),
      ),
    );
  }
}

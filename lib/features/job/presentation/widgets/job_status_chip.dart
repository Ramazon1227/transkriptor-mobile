import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';

/// Status in form and word: a dot plus a label. Mint = machine finished,
/// coral = in progress, red = failed, muted = waiting.
class JobStatusChip extends StatelessWidget {
  const JobStatusChip({required this.status, this.progress, super.key});

  /// Null for a file saved without a job.
  final JobStatus? status;

  /// Shown instead of the word while running, when known.
  final int? progress;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final error = Theme.of(context).colorScheme.error;
    final (Color color, String text) = switch (status) {
      JobStatus.succeeded => (AppColors.mint, l10n.statusDone),
      JobStatus.running => (
        AppColors.warn,
        progress != null && progress! > 0 ? '$progress%' : l10n.statusRunning,
      ),
      JobStatus.queued => (AppColors.mutedDark, l10n.statusQueued),
      JobStatus.failed => (error, l10n.statusFailed),
      JobStatus.cancelled => (AppColors.mutedDark, l10n.statusCancelled),
      JobStatus.unknown || null => (AppColors.mutedDark, l10n.statusSaved),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

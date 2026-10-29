import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/job/presentation/widgets/job_status_chip.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/library_tile.dart';

/// How many files the home screen previews.
const int _recentCount = 8;

/// The latest files, side by side in a horizontal strip.
class RecentFiles extends StatelessWidget {
  const RecentFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      buildWhen: (prev, next) =>
          prev.status != next.status || prev.items != next.items,
      builder: (context, state) {
        final l10n = context.l10n;
        return switch (state.status) {
          LibraryStatus.initial || LibraryStatus.loading => const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          ),
          // The home screen still works without the list; keep it short.
          LibraryStatus.failure => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(state.failure!.message(l10n), style: AppText.caption),
          ),
          LibraryStatus.empty => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(l10n.filesEmptyTitle, style: AppText.caption),
          ),
          LibraryStatus.success => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // Cards share the height of the tallest, whatever the text size.
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final (i, item)
                      in state.items.take(_recentCount).indexed) ...[
                    if (i > 0) const SizedBox(width: 10),
                    _RecentCard(item: item),
                  ],
                ],
              ),
            ),
          ),
        };
      },
    );
  }
}

class _RecentCard extends StatelessWidget {
  const _RecentCard({required this.item});

  final LibraryItem item;

  static CaptureSource sourceOf(LibraryItem item) => switch (item.source) {
    MediaSource.recording => CaptureSource.recording,
    MediaSource.url => switch (item.linkProvider) {
      'YOUTUBE' => CaptureSource.youtube,
      'GDRIVE' || 'DROPBOX' => CaptureSource.cloud,
      _ => CaptureSource.url,
    },
    MediaSource.upload ||
    MediaSource.api ||
    MediaSource.unknown => CaptureSource.upload,
  };

  @override
  Widget build(BuildContext context) {
    final target = LibraryTile.targetOf(item);
    final created = item.createdAt;
    final radius = BorderRadius.circular(AppRadii.card);
    return SizedBox(
      width: 220,
      child: Material(
        color: AppColors.sf1,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: target == null ? null : () => context.push(target),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SourceIcon(source: sourceOf(item), size: 32),
                const SizedBox(height: 10),
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.bodyMedium,
                ),
                const Spacer(),
                const SizedBox(height: 8),
                // Wraps under large text instead of overflowing the card.
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    JobStatusChip(status: item.jobStatus),
                    if (created != null)
                      Text(Formatters.date(created), style: AppText.mono),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

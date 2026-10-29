import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/features/rating/application/rating_cubit.dart';

/// Five stars; a tap saves at once. Only the caller's own mark is shown.
class RatingSheet extends StatelessWidget {
  const RatingSheet({required this.transcriptId, super.key});

  final String transcriptId;

  static Future<void> show(BuildContext context, String transcriptId) =>
      showAppSheet<void>(
        context,
        builder: (_) => RatingSheet(transcriptId: transcriptId),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<RatingCubit>();
        unawaited(cubit.load(transcriptId));
        return cubit;
      },
      child: const _RatingView(),
    );
  }
}

class _RatingView extends StatelessWidget {
  const _RatingView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppSheet(
      title: l10n.ratingTitle,
      child: BlocBuilder<RatingCubit, RatingState>(
        builder: (context, state) {
          final cubit = context.read<RatingCubit>();
          final loading =
              state.status == RatingStatus.loading ||
              state.status == RatingStatus.initial;
          final saving = state.saveStatus == RatingSaveStatus.saving;
          final score = state.rating?.score ?? 0;
          final failure = state.failure ?? state.saveFailure;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (var n = 1; n <= 5; n++)
                    IconButton(
                      key: Key('rating_star_$n'),
                      tooltip: l10n.ratingStar(n),
                      iconSize: 36,
                      onPressed: loading || saving ? null : () => cubit.rate(n),
                      icon: Icon(
                        n <= score
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: n <= score
                            ? AppColors.accent
                            : AppColors.mutedDark,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (loading || saving) const LinearProgressIndicator(),
              Text(
                l10n.ratingHint,
                textAlign: TextAlign.center,
                style: AppText.caption,
              ),
              if (state.saveStatus == RatingSaveStatus.saved) ...[
                const SizedBox(height: 8),
                Text(
                  l10n.ratingSaved,
                  textAlign: TextAlign.center,
                  style: AppText.caption.copyWith(color: AppColors.cotton),
                ),
              ],
              if (failure != null) ...[
                const SizedBox(height: 8),
                Text(
                  failure.message(l10n),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.bad),
                ),
                if (state.status == RatingStatus.failure)
                  TextButton(onPressed: cubit.reload, child: Text(l10n.retry)),
              ],
            ],
          );
        },
      ),
    );
  }
}

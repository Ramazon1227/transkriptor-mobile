import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/features/summary/domain/entities/summary.dart';

/// The known section kinds named in the app's language; a `custom`
/// section keeps the title it came with.
List<SummarySection> resolveSectionTitles(
  AppLocalizations l10n,
  List<SummarySection> sections,
) => [
  for (final s in sections)
    s.copyWith(
      title:
          s.title ??
          switch (s.kind) {
            SummarySectionKind.overview => l10n.summarySectionOverview,
            SummarySectionKind.keyPoints => l10n.summarySectionKeyPoints,
            SummarySectionKind.speakers => l10n.summarySectionSpeakers,
            SummarySectionKind.nextSteps => l10n.summarySectionNextSteps,
            SummarySectionKind.custom => null,
          },
    ),
];

/// A generated summary as readable sections: heading, paragraph, bullets.
class SummarySections extends StatelessWidget {
  const SummarySections({required this.sections, super.key});

  /// Titles already resolved.
  final List<SummarySection> sections;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final s in sections) ...[
          if (s.title != null)
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 6),
              child: Text(s.title!, style: AppText.bodyStrong),
            ),
          if (s.paragraph != null) Text(s.paragraph!, style: AppText.body),
          for (final b in s.bullets)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 9, right: 10, left: 2),
                    child: SizedBox.square(
                      dimension: 5,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.mutedDark,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Text(b, style: AppText.body)),
                ],
              ),
            ),
        ],
      ],
    );
  }
}

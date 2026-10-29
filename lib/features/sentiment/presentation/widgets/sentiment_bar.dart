import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/features/sentiment/domain/entities/sentiment.dart';

/// Sentiment is a machine judgement, so it uses the machine colours:
/// mint = positive, coral = negative, a muted surface = neutral. Red is
/// for errors only. Applied to markers and bars, never to text.
Color? sentimentColor(SentimentLabel label) => switch (label) {
  SentimentLabel.positive => AppColors.mint,
  SentimentLabel.negative => AppColors.warn,
  SentimentLabel.neutral || SentimentLabel.unknown => null,
};

const Color _neutral = AppColors.sf3;

/// Ijobiy / Neytral / Salbiy as one stacked bar, by share of talk time.
class SentimentBar extends StatelessWidget {
  const SentimentBar({required this.share, this.height = 8, super.key});

  final SentimentShare share;
  final double height;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final parts = [
      (share.positive, AppColors.mint),
      (share.neutral, _neutral),
      (share.negative, AppColors.warn),
    ];
    return Semantics(
      label:
          '${l10n.sentimentPositive} ${percent(share.positive)}, '
          '${l10n.sentimentNeutral} ${percent(share.neutral)}, '
          '${l10n.sentimentNegative} ${percent(share.negative)}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height / 2),
        child: SizedBox(
          height: height,
          child: share.isEmpty
              ? const ColoredBox(color: AppColors.sf2)
              : Row(
                  children: [
                    for (final (value, color) in parts)
                      if (_flex(value) > 0)
                        Expanded(
                          flex: _flex(value),
                          child: ColoredBox(color: color),
                        ),
                  ],
                ),
        ),
      ),
    );
  }

  static int _flex(double v) => (v.clamp(0, 1) * 1000).round();
}

/// `37%` — the shares are fractions 0..1.
String percent(double v) => '${(v.clamp(0, 1) * 100).round()}%';

/// Colour key and percentages under a bar. The text stays in the
/// reading colour; only the swatch carries the hue.
class SentimentLegend extends StatelessWidget {
  const SentimentLegend({required this.share, this.compact = false, super.key});

  final SentimentShare share;

  /// Speaker rows: smaller type.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final style = compact ? AppText.caption : AppText.body;
    final items = [
      (l10n.sentimentPositive, share.positive, AppColors.mint),
      (l10n.sentimentNeutral, share.neutral, _neutral),
      (l10n.sentimentNegative, share.negative, AppColors.warn),
    ];
    return Wrap(
      spacing: 14,
      runSpacing: 4,
      children: [
        for (final (name, value, color) in items)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 6),
              Text('$name ${percent(value)}', style: style),
            ],
          ),
      ],
    );
  }
}

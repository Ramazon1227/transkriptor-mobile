import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/rich_text.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/timecode.dart';

/// An assistant answer: headings, lists and bold (`domain/rich_text.dart`),
/// and `[12:34]` references become chips that move the player there.
/// Without [onSeek] they stay plain timecodes.
class AnswerText extends StatelessWidget {
  const AnswerText({required this.text, this.onSeek, super.key});

  final String text;
  final ValueChanged<Duration>? onSeek;

  @override
  Widget build(BuildContext context) {
    final blocks = parseRich(text);
    if (blocks.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < blocks.length; i++) ...[
          if (i > 0) const SizedBox(height: 8),
          _block(blocks[i]),
        ],
      ],
    );
  }

  Widget _block(RichBlock b) => switch (b) {
    RichHeading(:final runs) => Semantics(
      header: true,
      child: _runs(runs, AppText.body.weighted(FontWeight.w600)),
    ),
    RichParagraph(:final runs) => _runs(runs, AppText.body),
    RichList() => _list(b),
  };

  Widget _list(RichList l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < l.items.length; i++)
          Padding(
            padding: EdgeInsets.only(top: i == 0 ? 0 : 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: l.ordered ? 24 : 16,
                  child: Text(
                    l.ordered ? '${l.start + i}.' : '•',
                    style: AppText.body.copyWith(color: AppColors.mutedDark),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _runs(l.items[i].runs, AppText.body),
                      if (l.items[i].sub case final sub?)
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: _list(sub),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _runs(List<RichRun> runs, TextStyle style) {
    final bold = style
        .weighted(FontWeight.w600)
        .copyWith(color: AppColors.cotton);
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          for (final run in runs)
            for (final part in splitTimecodes(run.text))
              switch (part) {
                AnswerPlain(:final text) => TextSpan(
                  text: text,
                  style: run.bold ? bold : null,
                ),
                AnswerTimecode(:final label, :final at) => WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: _TimecodeChip(label: label, at: at, onSeek: onSeek),
                ),
              },
        ],
      ),
    );
  }
}

class _TimecodeChip extends StatelessWidget {
  const _TimecodeChip({required this.label, required this.at, this.onSeek});

  final String label;
  final Duration at;
  final ValueChanged<Duration>? onSeek;

  @override
  Widget build(BuildContext context) {
    final onSeek = this.onSeek;
    final radius = BorderRadius.circular(AppRadii.button);
    return Semantics(
      button: onSeek != null,
      label: context.l10n.aiChatSeekTo(label),
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Material(
          color: AppColors.accentSoft,
          borderRadius: radius,
          child: InkWell(
            key: Key('ai_timecode_$label'),
            borderRadius: radius,
            onTap: onSeek == null ? null : () => onSeek(at),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              child: Text(
                label,
                style: AppText.mono.copyWith(
                  fontSize: 13,
                  color: AppColors.accent,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/ai_chat/domain/timecode.dart';

/// An assistant answer: `[12:34]` references become chips that move the
/// player there. Without [onSeek] they stay plain timecodes.
class AnswerText extends StatelessWidget {
  const AnswerText({required this.text, this.onSeek, super.key});

  final String text;
  final ValueChanged<Duration>? onSeek;

  @override
  Widget build(BuildContext context) {
    final parts = splitTimecodes(text);
    return Text.rich(
      TextSpan(
        style: AppText.body,
        children: [
          for (final part in parts)
            switch (part) {
              AnswerPlain(:final text) => TextSpan(text: text),
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

import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// "All" plus one tab per speaker; the active one is underlined.
class SpeakerFilterBar extends StatelessWidget {
  const SpeakerFilterBar({
    required this.speakers,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final List<Speaker> speakers;

  /// Null is "All".
  final String? selected;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.sf2)),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _Tab(
            label: l10n.transcriptAll,
            selected: selected == null,
            onTap: () => onChanged(null),
          ),
          for (final s in speakers)
            _Tab(
              label: s.label.isEmpty ? l10n.transcriptNoSpeaker : s.label,
              dot: AppColors.speaker(s.ordinal),
              selected: selected == s.id,
              onTap: () => onChanged(s.id),
            ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.selected,
    required this.onTap,
    this.dot,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? dot;

  @override
  Widget build(BuildContext context) {
    final color = dot;
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? AppColors.accent : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Row(
            children: [
              if (color != null) ...[
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: selected ? AppColors.cotton : AppColors.mutedDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

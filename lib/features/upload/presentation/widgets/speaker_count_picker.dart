import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';

/// Auto, 1–5. The only option the upload takes (decided 2026-10-26);
/// language, diarization and punctuation come from the server.
class SpeakerCountPicker extends StatelessWidget {
  const SpeakerCountPicker({
    required this.value,
    required this.onChanged,
    this.enabled = true,
    super.key,
  });

  /// Null is "Auto".
  final int? value;
  final ValueChanged<int?> onChanged;
  final bool enabled;

  static const List<int?> _options = [null, 1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.speakersLabel.toUpperCase(), style: AppText.label),
        const SizedBox(height: 6),
        DecoratedBox(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.sf3)),
          ),
          child: Row(
            children: [
              for (final option in _options)
                Expanded(
                  child: _Option(
                    label: option == null ? l10n.speakersAuto : '$option',
                    selected: option == value,
                    onTap: enabled ? () => onChanged(option) : null,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(l10n.speakersHint, style: AppText.muted.copyWith(fontSize: 12)),
      ],
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          alignment: Alignment.center,
          // Active state is an underline, never a filled pill.
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? AppColors.accent : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: selected ? AppColors.cotton : AppColors.mutedDark,
              fontFeatures: AppText.mono.fontFeatures,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';

/// Auto, 1–10 (the backend's `MaxSpeakers`), in two rows so a phone's
/// width fits them. Upload pages show it inside «Qoʻshimcha sozlamalar»
/// (A-4); language, diarization and punctuation come from the server.
class SpeakerCountPicker extends StatelessWidget {
  const SpeakerCountPicker({
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.showLabel = true,
    super.key,
  });

  /// Null is "Auto".
  final int? value;
  final ValueChanged<int?> onChanged;
  final bool enabled;

  /// The panel's fold already carries the title.
  final bool showLabel;

  static const List<int?> _options = [null, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  static const int _perRow = 6;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(l10n.speakersLabel.toUpperCase(), style: AppText.label),
          const SizedBox(height: 6),
        ],
        for (var row = 0; row * _perRow < _options.length; row++)
          DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.sf3)),
            ),
            child: Row(
              children: [
                for (var i = row * _perRow; i < (row + 1) * _perRow; i++)
                  Expanded(
                    child: i < _options.length
                        ? _Option(
                            label: _options[i] == null
                                ? l10n.speakersAuto
                                : '${_options[i]}',
                            selected: _options[i] == value,
                            onTap: enabled
                                ? () => onChanged(_options[i])
                                : null,
                          )
                        : const SizedBox.shrink(),
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

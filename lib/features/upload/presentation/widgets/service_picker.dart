import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job_service.dart';

/// Transcription or subtitle (ClickUp S-1), next to the speaker count on
/// every «+» source. Looks like `SpeakerCountPicker`: an underlined choice.
class ServicePicker extends StatelessWidget {
  const ServicePicker({
    required this.value,
    required this.onChanged,
    this.enabled = true,
    super.key,
  });

  final JobService value;
  final ValueChanged<JobService> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.serviceLabel.toUpperCase(), style: AppText.label),
        const SizedBox(height: 6),
        DecoratedBox(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.sf3)),
          ),
          child: Row(
            children: [
              for (final option in JobService.values)
                Expanded(
                  child: _Option(
                    label: switch (option) {
                      JobService.transcription => l10n.serviceTranscription,
                      JobService.subtitle => l10n.serviceSubtitle,
                    },
                    selected: option == value,
                    onTap: enabled ? () => onChanged(option) : null,
                  ),
                ),
            ],
          ),
        ),
        if (value == JobService.subtitle) ...[
          const SizedBox(height: 6),
          Text(
            l10n.serviceSubtitleHint,
            style: AppText.muted.copyWith(fontSize: 12),
          ),
        ],
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
            ),
          ),
        ),
      ),
    );
  }
}

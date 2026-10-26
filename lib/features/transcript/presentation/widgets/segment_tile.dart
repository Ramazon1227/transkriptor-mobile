import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// One segment: speaker, timecode, text. The speaker dot is the machine's
/// marker; the text is shown in the reading colour, never mint.
class SegmentTile extends StatelessWidget {
  const SegmentTile({required this.segment, this.speaker, super.key});

  final Segment segment;

  /// Null without diarization.
  final Speaker? speaker;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final who = speaker;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (who != null) ...[
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: AppColors.speaker(who.ordinal),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    who.label.isEmpty ? l10n.transcriptNoSpeaker : who.label,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Text(Formatters.timecode(segment.start), style: AppText.mono),
              if (segment.edited) ...[
                const SizedBox(width: 8),
                Text(
                  l10n.transcriptEdited,
                  style: AppText.muted.copyWith(fontSize: 11),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          SelectableText(
            segment.text,
            style: const TextStyle(fontSize: 15, height: 1.55),
          ),
        ],
      ),
    );
  }
}

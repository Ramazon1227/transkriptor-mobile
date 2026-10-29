import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/features/sentiment/domain/entities/sentiment.dart';
import 'package:transkriptor_uz/features/sentiment/presentation/widgets/sentiment_bar.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// One segment: speaker chip, timecode, text. The chip's colour is the
/// machine's marker; the text is in the reading colour, never mint. The
/// segment under the playhead gets a saffron left edge.
///
/// The chip opens the speaker menu, the timecode seeks the player there.
/// A double tap edits the text (only given in edit mode), a long press
/// opens the segment's menu.
class SegmentTile extends StatelessWidget {
  const SegmentTile({
    required this.segment,
    required this.onSpeakerTap,
    required this.onLongPress,
    this.speaker,
    this.showSpeaker = true,
    this.active = false,
    this.onDoubleTap,
    this.onTimeTap,
    this.sentiment,
    super.key,
  });

  /// The segment's label from a finished analysis. Positive and negative
  /// get a small dot by the timecode; neutral and none get nothing. The
  /// text is never coloured.
  final SentimentLabel? sentiment;

  final Segment segment;

  /// Null without diarization.
  final Speaker? speaker;
  final bool showSpeaker;

  /// Under the playhead.
  final bool active;
  final VoidCallback onSpeakerTap;
  final VoidCallback onLongPress;

  /// Edit mode only.
  final VoidCallback? onDoubleTap;

  /// Null when there is nothing to play.
  final VoidCallback? onTimeTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final who = speaker;
    final time = Text(
      Formatters.timecode(segment.start),
      style: AppText.mono.copyWith(
        color: onTimeTap == null ? AppColors.mutedDark : AppColors.accent,
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Material(
        color: active ? AppColors.sf1 : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadii.segment),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: active ? AppColors.accent : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(9, 8, 12, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: showSpeaker && who != null
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: _SpeakerChip(
                                speaker: who,
                                onTap: onSpeakerTap,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    if (segment.edited) ...[
                      const SizedBox(width: 8),
                      Text(
                        l10n.transcriptEdited,
                        style: AppText.muted.copyWith(fontSize: 11),
                      ),
                    ],
                    if (_sentimentMark(l10n) case final mark?) ...[
                      const SizedBox(width: 8),
                      mark,
                    ],
                    const SizedBox(width: 8),
                    if (onTimeTap == null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: time,
                      )
                    else
                      InkWell(
                        key: Key('seek_${segment.id}'),
                        onTap: onTimeTap,
                        borderRadius: BorderRadius.circular(AppRadii.button),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 6,
                          ),
                          child: time,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  segment.text,
                  style: AppText.body.copyWith(fontSize: 15, height: 1.55),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on SegmentTile {
  Widget? _sentimentMark(AppLocalizations l10n) {
    final label = sentiment;
    if (label == null) return null;
    final color = sentimentColor(label);
    if (color == null) return null;
    return Semantics(
      label: label == SentimentLabel.positive
          ? l10n.sentimentPositive
          : l10n.sentimentNegative,
      child: Container(
        key: Key('sentiment_mark_${segment.id}'),
        width: 7,
        height: 7,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

class _SpeakerChip extends StatelessWidget {
  const _SpeakerChip({required this.speaker, required this.onTap});

  final Speaker speaker;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = AppColors.speaker(speaker.ordinal);
    return InkWell(
      key: Key('speaker_chip_${speaker.id}'),
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.button),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                speaker.label.isEmpty
                    ? l10n.transcriptNoSpeaker
                    : speaker.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.caption
                    .copyWith(color: AppColors.cotton)
                    .weighted(FontWeight.w500),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppColors.mutedDark,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';

/// What to ask before merging [segmentId] with the next one; null when
/// both are the same speaker's and there is nothing to ask. A merge keeps
/// the first one's speaker, so the answer names who stays.
String? mergeQuestion(
  BuildContext context,
  TranscriptState state,
  String segmentId,
) {
  if (!state.nextIsOtherSpeaker(segmentId)) return null;
  final label = state.speakerLabelOf(segmentId);
  return label == null || label.isEmpty
      ? context.l10n.transcriptMergeAskNoName
      : context.l10n.transcriptMergeAsk(label);
}

/// The merge question, inside the sheet like the delete one.
class MergeConfirm extends StatelessWidget {
  const MergeConfirm({
    required this.question,
    required this.saving,
    required this.onCancel,
    required this.onConfirm,
    super.key,
  });

  final String question;
  final bool saving;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(question, style: AppText.body),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.end,
          spacing: 8,
          children: [
            TextButton(
              key: const Key('merge_no'),
              onPressed: saving ? null : onCancel,
              child: Text(l10n.cancel),
            ),
            FilledButton(
              key: const Key('merge_yes'),
              onPressed: saving ? null : onConfirm,
              child: Text(l10n.transcriptMergeYes),
            ),
          ],
        ),
      ],
    );
  }
}

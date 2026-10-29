import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/edit_failure_text.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/edit_sheet_route.dart';

/// What the sheet hands back for the page to open next: another sheet
/// cannot open on top of this one while it is still closing.
sealed class SegmentAction {
  const SegmentAction();
}

final class RenameSpeakerAction extends SegmentAction {
  const RenameSpeakerAction(this.speaker);
  final Speaker speaker;
}

final class EditTextAction extends SegmentAction {
  const EditTextAction();
}

final class AddCommentAction extends SegmentAction {
  const AddCommentAction();
}

/// A segment's menu. From the speaker chip: move it to another speaker or
/// to a new one, rename a speaker. From a long press, also: edit the text
/// (split lives there), merge with the next, comment, delete. Like the
/// text editor it closes only once the cubit says a change went through;
/// a failure stays on the sheet.
class SegmentActionsSheet extends StatefulWidget {
  const SegmentActionsSheet({
    required this.segmentId,
    this.speakersOnly = false,
    super.key,
  });

  final String segmentId;

  /// The speaker chip's menu: no text or structure actions.
  final bool speakersOnly;

  static Future<SegmentAction?> show(
    BuildContext context,
    String segmentId, {
    bool speakersOnly = false,
  }) => showEditSheet<SegmentAction>(
    context,
    SegmentActionsSheet(segmentId: segmentId, speakersOnly: speakersOnly),
  );

  @override
  State<SegmentActionsSheet> createState() => _SegmentActionsSheetState();
}

class _SegmentActionsSheetState extends State<SegmentActionsSheet> {
  /// Deleting asks once more, inside the sheet.
  bool _confirmDelete = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final segmentId = widget.segmentId;
    return BlocConsumer<TranscriptCubit, TranscriptState>(
      listenWhen: (prev, next) =>
          prev.editStatus != next.editStatus &&
          next.editStatus == EditStatus.saved,
      listener: (context, _) => Navigator.of(context).pop(),
      builder: (context, state) {
        final cubit = context.read<TranscriptCubit>();
        final saving = state.editStatus == EditStatus.saving;
        final failure = state.editFailure;
        final transcript = state.transcript;
        final segment = transcript?.segments
            .where((s) => s.id == segmentId)
            .firstOrNull;
        final speakers = transcript?.speakers ?? const [];
        void pop(SegmentAction action) => Navigator.of(context).pop(action);
        return PopScope(
          canPop: !saving,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    l10n.transcriptAssignSpeaker,
                    style: AppText.label,
                  ),
                ),
                const SizedBox(height: 4),
                for (final speaker in speakers)
                  ListTile(
                    key: Key('assign_${speaker.id}'),
                    enabled: !saving,
                    contentPadding: const EdgeInsets.only(left: 16, right: 4),
                    leading: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.speaker(speaker.ordinal),
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      speaker.label.isEmpty
                          ? l10n.transcriptNoSpeaker
                          : speaker.label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (segment?.speakerId == speaker.id)
                          const Icon(Icons.check, size: 18),
                        IconButton(
                          key: Key('rename_${speaker.id}'),
                          tooltip: l10n.speakerRename,
                          onPressed: saving
                              ? null
                              : () => pop(RenameSpeakerAction(speaker)),
                          icon: const Icon(Icons.edit_outlined, size: 18),
                        ),
                      ],
                    ),
                    onTap: () => cubit.assignSpeaker(segmentId, speaker.id),
                  ),
                if (speakers.isNotEmpty) const Divider(height: 8),
                ListTile(
                  key: const Key('assign_new'),
                  enabled: !saving,
                  leading: const Icon(Icons.person_add_alt_1_outlined),
                  title: Text(l10n.transcriptNewSpeaker),
                  onTap: () => cubit.assignNewSpeaker(segmentId),
                ),
                if (!widget.speakersOnly) ...[
                  const Divider(height: 8),
                  ListTile(
                    key: const Key('segment_edit'),
                    enabled: !saving,
                    leading: const Icon(Icons.edit_note_rounded),
                    title: Text(l10n.segmentEditText),
                    onTap: () => pop(const EditTextAction()),
                  ),
                  if (state.hasNext(segmentId))
                    ListTile(
                      key: const Key('merge_next'),
                      enabled: !saving,
                      leading: const Icon(Icons.call_merge),
                      title: Text(l10n.transcriptMergeNext),
                      onTap: () => cubit.mergeNext(segmentId),
                    ),
                  ListTile(
                    key: const Key('segment_comment'),
                    enabled: !saving,
                    leading: const Icon(Icons.chat_bubble_outline_rounded),
                    title: Text(l10n.segmentAddComment),
                    onTap: () => pop(const AddCommentAction()),
                  ),
                  if (!_confirmDelete)
                    ListTile(
                      key: const Key('segment_delete'),
                      enabled: !saving,
                      leading: const Icon(
                        Icons.delete_outline_rounded,
                        color: AppColors.bad,
                      ),
                      title: Text(
                        l10n.segmentDelete,
                        style: const TextStyle(color: AppColors.bad),
                      ),
                      onTap: () => setState(() => _confirmDelete = true),
                    )
                  else
                    _DeleteConfirm(
                      saving: saving,
                      onCancel: () => setState(() => _confirmDelete = false),
                      onConfirm: () => cubit.deleteSegment(segmentId),
                    ),
                ],
                if (saving)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: LinearProgressIndicator(),
                  ),
                if (failure != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                    child: EditFailureText(failure: failure),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DeleteConfirm extends StatelessWidget {
  const _DeleteConfirm({
    required this.saving,
    required this.onCancel,
    required this.onConfirm,
  });

  final bool saving;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.segmentDeleteConfirm, style: AppText.body),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 8,
            children: [
              TextButton(
                onPressed: saving ? null : onCancel,
                child: Text(l10n.cancel),
              ),
              FilledButton(
                key: const Key('segment_delete_yes'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.bad,
                  foregroundColor: AppColors.sf0,
                ),
                onPressed: saving ? null : onConfirm,
                child: Text(l10n.segmentDeleteYes),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

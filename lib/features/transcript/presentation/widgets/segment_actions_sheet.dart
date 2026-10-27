import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/edit_failure_text.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/edit_sheet_route.dart';

/// A segment's long-press menu: move it to another speaker or to a new
/// one, the web's speaker pick. Like the text editor it closes only once
/// the cubit says the change went through; a failure stays on the sheet.
class SegmentActionsSheet extends StatelessWidget {
  const SegmentActionsSheet({required this.segmentId, super.key});

  final String segmentId;

  static Future<void> show(BuildContext context, String segmentId) =>
      showEditSheet(context, SegmentActionsSheet(segmentId: segmentId));

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
                    ),
                    trailing: segment?.speakerId == speaker.id
                        ? const Icon(Icons.check, size: 18)
                        : null,
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

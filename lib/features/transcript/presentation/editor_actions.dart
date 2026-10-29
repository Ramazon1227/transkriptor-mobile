import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/comments/presentation/widgets/comments_sheet.dart';
import 'package:transkriptor_uz/features/export/presentation/widgets/export_sheet.dart';
import 'package:transkriptor_uz/features/player/application/player_cubit.dart';
import 'package:transkriptor_uz/features/player/presentation/widgets/speed_sheet.dart';
import 'package:transkriptor_uz/features/rating/presentation/widgets/rating_sheet.dart';
import 'package:transkriptor_uz/features/share/presentation/widgets/share_sheet.dart';
import 'package:transkriptor_uz/features/transcript/application/transcript_cubit.dart';
import 'package:transkriptor_uz/features/transcript/domain/edit_rules.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/edit_text_sheet.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/editor_actions_sheet.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/retranscribe_sheet.dart';
import 'package:transkriptor_uz/features/transcript/presentation/widgets/segment_actions_sheet.dart';

/// The editor's flows that open one sheet after another. [BuildContext]
/// is always the page's, which sees [TranscriptCubit] and [PlayerCubit].
abstract final class EditorActions {
  static Future<void> editText(BuildContext context, Segment segment) {
    final l10n = context.l10n;
    final state = context.read<TranscriptCubit>().state;
    return EditTextSheet.show(
      context,
      EditTextSheet(
        title: l10n.transcriptEditSegment,
        initial: segment.text,
        multiline: true,
        tooLong: EditRules.segmentTextTooLong,
        tooLongMessage: l10n.transcriptTextTooLong,
        onSave: (cubit, text) => cubit.saveSegmentText(segment.id, text),
        onSplit: (cubit, text, cursor) =>
            cubit.splitSegment(segment.id, draft: text, cursor: cursor),
        onMergeNext: state.hasNext(segment.id)
            ? (cubit, text) => cubit.mergeNext(segment.id, draft: text)
            : null,
      ),
    );
  }

  static Future<void> renameSpeaker(BuildContext context, Speaker speaker) {
    final l10n = context.l10n;
    return EditTextSheet.show(
      context,
      EditTextSheet(
        title: l10n.transcriptRenameSpeaker,
        initial: speaker.label,
        multiline: false,
        tooLong: EditRules.speakerLabelTooLong,
        tooLongMessage: l10n.transcriptLabelTooLong,
        onSave: (cubit, label) => cubit.renameSpeaker(speaker.id, label),
      ),
    );
  }

  static Future<void> renameTitle(BuildContext context) {
    final l10n = context.l10n;
    final transcript = context.read<TranscriptCubit>().state.transcript;
    if (transcript == null) return Future.value();
    return EditTextSheet.show(
      context,
      EditTextSheet(
        title: l10n.editorRenameTitle,
        initial: transcript.title,
        multiline: false,
        tooLong: EditRules.titleTooLong,
        tooLongMessage: l10n.transcriptLabelTooLong,
        onSave: (cubit, title) => cubit.renameTitle(title),
      ),
    );
  }

  /// The speaker chip: reassign, rename, a new speaker.
  static Future<void> speakerMenu(BuildContext context, String segmentId) =>
      _segmentActions(context, segmentId, speakersOnly: true);

  /// A long press: everything the segment can do.
  static Future<void> segmentMenu(BuildContext context, Segment segment) =>
      _segmentActions(context, segment.id, speakersOnly: false);

  static Future<void> _segmentActions(
    BuildContext context,
    String segmentId, {
    required bool speakersOnly,
  }) async {
    final action = await SegmentActionsSheet.show(
      context,
      segmentId,
      speakersOnly: speakersOnly,
    );
    if (action == null || !context.mounted) return;
    final segment = context
        .read<TranscriptCubit>()
        .state
        .transcript
        ?.segments
        .where((s) => s.id == segmentId)
        .firstOrNull;
    switch (action) {
      case RenameSpeakerAction(:final speaker):
        await renameSpeaker(context, speaker);
      case EditTextAction():
        if (segment != null) await editText(context, segment);
      case AddCommentAction():
        await comments(context, segmentId: segmentId);
    }
  }

  /// [segmentId] opens the composer on that segment.
  static Future<void> comments(BuildContext context, {String? segmentId}) {
    final transcript = context.read<TranscriptCubit>().state.transcript;
    if (transcript == null) return Future.value();
    final me = context.read<AccountCubit>().state.account?.user.id;
    return CommentsSheet.show(
      context,
      transcript: transcript,
      myUserId: me,
      segmentId: segmentId,
    );
  }

  static Future<void> fileActions(BuildContext context) async {
    final transcriptCubit = context.read<TranscriptCubit>();
    final player = context.read<PlayerCubit>();
    final action = await showAppSheet<FileAction>(
      context,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: transcriptCubit),
          BlocProvider.value(value: player),
        ],
        child: const EditorActionsSheet(),
      ),
    );
    if (action == null || !context.mounted) return;
    final transcript = transcriptCubit.state.transcript;
    if (transcript == null) return;
    switch (action) {
      case FileAction.rename:
        await renameTitle(context);
      case FileAction.speed:
        await showSpeedSheet(context, player);
      case FileAction.export:
        await ExportSheet.show(context, transcript);
      case FileAction.share:
        await ShareSheet.show(context, transcript.id);
      case FileAction.comments:
        await comments(context);
      case FileAction.rating:
        await RatingSheet.show(context, transcript.id);
      case FileAction.retranscribe:
        final jobId = await RetranscribeSheet.show(context, transcript);
        if (jobId == null || !context.mounted) return;
        await player.pause();
        if (context.mounted) await context.push(Routes.jobOf(jobId));
    }
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/features/comments/application/comments_cubit.dart';
import 'package:transkriptor_uz/features/comments/domain/entities/comment.dart';
import 'package:transkriptor_uz/features/transcript/domain/entities/transcript.dart';

/// The transcript's comments, grouped by segment in transcript order.
/// Anyone who can read may write; only the author edits or deletes their
/// own. «Javob yozish» is one more comment on the same segment.
class CommentsSheet extends StatelessWidget {
  const CommentsSheet({
    required this.transcript,
    this.myUserId,
    this.segmentId,
    super.key,
  });

  final Transcript transcript;

  /// Marks the caller's own comments. Null: none is editable here.
  final String? myUserId;

  /// Opens the composer on this segment.
  final String? segmentId;

  static Future<void> show(
    BuildContext context, {
    required Transcript transcript,
    String? myUserId,
    String? segmentId,
  }) => showAppSheet<void>(
    context,
    builder: (_) => CommentsSheet(
      transcript: transcript,
      myUserId: myUserId,
      segmentId: segmentId,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<CommentsCubit>();
        unawaited(cubit.load(transcript.id));
        return cubit;
      },
      child: _CommentsView(sheet: this),
    );
  }
}

class _CommentsView extends StatefulWidget {
  const _CommentsView({required this.sheet});

  final CommentsSheet sheet;

  @override
  State<_CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<_CommentsView> {
  late final TextEditingController _text = TextEditingController()
    ..addListener(() => setState(() {}));

  /// The composer writes on this segment; null hides it.
  late String? _target = widget.sheet.segmentId;

  /// Set while the composer edits an existing comment.
  String? _editing;
  String? _confirmDelete;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _compose(String segmentId, {Comment? edit}) {
    context.read<CommentsCubit>().resetAction();
    setState(() {
      _target = segmentId;
      _editing = edit?.id;
      _confirmDelete = null;
      _text.text = edit?.body ?? '';
    });
  }

  void _closeComposer() => setState(() {
    _target = null;
    _editing = null;
    _text.clear();
  });

  void _send() {
    final cubit = context.read<CommentsCubit>();
    final editing = _editing;
    final target = _target;
    if (editing != null) {
      unawaited(cubit.edit(editing, _text.text));
    } else if (target != null) {
      unawaited(cubit.add(target, _text.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final transcript = widget.sheet.transcript;
    final segments = {for (final s in transcript.segments) s.id: s};
    return BlocConsumer<CommentsCubit, CommentsState>(
      listenWhen: (p, n) =>
          p.actionStatus != n.actionStatus &&
          n.actionStatus == CommentActionStatus.done,
      listener: (context, _) {
        setState(() => _confirmDelete = null);
        if (_target != null) _closeComposer();
      },
      builder: (context, state) {
        final busy = state.actionStatus == CommentActionStatus.busy;
        final target = _target;
        return AppSheet(
          title: l10n.editorComments,
          footer: target == null
              ? null
              : _Composer(
                  segment: segments[target],
                  controller: _text,
                  busy: busy,
                  failure: state.actionStatus == CommentActionStatus.failure
                      ? state.actionFailure?.message(l10n)
                      : null,
                  onCancel: _closeComposer,
                  onSend: _send,
                ),
          child: switch (state.status) {
            CommentsStatus.initial || CommentsStatus.loading => const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            ),
            CommentsStatus.failure => Column(
              children: [
                Text(state.failure!.message(l10n), style: AppText.body),
                TextButton(
                  onPressed: () =>
                      context.read<CommentsCubit>().load(transcript.id),
                  child: Text(l10n.retry),
                ),
              ],
            ),
            CommentsStatus.empty => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                l10n.commentsEmpty,
                textAlign: TextAlign.center,
                style: AppText.caption,
              ),
            ),
            CommentsStatus.success => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final (segmentId, comments) in state.grouped([
                  for (final s in transcript.segments) s.id,
                ]))
                  _Group(
                    segment: segments[segmentId],
                    comments: comments,
                    myUserId: widget.sheet.myUserId,
                    busy: busy,
                    confirmDelete: _confirmDelete,
                    onReply: () => _compose(segmentId),
                    onEdit: (c) => _compose(segmentId, edit: c),
                    onAskDelete: (c) => setState(() => _confirmDelete = c.id),
                    onCancelDelete: () => setState(() => _confirmDelete = null),
                    onDelete: (c) => context.read<CommentsCubit>().delete(c.id),
                  ),
              ],
            ),
          },
        );
      },
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({
    required this.segment,
    required this.comments,
    required this.myUserId,
    required this.busy,
    required this.confirmDelete,
    required this.onReply,
    required this.onEdit,
    required this.onAskDelete,
    required this.onCancelDelete,
    required this.onDelete,
  });

  /// Null when the segment was deleted since.
  final Segment? segment;
  final List<Comment> comments;
  final String? myUserId;
  final bool busy;
  final String? confirmDelete;
  final VoidCallback onReply;
  final ValueChanged<Comment> onEdit;
  final ValueChanged<Comment> onAskDelete;
  final VoidCallback onCancelDelete;
  final ValueChanged<Comment> onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final segment = this.segment;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(12, 10, 4, 4),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              segment == null
                  ? l10n.commentsSegmentGone
                  : '${Formatters.timecode(segment.start)}  ${segment.text}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppText.caption,
            ),
          ),
          for (final c in comments)
            _CommentRow(
              comment: c,
              mine: c.authorId != null && c.authorId == myUserId,
              busy: busy,
              confirming: confirmDelete == c.id,
              onEdit: () => onEdit(c),
              onAskDelete: () => onAskDelete(c),
              onCancelDelete: onCancelDelete,
              onDelete: () => onDelete(c),
            ),
          if (segment != null)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                key: Key('comment_reply_${segment.id}'),
                onPressed: busy ? null : onReply,
                child: Text(l10n.commentsReply),
              ),
            ),
        ],
      ),
    );
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({
    required this.comment,
    required this.mine,
    required this.busy,
    required this.confirming,
    required this.onEdit,
    required this.onAskDelete,
    required this.onCancelDelete,
    required this.onDelete,
  });

  final Comment comment;
  final bool mine;
  final bool busy;
  final bool confirming;
  final VoidCallback onEdit;
  final VoidCallback onAskDelete;
  final VoidCallback onCancelDelete;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final created = comment.createdAt;
    final who = mine
        ? l10n.commentsYou
        : (comment.authorName.isEmpty ? '—' : comment.authorName);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  [
                    who,
                    if (created != null) Formatters.date(created),
                  ].join(' · '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.caption.copyWith(color: AppColors.cotton),
                ),
              ),
              if (mine) ...[
                IconButton(
                  key: Key('comment_edit_${comment.id}'),
                  visualDensity: VisualDensity.compact,
                  tooltip: context.l10n.editorEdit,
                  onPressed: busy ? null : onEdit,
                  icon: const Icon(Icons.edit_outlined, size: 18),
                ),
                IconButton(
                  key: Key('comment_delete_${comment.id}'),
                  visualDensity: VisualDensity.compact,
                  tooltip: l10n.commentsDelete,
                  onPressed: busy ? null : onAskDelete,
                  icon: const Icon(Icons.delete_outline_rounded, size: 18),
                ),
              ],
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(comment.body, style: AppText.body),
          ),
          if (confirming)
            Padding(
              padding: const EdgeInsets.only(top: 6, right: 8),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  Text(l10n.commentsDeleteConfirm, style: AppText.caption),
                  TextButton(
                    onPressed: busy ? null : onCancelDelete,
                    child: Text(l10n.cancel),
                  ),
                  TextButton(
                    key: Key('comment_delete_yes_${comment.id}'),
                    onPressed: busy ? null : onDelete,
                    style: TextButton.styleFrom(foregroundColor: AppColors.bad),
                    child: Text(l10n.commentsDelete),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.segment,
    required this.controller,
    required this.busy,
    required this.failure,
    required this.onCancel,
    required this.onSend,
  });

  final Segment? segment;
  final TextEditingController controller;
  final bool busy;
  final String? failure;
  final VoidCallback onCancel;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final segment = this.segment;
    final text = CommentRules.clean(controller.text);
    final tooLong = CommentRules.tooLong(text);
    final failure = this.failure;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (segment != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              '${Formatters.timecode(segment.start)}  ${segment.text}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.caption,
            ),
          ),
        TextField(
          key: const Key('comment_field'),
          controller: controller,
          autofocus: true,
          enabled: !busy,
          minLines: 1,
          maxLines: 4,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: l10n.commentsHint,
            errorText: tooLong ? l10n.commentsTooLong : null,
          ),
        ),
        if (failure != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(failure, style: const TextStyle(color: AppColors.bad)),
          ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: busy ? null : onCancel,
              child: Text(l10n.cancel),
            ),
            const SizedBox(width: 8),
            FilledButton(
              key: const Key('comment_send'),
              onPressed: busy || text.isEmpty || tooLong ? null : onSend,
              child: Text(l10n.commentsSend),
            ),
          ],
        ),
      ],
    );
  }
}

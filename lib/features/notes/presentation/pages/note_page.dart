import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/action_row.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_loading_view.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/features/notes/application/note_cubit.dart';
import 'package:transkriptor_uz/features/notes/domain/entities/note.dart';
import 'package:transkriptor_uz/features/notes/domain/note_document.dart';
import 'package:transkriptor_uz/features/notes/presentation/widgets/note_body.dart';
import 'package:transkriptor_uz/features/notes/presentation/widgets/note_title.dart';

/// One note, read-only: its text, a copy button, and «…» for rename and
/// delete. Pops `true` when the note changed, so the list reloads.
class NotePage extends StatelessWidget {
  const NotePage({required this.noteId, super.key});

  final String noteId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<NoteCubit>();
        unawaited(cubit.load(noteId));
        return cubit;
      },
      child: const _NoteView(),
    );
  }
}

class _NoteView extends StatelessWidget {
  const _NoteView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        final note = state.note;
        final text = note == null ? '' : NoteDocument.plainText(note.blocks);
        return PopScope(
          canPop: !state.changed,
          // A rename or a delete must reach the list behind.
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop && state.changed) context.pop(true);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                note == null ? '' : noteDisplayTitle(l10n, note.title, text),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.title,
              ),
              actions: [
                if (note != null) ...[
                  IconButton(
                    key: const Key('note_copy'),
                    tooltip: l10n.noteCopy,
                    icon: const Icon(Icons.copy_rounded),
                    onPressed: text.isEmpty ? null : () => _copy(context, text),
                  ),
                  IconButton(
                    key: const Key('note_more'),
                    tooltip: l10n.filesMore,
                    icon: const Icon(Icons.more_horiz_rounded),
                    onPressed: () => _menu(context, note, text),
                  ),
                ],
              ],
            ),
            body: ContentWidth(
              maxWidth: ContentWidth.list,
              child: switch (state.status) {
                NoteStatus.initial ||
                NoteStatus.loading => const AppLoadingView(),
                NoteStatus.failure => AppErrorView(
                  failure: state.failure ?? const Failure.unknown(),
                  onRetry: () =>
                      context.read<NoteCubit>().load(state.noteId ?? ''),
                ),
                NoteStatus.success => _NoteContent(note: note!, text: text),
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _copy(BuildContext context, String text) async {
    final messenger = ScaffoldMessenger.of(context);
    final copied = context.l10n.noteCopied;
    await Clipboard.setData(ClipboardData(text: text));
    messenger.showSnackBar(SnackBar(content: Text(copied)));
  }

  Future<void> _menu(BuildContext context, Note note, String text) async {
    final l10n = context.l10n;
    final action = await showAppSheet<_NoteAction>(
      context,
      builder: (sheet) => AppSheet(
        title: noteDisplayTitle(l10n, note.title, text),
        child: ActionGroup(
          children: [
            ActionRow(
              key: const Key('note_rename'),
              icon: Icons.edit_outlined,
              label: l10n.folderRename,
              showChevron: false,
              onTap: () => Navigator.of(sheet).pop(_NoteAction.rename),
            ),
            ActionRow(
              key: const Key('note_delete'),
              icon: Icons.delete_outline,
              label: l10n.folderDelete,
              destructive: true,
              showChevron: false,
              onTap: () => Navigator.of(sheet).pop(_NoteAction.delete),
            ),
          ],
        ),
      ),
    );
    if (action == null || !context.mounted) return;
    final cubit = context.read<NoteCubit>()..resetAction();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      enableDrag: false,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: switch (action) {
          _NoteAction.rename => _RenameNoteSheet(note: note),
          _NoteAction.delete => _DeleteNoteSheet(
            name: noteDisplayTitle(l10n, note.title, text),
          ),
        },
      ),
    );
    // Gone: back to the list, which reloads. Done here, once the sheet is
    // closed, so the two pops cannot take each other's route.
    if (cubit.state.deleted && context.mounted) context.pop(true);
  }
}

enum _NoteAction { rename, delete }

class _NoteContent extends StatelessWidget {
  const _NoteContent({required this.note, required this.text});

  final Note note;
  final String text;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final origin = note.origin;
    final updated = note.updatedAt ?? note.createdAt;
    return SelectionArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          if (origin != null)
            Align(
              alignment: Alignment.centerLeft,
              child: origin.available
                  ? TextButton.icon(
                      key: const Key('note_origin'),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () => context.push(
                        Routes.transcriptOf(origin.transcriptId),
                      ),
                      icon: const Icon(Icons.description_outlined, size: 18),
                      label: Text(
                        l10n.noteFromTranscript(origin.title),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : Text(l10n.noteSourceGone, style: AppText.caption),
            ),
          if (updated != null) ...[
            Text(
              l10n.noteUpdated(Formatters.date(updated)),
              style: AppText.mono,
            ),
            const SizedBox(height: 16),
          ],
          if (text.isEmpty)
            Text(l10n.noteEmpty, style: AppText.muted)
          else
            NoteBody(blocks: note.blocks),
        ],
      ),
    );
  }
}

/// Why a rename or delete did not go through; 409 is a stale revision.
String _noteFailureText(AppLocalizations l10n, Failure failure) =>
    switch (failure) {
      ServerFailure(statusCode: 409) => l10n.noteStale,
      _ => failure.message(l10n),
    };

/// Closes the sheet once the cubit says the action is done.
class _NoteActionScope extends StatelessWidget {
  const _NoteActionScope({required this.builder});

  final Widget Function(BuildContext context, NoteState state) builder;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteState>(
      listenWhen: (prev, next) =>
          prev.actionStatus != next.actionStatus &&
          next.actionStatus == NoteActionStatus.done,
      listener: (context, _) => Navigator.of(context).pop(),
      builder: (context, state) => PopScope(
        canPop: state.actionStatus != NoteActionStatus.busy,
        child: builder(context, state),
      ),
    );
  }
}

class _ActionFailure extends StatelessWidget {
  const _ActionFailure(this.state);

  final NoteState state;

  @override
  Widget build(BuildContext context) {
    final failure = state.actionFailure;
    if (failure == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        _noteFailureText(context.l10n, failure),
        style: AppText.caption.copyWith(color: AppColors.bad),
      ),
    );
  }
}

class _RenameNoteSheet extends StatefulWidget {
  const _RenameNoteSheet({required this.note});

  final Note note;

  @override
  State<_RenameNoteSheet> createState() => _RenameNoteSheetState();
}

class _RenameNoteSheetState extends State<_RenameNoteSheet> {
  late final TextEditingController _title = TextEditingController(
    text: widget.note.title,
  );
  bool _invalid = false;

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  void _submit() {
    final title = NoteRules.normalizeTitle(_title.text);
    setState(() => _invalid = title == null);
    if (title != null) unawaited(context.read<NoteCubit>().rename(title));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _NoteActionScope(
      builder: (context, state) {
        final busy = state.actionStatus == NoteActionStatus.busy;
        return AppSheet(
          title: l10n.noteRenameTitle,
          footer: FilledButton(
            key: const Key('note_rename_save'),
            onPressed: busy ? null : _submit,
            child: Text(l10n.actionSave),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                key: const Key('note_title'),
                controller: _title,
                autofocus: true,
                enabled: !busy,
                maxLength: NoteRules.maxTitle,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                decoration: InputDecoration(
                  hintText: l10n.noteTitleHint,
                  errorText: _invalid
                      ? l10n.noteTitleInvalid(NoteRules.maxTitle)
                      : null,
                ),
              ),
              _ActionFailure(state),
            ],
          ),
        );
      },
    );
  }
}

class _DeleteNoteSheet extends StatelessWidget {
  const _DeleteNoteSheet({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _NoteActionScope(
      builder: (context, state) {
        final busy = state.actionStatus == NoteActionStatus.busy;
        return AppSheet(
          title: l10n.noteDeleteTitle,
          footer: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: busy ? null : () => Navigator.of(context).pop(),
                  child: Text(l10n.cancel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  key: const Key('note_delete_confirm'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.bad,
                    foregroundColor: AppColors.sf0,
                  ),
                  onPressed: busy
                      ? null
                      : () => context.read<NoteCubit>().delete(),
                  child: Text(l10n.folderDelete),
                ),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.noteDeleteBody(name), style: AppText.body),
              _ActionFailure(state),
            ],
          ),
        );
      },
    );
  }
}

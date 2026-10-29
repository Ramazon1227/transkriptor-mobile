import 'dart:async';

import 'package:flutter/material.dart';
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
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/job/domain/entities/job.dart';
import 'package:transkriptor_uz/features/library/application/file_actions_cubit.dart';
import 'package:transkriptor_uz/features/library/application/folders_cubit.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/tag_rules.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/library_failure_text.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/library_item_source.dart';
import 'package:transkriptor_uz/features/share/presentation/widgets/share_sheet.dart';

/// A file's «…» menu on the files screen. Each choice opens its own sheet,
/// which closes only once the server has answered; a failure stays on it.
/// Confirmations (retranscribe, delete) live in that sheet too — never a
/// system dialog.
abstract final class FileActionsSheet {
  /// Every action changes the workspace, so a VIEWER gets none and the
  /// row hides its «…».
  static bool hasActions({required bool canWrite}) => canWrite;

  static Future<void> show(BuildContext context, LibraryItem item) async {
    final choice = await showAppSheet<FileAction>(
      context,
      builder: (_) => FileMenuSheet(item: item),
    );
    if (choice == null || !context.mounted) return;
    if (choice == FileAction.share) {
      final transcriptId = item.transcriptId;
      if (transcriptId != null) await ShareSheet.show(context, transcriptId);
      return;
    }
    final folders = context.read<FoldersCubit>();
    final jobId = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      // Drag-to-dismiss pops past PopScope; back and the barrier respect
      // a running save.
      enableDrag: false,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: folders),
          BlocProvider(create: (_) => getIt<FileActionsCubit>()),
        ],
        child: switch (choice) {
          FileAction.rename => _RenameSheet(item: item),
          FileAction.move => _MoveSheet(item: item),
          FileAction.tags => _TagsSheet(item: item),
          FileAction.retranscribe => _ConfirmSheet(item: item, action: choice),
          FileAction.delete => _ConfirmSheet(item: item, action: choice),
          FileAction.share => const SizedBox.shrink(),
        },
      ),
    );
    // A new job: follow it, as the web's retry does.
    if (jobId != null && context.mounted) {
      await context.push(Routes.jobOf(jobId));
    }
  }
}

enum FileAction { rename, move, tags, share, retranscribe, delete }

/// The «…» menu itself: the file on top, then its actions.
class FileMenuSheet extends StatelessWidget {
  const FileMenuSheet({required this.item, super.key});

  final LibraryItem item;

  /// A new job only makes sense once the previous one is over.
  static bool canRetranscribe(LibraryItem item) => switch (item.jobStatus) {
    JobStatus.succeeded || JobStatus.failed || JobStatus.cancelled => true,
    _ => false,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final created = item.createdAt;
    final duration = item.duration;
    final meta = [
      if (created != null) Formatters.date(created),
      if (duration != null) Formatters.timecode(duration),
    ].join(' · ');
    Widget row(FileAction a, IconData icon, String label) => ActionRow(
      key: Key('file_${a.name}'),
      icon: icon,
      label: label,
      destructive: a == FileAction.delete,
      showChevron: false,
      onTap: () => Navigator.of(context).pop(a),
    );
    return AppSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SourceIcon(source: item.captureSource),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.bodyStrong,
                    ),
                    if (meta.isNotEmpty) Text(meta, style: AppText.mono),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ActionGroup(
            children: [
              row(FileAction.rename, Icons.edit_outlined, l10n.folderRename),
              row(
                FileAction.move,
                Icons.drive_file_move_outline,
                l10n.fileMove,
              ),
              row(FileAction.tags, Icons.sell_outlined, l10n.fileTags),
              if (item.jobStatus == JobStatus.succeeded &&
                  item.transcriptId != null)
                row(FileAction.share, Icons.ios_share_rounded, l10n.shareTitle),
              if (canRetranscribe(item))
                row(
                  FileAction.retranscribe,
                  Icons.refresh_rounded,
                  l10n.fileRetranscribe,
                ),
              row(FileAction.delete, Icons.delete_outline, l10n.folderDelete),
            ],
          ),
        ],
      ),
    );
  }
}

/// Closes the sheet when the change went through, answering the new job's
/// id after a retranscription.
class _CloseWhenDone extends StatelessWidget {
  const _CloseWhenDone({required this.builder});

  final Widget Function(BuildContext context, FileActionsState state) builder;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FileActionsCubit, FileActionsState>(
      listenWhen: (prev, next) =>
          prev.status != next.status && next.status == FileActionStatus.done,
      listener: (context, state) => Navigator.of(context).pop(state.jobId),
      builder: (context, state) => PopScope(
        canPop: state.status != FileActionStatus.busy,
        child: builder(context, state),
      ),
    );
  }
}

/// Why [action] did not go through. Retranscribe has answers of its own:
/// 409 is a link job already running, 422 a file never fully uploaded.
String fileActionFailureText(
  AppLocalizations l10n,
  FileAction action,
  Failure failure,
) => switch ((action, failure)) {
  (FileAction.retranscribe, ServerFailure(statusCode: 409)) =>
    l10n.fileRetranscribeConflict,
  (FileAction.retranscribe, ServerFailure(statusCode: 422)) =>
    l10n.fileRetranscribeNotReady,
  (FileAction.rename, ServerFailure(statusCode: 400)) =>
    l10n.fileNameInvalid(FileRules.maxName),
  _ => libraryFailureText(l10n, failure),
};

class _FailureLine extends StatelessWidget {
  const _FailureLine(this.state, this.action);

  final FileActionsState state;
  final FileAction action;

  @override
  Widget build(BuildContext context) {
    final failure = state.failure;
    if (failure == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        fileActionFailureText(context.l10n, action, failure),
        style: AppText.caption.copyWith(color: AppColors.bad),
      ),
    );
  }
}

class _RenameSheet extends StatefulWidget {
  const _RenameSheet({required this.item});

  final LibraryItem item;

  @override
  State<_RenameSheet> createState() => _RenameSheetState();
}

class _RenameSheetState extends State<_RenameSheet> {
  late final TextEditingController _name = TextEditingController(
    text: widget.item.name,
  );
  bool _invalid = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _submit() {
    final name = FileRules.normalize(_name.text);
    setState(() => _invalid = name == null);
    if (name != null) {
      unawaited(context.read<FileActionsCubit>().rename(widget.item, name));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _CloseWhenDone(
      builder: (context, state) {
        final busy = state.status == FileActionStatus.busy;
        return AppSheet(
          title: l10n.fileRenameTitle,
          footer: FilledButton(
            key: const Key('file_rename_save'),
            onPressed: busy ? null : _submit,
            child: Text(l10n.actionSave),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                key: const Key('file_name'),
                controller: _name,
                autofocus: true,
                enabled: !busy,
                maxLength: FileRules.maxName,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                decoration: InputDecoration(
                  hintText: l10n.fileNameHint,
                  errorText: _invalid
                      ? l10n.fileNameInvalid(FileRules.maxName)
                      : null,
                ),
              ),
              _FailureLine(state, FileAction.rename),
            ],
          ),
        );
      },
    );
  }
}

/// Retranscribe (spends balance) or delete (cannot be undone): the
/// question and the answer in one sheet.
class _ConfirmSheet extends StatelessWidget {
  const _ConfirmSheet({required this.item, required this.action});

  final LibraryItem item;
  final FileAction action;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final delete = action == FileAction.delete;
    final duration = item.duration;
    final running =
        item.jobStatus == JobStatus.queued ||
        item.jobStatus == JobStatus.running;
    return _CloseWhenDone(
      builder: (context, state) {
        final busy = state.status == FileActionStatus.busy;
        final cubit = context.read<FileActionsCubit>();
        return AppSheet(
          title: delete ? l10n.fileDeleteTitle : l10n.fileRetranscribe,
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
                  key: Key('file_${action.name}_confirm'),
                  style: delete
                      ? FilledButton.styleFrom(
                          backgroundColor: AppColors.bad,
                          foregroundColor: AppColors.sf0,
                        )
                      : null,
                  onPressed: busy
                      ? null
                      : () => delete
                            ? cubit.delete(item)
                            : cubit.retranscribe(item),
                  child: busy
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          delete
                              ? l10n.folderDelete
                              : l10n.fileRetranscribeConfirm,
                        ),
                ),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                delete
                    ? l10n.fileDeleteBody(item.name)
                    : l10n.fileRetranscribeBody,
                style: AppText.body,
              ),
              if (delete && running) ...[
                const SizedBox(height: 8),
                Text(l10n.fileDeleteRunning, style: AppText.caption),
              ],
              if (!delete && duration != null) ...[
                const SizedBox(height: 8),
                Text(
                  l10n.fileRetranscribeCost(
                    Formatters.minutesNeeded(duration),
                  ),
                  style: AppText.caption,
                ),
              ],
              _FailureLine(state, action),
            ],
          ),
        );
      },
    );
  }
}

class _MoveSheet extends StatelessWidget {
  const _MoveSheet({required this.item});

  final LibraryItem item;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final folders = context
        .select<FoldersCubit, FoldersState>((c) => c.state)
        .folders;
    return _CloseWhenDone(
      builder: (context, state) {
        final busy = state.status == FileActionStatus.busy;
        final cubit = context.read<FileActionsCubit>();
        Widget option(String? id, String label, IconData icon) => ActionRow(
          key: Key('move_${id ?? 'none'}'),
          icon: icon,
          label: label,
          showChevron: false,
          trailing: item.folderId == id
              ? const Icon(Icons.check, size: 18, color: AppColors.accent)
              : null,
          onTap: busy ? null : () => cubit.move(item, id),
        );
        return AppSheet(
          title: l10n.fileMove,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ActionGroup(
                children: [
                  option(null, l10n.folderNone, Icons.inbox_outlined),
                  for (final f in folders)
                    option(f.id, f.name, Icons.folder_outlined),
                ],
              ),
              _FailureLine(state, FileAction.move),
            ],
          ),
        );
      },
    );
  }
}

class _TagsSheet extends StatefulWidget {
  const _TagsSheet({required this.item});

  final LibraryItem item;

  @override
  State<_TagsSheet> createState() => _TagsSheetState();
}

class _TagsSheetState extends State<_TagsSheet> {
  late final List<String> _tags = [...widget.item.tags];
  final TextEditingController _input = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _add() {
    final l10n = context.l10n;
    final tag = TagRules.normalize(_input.text);
    setState(() {
      if (tag == null) {
        _error = l10n.tagInvalid(TagRules.maxLength);
      } else if (!_tags.contains(tag) && _tags.length >= TagRules.maxTags) {
        _error = l10n.tagTooMany(TagRules.maxTags);
      } else {
        _error = null;
        if (!_tags.contains(tag)) _tags.add(tag);
        _input.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _CloseWhenDone(
      builder: (context, state) {
        final busy = state.status == FileActionStatus.busy;
        return AppSheet(
          title: l10n.fileTags,
          footer: FilledButton(
            key: const Key('tags_save'),
            onPressed: busy
                ? null
                : () => context.read<FileActionsCubit>().setTags(
                    widget.item,
                    List.of(_tags),
                  ),
            child: Text(l10n.actionSave),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_tags.isEmpty)
                Text(l10n.tagsNone, style: AppText.muted)
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final t in _tags)
                      InputChip(
                        key: Key('tag_chip_$t'),
                        label: Text(t),
                        onDeleted: busy
                            ? null
                            : () => setState(() => _tags.remove(t)),
                      ),
                  ],
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: const Key('tag_input'),
                      controller: _input,
                      enabled: !busy,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _add(),
                      decoration: InputDecoration(
                        hintText: l10n.tagNewHint,
                        errorText: _error,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    key: const Key('tag_add'),
                    onPressed: busy ? null : _add,
                    child: Text(l10n.tagAdd),
                  ),
                ],
              ),
              _FailureLine(state, FileAction.tags),
            ],
          ),
        );
      },
    );
  }
}

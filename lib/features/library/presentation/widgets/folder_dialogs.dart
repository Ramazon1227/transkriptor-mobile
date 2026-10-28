import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/features/library/application/folders_cubit.dart';
import 'package:transkriptor_uz/features/library/domain/entities/folder.dart';
import 'package:transkriptor_uz/features/library/domain/tag_rules.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/library_failure_text.dart';

/// Opens [dialog] over a context that sees the page's [FoldersCubit]. The
/// previous failure is cleared first, so it never shows on a new dialog.
Future<void> _showFolderDialog(BuildContext context, Widget dialog) {
  final cubit = context.read<FoldersCubit>()..clearActionFailure();
  return showDialog<void>(
    context: context,
    builder: (_) => BlocProvider.value(value: cubit, child: dialog),
  );
}

/// Closes once the cubit goes from busy back to idle — the change went
/// through. A failure stays in the dialog.
bool _finished(FoldersState prev, FoldersState next) =>
    prev.actionStatus == FolderActionStatus.busy &&
    next.actionStatus == FolderActionStatus.idle;

/// Create a folder, or rename [folder].
class FolderNameDialog extends StatefulWidget {
  const FolderNameDialog({this.folder, super.key});

  final Folder? folder;

  static Future<void> show(BuildContext context, {Folder? folder}) =>
      _showFolderDialog(context, FolderNameDialog(folder: folder));

  @override
  State<FolderNameDialog> createState() => _FolderNameDialogState();
}

class _FolderNameDialogState extends State<FolderNameDialog> {
  late final TextEditingController _name = TextEditingController(
    text: widget.folder?.name ?? '',
  );
  bool _invalid = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _submit() {
    final name = FolderRules.normalize(_name.text);
    setState(() => _invalid = name == null);
    if (name == null) return;
    final cubit = context.read<FoldersCubit>();
    final folder = widget.folder;
    if (folder == null) {
      unawaited(cubit.create(name));
    } else if (name != folder.name) {
      unawaited(cubit.rename(folder.id, name));
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<FoldersCubit, FoldersState>(
      listenWhen: _finished,
      listener: (context, _) => Navigator.of(context).pop(),
      builder: (context, state) {
        final busy = state.actionStatus == FolderActionStatus.busy;
        final failure = state.actionFailure;
        return PopScope(
          canPop: !busy,
          child: AlertDialog(
            title: Text(
              widget.folder == null
                  ? l10n.folderCreateTitle
                  : l10n.folderRenameTitle,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  key: const Key('folder_name'),
                  controller: _name,
                  autofocus: true,
                  enabled: !busy,
                  maxLength: FolderRules.maxName,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    hintText: l10n.folderNameHint,
                    errorText: _invalid
                        ? l10n.folderNameInvalid(FolderRules.maxName)
                        : null,
                  ),
                ),
                if (failure != null)
                  Text(
                    libraryFailureText(l10n, failure),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: busy ? null : () => Navigator.of(context).pop(),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                key: const Key('folder_save'),
                onPressed: busy ? null : _submit,
                child: Text(l10n.actionSave),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Confirms deleting [folder]; its files stay, outside any folder.
class FolderDeleteDialog extends StatelessWidget {
  const FolderDeleteDialog({required this.folder, super.key});

  final Folder folder;

  static Future<void> show(BuildContext context, Folder folder) =>
      _showFolderDialog(context, FolderDeleteDialog(folder: folder));

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final error = Theme.of(context).colorScheme.error;
    return BlocConsumer<FoldersCubit, FoldersState>(
      listenWhen: _finished,
      listener: (context, _) => Navigator.of(context).pop(),
      builder: (context, state) {
        final busy = state.actionStatus == FolderActionStatus.busy;
        final failure = state.actionFailure;
        return PopScope(
          canPop: !busy,
          child: AlertDialog(
            title: Text(l10n.folderDeleteTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  folder.fileCount > 0
                      ? l10n.folderDeleteBody(folder.name, folder.fileCount)
                      : l10n.folderDeleteEmptyBody(folder.name),
                ),
                if (failure != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    libraryFailureText(l10n, failure),
                    style: TextStyle(color: error),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: busy ? null : () => Navigator.of(context).pop(),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                key: const Key('folder_delete_confirm'),
                style: FilledButton.styleFrom(backgroundColor: error),
                onPressed: busy
                    ? null
                    : () => context.read<FoldersCubit>().delete(folder.id),
                child: Text(l10n.folderDelete),
              ),
            ],
          ),
        );
      },
    );
  }
}

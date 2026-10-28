import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/features/library/application/file_actions_cubit.dart';
import 'package:transkriptor_uz/features/library/application/folders_cubit.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/tag_rules.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/library_failure_text.dart';

/// A file's long-press menu on the files screen: move it to a folder or
/// edit its tags. Each choice opens its own sheet, which closes only once
/// the server has answered; a failure stays on it.
abstract final class FileActionsSheet {
  static Future<void> show(BuildContext context, LibraryItem item) async {
    final l10n = context.l10n;
    final choice = await showModalBottomSheet<_Choice>(
      context: context,
      useSafeArea: true,
      builder: (sheet) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Text(
                item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.label,
              ),
            ),
            ListTile(
              key: const Key('file_move'),
              leading: const Icon(Icons.drive_file_move_outline),
              title: Text(l10n.fileMove),
              onTap: () => Navigator.of(sheet).pop(_Choice.move),
            ),
            ListTile(
              key: const Key('file_tags'),
              leading: const Icon(Icons.sell_outlined),
              title: Text(l10n.fileTags),
              onTap: () => Navigator.of(sheet).pop(_Choice.tags),
            ),
          ],
        ),
      ),
    );
    if (choice == null || !context.mounted) return;
    final folders = context.read<FoldersCubit>();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      // Drag-to-dismiss pops past PopScope; back and the barrier respect
      // a running save.
      enableDrag: false,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: folders),
          BlocProvider(create: (_) => getIt<FileActionsCubit>()),
        ],
        child: switch (choice) {
          _Choice.move => _MoveSheet(item: item),
          _Choice.tags => _TagsSheet(item: item),
        },
      ),
    );
  }
}

enum _Choice { move, tags }

/// Closes the sheet when the change went through.
class _CloseWhenDone extends StatelessWidget {
  const _CloseWhenDone({required this.builder});

  final Widget Function(BuildContext context, FileActionsState state) builder;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FileActionsCubit, FileActionsState>(
      listenWhen: (prev, next) =>
          prev.status != next.status && next.status == FileActionStatus.done,
      listener: (context, _) => Navigator.of(context).pop(),
      builder: (context, state) => PopScope(
        canPop: state.status != FileActionStatus.busy,
        child: builder(context, state),
      ),
    );
  }
}

class _FailureLine extends StatelessWidget {
  const _FailureLine(this.state);

  final FileActionsState state;

  @override
  Widget build(BuildContext context) {
    final failure = state.failure;
    if (failure == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        libraryFailureText(context.l10n, failure),
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
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
        Widget option(String? id, String label, IconData icon) => ListTile(
          key: Key('move_${id ?? 'none'}'),
          enabled: !busy,
          leading: Icon(icon),
          title: Text(label),
          trailing: item.folderId == id
              ? const Icon(Icons.check, size: 18)
              : null,
          onTap: () => cubit.move(item, id),
        );
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
                child: Text(l10n.fileMove, style: AppText.title),
              ),
              option(null, l10n.folderNone, Icons.inbox_outlined),
              for (final f in folders)
                option(f.id, f.name, Icons.folder_outlined),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _FailureLine(state),
              ),
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
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            20,
            16,
            20,
            16 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.fileTags, style: AppText.title),
              const SizedBox(height: 12),
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
              _FailureLine(state),
              const SizedBox(height: 16),
              FilledButton(
                key: const Key('tags_save'),
                onPressed: busy
                    ? null
                    : () => context.read<FileActionsCubit>().setTags(
                        widget.item,
                        List.of(_tags),
                      ),
                child: Text(l10n.actionSave),
              ),
            ],
          ),
        );
      },
    );
  }
}

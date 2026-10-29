import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/widgets/action_row.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/features/library/application/folders_cubit.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/domain/entities/folder.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/filter_tab.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/folder_dialogs.dart';

/// «Hammasi», the workspace's folders with their counts, and «+ Papka».
/// A long press on a folder opens rename and delete. [canWrite] false (a
/// VIEWER) keeps only the filter.
class FolderBar extends StatelessWidget {
  const FolderBar({required this.canWrite, super.key});

  final bool canWrite;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final folders = context.select<FoldersCubit, List<Folder>>(
      (c) => c.state.folders,
    );
    final selected = context.select<LibraryBloc, String?>(
      (b) => b.state.folderId,
    );
    final library = context.read<LibraryBloc>();
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        children: [
          FilterTab(
            key: const Key('folder_all'),
            label: l10n.filesAll,
            icon: Icons.inbox_outlined,
            selected: selected == null,
            onTap: () => library.add(const LibraryFolderSelected(null)),
          ),
          for (final f in folders)
            FilterTab(
              key: Key('folder_${f.id}'),
              label: f.name,
              icon: Icons.folder_outlined,
              count: f.fileCount,
              selected: selected == f.id,
              onTap: () => library.add(LibraryFolderSelected(f.id)),
              onLongPress: canWrite ? () => _menu(context, f) : null,
            ),
          if (canWrite)
            FilterTab(
              key: const Key('folder_new'),
              label: l10n.folderNew,
              icon: Icons.add,
              selected: false,
              onTap: () => FolderNameDialog.show(context),
            ),
        ],
      ),
    );
  }

  Future<void> _menu(BuildContext context, Folder folder) async {
    final l10n = context.l10n;
    final action = await showAppSheet<_FolderAction>(
      context,
      builder: (sheet) => AppSheet(
        title: folder.name,
        child: ActionGroup(
          children: [
            ActionRow(
              key: const Key('folder_rename'),
              icon: Icons.edit_outlined,
              label: l10n.folderRename,
              showChevron: false,
              onTap: () => Navigator.of(sheet).pop(_FolderAction.rename),
            ),
            ActionRow(
              key: const Key('folder_delete'),
              icon: Icons.delete_outline,
              label: l10n.folderDelete,
              destructive: true,
              showChevron: false,
              onTap: () => Navigator.of(sheet).pop(_FolderAction.delete),
            ),
          ],
        ),
      ),
    );
    if (!context.mounted) return;
    switch (action) {
      case _FolderAction.rename:
        await FolderNameDialog.show(context, folder: folder);
      case _FolderAction.delete:
        await FolderDeleteDialog.show(context, folder);
      case null:
        break;
    }
  }
}

enum _FolderAction { rename, delete }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/features/library/application/folders_cubit.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/domain/entities/folder.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/filter_tab.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/folder_dialogs.dart';

/// «Hammasi», the workspace's folders with their counts, and «+ Papka».
/// A long press on a folder opens rename and delete.
class FolderBar extends StatelessWidget {
  const FolderBar({super.key});

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
    return Container(
      height: 44,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.sf2)),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
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
              onLongPress: () => _menu(context, f),
            ),
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
    final action = await showModalBottomSheet<_FolderAction>(
      context: context,
      useSafeArea: true,
      builder: (sheet) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              key: const Key('folder_rename'),
              leading: const Icon(Icons.edit_outlined),
              title: Text(l10n.folderRename),
              onTap: () => Navigator.of(sheet).pop(_FolderAction.rename),
            ),
            ListTile(
              key: const Key('folder_delete'),
              leading: Icon(
                Icons.delete_outline,
                color: Theme.of(sheet).colorScheme.error,
              ),
              title: Text(l10n.folderDelete),
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

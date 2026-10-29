import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/action_row.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_loading_view.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';
import 'package:transkriptor_uz/features/library/application/folders_cubit.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/file_actions_sheet.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/files_empty_view.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/folder_bar.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/folder_dialogs.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/library_tile.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/source_tabs.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/tag_filter_bar.dart';
import 'package:transkriptor_uz/features/notes/application/notes_cubit.dart';
import 'package:transkriptor_uz/features/notes/presentation/widgets/notes_list.dart';
import 'package:transkriptor_uz/features/workspace/presentation/widgets/workspace_switcher_sheet.dart';

/// The Files tab: «Fayllar ⌄» with search, the source tabs, folders and
/// tags under them, and the rows. Everything belongs to the current
/// workspace; switching it rebuilds the lot.
class FilesPage extends StatelessWidget {
  const FilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContentWidth(
          maxWidth: ContentWidth.list,
          child: WorkspaceGate(
            builder: (context, workspaceId) => MultiBlocProvider(
              // A new workspace is a new list, not a refresh of the old one.
              key: ValueKey(workspaceId),
              providers: [
                BlocProvider(
                  create: (_) =>
                      getIt<LibraryBloc>()..add(LibraryStarted(workspaceId)),
                ),
                BlocProvider(
                  create: (_) {
                    final folders = getIt<FoldersCubit>();
                    unawaited(folders.load(workspaceId));
                    return folders;
                  },
                ),
                // Lazy: notes are fetched the first time their tab opens.
                BlocProvider(
                  create: (_) {
                    final notes = getIt<NotesCubit>();
                    unawaited(notes.load(workspaceId));
                    return notes;
                  },
                ),
              ],
              child: const _FilesBody(),
            ),
          ),
        ),
      ),
    );
  }
}

class _FilesBody extends StatefulWidget {
  const _FilesBody();

  @override
  State<_FilesBody> createState() => _FilesBodyState();
}

class _FilesBodyState extends State<_FilesBody> {
  FilesTab _tab = FilesTab.all;
  bool _searching = false;
  final TextEditingController _query = TextEditingController();

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  void _select(FilesTab tab) {
    if (tab == _tab) return;
    setState(() => _tab = tab);
    final source = tab.source;
    if (source == null) {
      context.read<NotesCubit>().setQuery(_query.text);
      return;
    }
    final library = context.read<LibraryBloc>();
    if (library.state.source != source) {
      library.add(LibrarySourceSelected(source));
    }
    library.add(LibraryQueryChanged(_query.text));
  }

  void _search(String text) {
    if (_tab == FilesTab.notes) {
      context.read<NotesCubit>().setQuery(text);
    } else {
      context.read<LibraryBloc>().add(LibraryQueryChanged(text));
    }
  }

  void _toggleSearch() {
    setState(() => _searching = !_searching);
    if (!_searching && _query.text.isNotEmpty) {
      _query.clear();
      _search('');
    }
  }

  Future<void> _menu(bool canWrite) async {
    final choice = await showAppSheet<_Menu>(
      context,
      builder: (_) => _FilesMenuSheet(canWrite: canWrite),
    );
    if (!mounted) return;
    switch (choice) {
      case _Menu.files:
        _select(FilesTab.all);
      case _Menu.createFolder:
        await FolderNameDialog.show(context);
      case _Menu.workspaces:
        await showWorkspaceSwitcher(context);
      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final canWrite = context.select<AccountCubit, bool>(
      (c) => c.state.account?.currentWorkspace?.role.canWrite ?? false,
    );
    final notes = _tab == FilesTab.notes;
    return BlocListener<FoldersCubit, FoldersState>(
      // The open folder was deleted (here or elsewhere): back to every file.
      listenWhen: (prev, next) => prev.folders != next.folders,
      listener: (context, state) {
        final bloc = context.read<LibraryBloc>();
        final open = bloc.state.folderId;
        if (open != null && !state.folders.any((f) => f.id == open)) {
          bloc.add(const LibraryFolderSelected(null));
        }
      },
      child: Column(
        children: [
          _Header(
            searching: _searching,
            query: _query,
            onSearch: _search,
            onToggleSearch: _toggleSearch,
            onMenu: () => _menu(canWrite),
          ),
          SourceTabs(selected: _tab, onSelected: _select),
          if (!notes) ...[
            _FolderRow(canWrite: canWrite),
            const TagFilterBar(),
          ],
          Expanded(
            child: notes
                ? const NotesList()
                : _FilesList(tab: _tab, canWrite: canWrite),
          ),
        ],
      ),
    );
  }
}

/// «Fayllar ⌄» (the menu) and the search toggle; while searching, the
/// field takes the title's place.
class _Header extends StatelessWidget {
  const _Header({
    required this.searching,
    required this.query,
    required this.onSearch,
    required this.onToggleSearch,
    required this.onMenu,
  });

  final bool searching;
  final TextEditingController query;
  final ValueChanged<String> onSearch;
  final VoidCallback onToggleSearch;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final workspace = context.select<AccountCubit, String>(
      (c) => c.state.account?.currentWorkspace?.name ?? '',
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 8, 4),
      child: Row(
        children: [
          Expanded(
            child: searching
                ? TextField(
                    key: const Key('files_search_field'),
                    controller: query,
                    autofocus: true,
                    onChanged: onSearch,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: l10n.filesSearchHint,
                      prefixIcon: const Icon(Icons.search_rounded),
                      isDense: true,
                    ),
                  )
                : InkWell(
                    key: const Key('files_menu'),
                    onTap: onMenu,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                l10n.filesTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppText.display,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.expand_more_rounded,
                              color: AppColors.mutedDark,
                            ),
                          ],
                        ),
                        if (workspace.isNotEmpty)
                          Text(
                            workspace,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.caption,
                          ),
                      ],
                    ),
                  ),
          ),
          IconButton(
            key: const Key('files_search'),
            tooltip: searching ? l10n.filesSearchClose : l10n.filesSearch,
            icon: Icon(searching ? Icons.close_rounded : Icons.search_rounded),
            onPressed: onToggleSearch,
          ),
        ],
      ),
    );
  }
}

enum _Menu { files, createFolder, workspaces }

class _FilesMenuSheet extends StatelessWidget {
  const _FilesMenuSheet({required this.canWrite});

  final bool canWrite;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppSheet(
      child: ActionGroup(
        children: [
          ActionRow(
            key: const Key('files_menu_files'),
            icon: Icons.folder_outlined,
            label: l10n.filesTitle,
            trailing: const Icon(
              Icons.check_rounded,
              size: 18,
              color: AppColors.accent,
            ),
            onTap: () => Navigator.of(context).pop(_Menu.files),
          ),
          if (canWrite)
            ActionRow(
              key: const Key('files_menu_folder'),
              icon: Icons.create_new_folder_outlined,
              label: l10n.filesMenuCreateFolder,
              showChevron: false,
              onTap: () => Navigator.of(context).pop(_Menu.createFolder),
            ),
          ActionRow(
            key: const Key('files_menu_workspaces'),
            icon: Icons.workspaces_outline,
            label: l10n.filesMenuWorkspaces,
            onTap: () => Navigator.of(context).pop(_Menu.workspaces),
          ),
        ],
      ),
    );
  }
}

/// Folders show once there is something to sort: a folder, or a file and
/// the right to make one.
class _FolderRow extends StatelessWidget {
  const _FolderRow({required this.canWrite});

  final bool canWrite;

  @override
  Widget build(BuildContext context) {
    final hasFolders = context.select<FoldersCubit, bool>(
      (c) => c.state.folders.isNotEmpty,
    );
    final hasFiles = context.select<LibraryBloc, bool>(
      (b) => b.state.status != LibraryStatus.empty || b.state.folderId != null,
    );
    return hasFolders || (hasFiles && canWrite)
        ? FolderBar(canWrite: canWrite)
        : const SizedBox.shrink();
  }
}

class _FilesList extends StatelessWidget {
  const _FilesList({required this.tab, required this.canWrite});

  final FilesTab tab;
  final bool canWrite;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LibraryBloc, LibraryState>(
      // A failed refresh keeps the rows; say so without replacing them.
      listenWhen: (prev, next) =>
          next.failure != null &&
          prev.failure != next.failure &&
          next.items.isNotEmpty,
      listener: (context, state) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.failure!.message(context.l10n))),
      ),
      buildWhen: (prev, next) =>
          prev.status != next.status ||
          prev.items != next.items ||
          prev.tag != next.tag ||
          prev.query != next.query,
      builder: (context, state) {
        final bloc = context.read<LibraryBloc>();
        final items = state.visibleItems;
        // Reloads the folder bar too: it changes on other devices as well.
        Future<void> refresh() async {
          unawaited(context.read<FoldersCubit>().refresh());
          bloc.add(const LibraryRefreshed());
          await bloc.stream.firstWhere((s) => !s.refreshing);
        }

        return switch (state.status) {
          LibraryStatus.initial ||
          LibraryStatus.loading => const AppLoadingView(),
          LibraryStatus.failure => AppErrorView(
            failure: state.failure!,
            onRetry: () => bloc.add(const LibraryRefreshed()),
          ),
          LibraryStatus.empty when state.folderId != null => RefreshIndicator(
            onRefresh: refresh,
            child: const _EmptyFolderView(),
          ),
          LibraryStatus.empty => RefreshIndicator(
            onRefresh: refresh,
            child: FilesEmptyView(tab: tab, canWrite: canWrite),
          ),
          LibraryStatus.success when items.isEmpty => RefreshIndicator(
            onRefresh: refresh,
            child: const FilesNoMatchView(),
          ),
          LibraryStatus.success => RefreshIndicator(
            onRefresh: refresh,
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 20, right: 8),
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, i) => LibraryTile(
                item: items[i],
                onMore: FileActionsSheet.hasActions(canWrite: canWrite)
                    ? () => FileActionsSheet.show(context, items[i])
                    : null,
              ),
            ),
          ),
        };
      },
    );
  }
}

class _EmptyFolderView extends StatelessWidget {
  const _EmptyFolderView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // A list, so the empty folder can be pulled to refresh as well.
    return ListView(
      padding: const EdgeInsets.fromLTRB(32, 72, 32, 32),
      children: [
        Text(
          l10n.filesFolderEmpty,
          textAlign: TextAlign.center,
          style: AppText.title,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.filesFolderEmptyHint,
          textAlign: TextAlign.center,
          style: AppText.muted,
        ),
      ],
    );
  }
}

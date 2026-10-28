import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_loading_view.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';
import 'package:transkriptor_uz/features/library/application/folders_cubit.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/empty_library_view.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/file_actions_sheet.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/folder_bar.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/library_tile.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/tag_filter_bar.dart';

class FilesPage extends StatelessWidget {
  const FilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.filesTitle, style: AppText.title),
        centerTitle: false,
      ),
      body: WorkspaceGate(
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
          ],
          child: const _FilesBody(),
        ),
      ),
    );
  }
}

class _FilesBody extends StatelessWidget {
  const _FilesBody();

  @override
  Widget build(BuildContext context) {
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
          BlocSelector<FoldersCubit, FoldersState, bool>(
            selector: (s) => s.folders.isNotEmpty,
            builder: (context, hasFolders) =>
                BlocSelector<LibraryBloc, LibraryState, bool>(
                  // An empty library without folders keeps its welcome.
                  selector: (s) =>
                      s.status != LibraryStatus.empty || s.folderId != null,
                  builder: (context, hasFiles) => hasFolders || hasFiles
                      ? const FolderBar()
                      : const SizedBox.shrink(),
                ),
          ),
          const TagFilterBar(),
          const Expanded(child: _FilesList()),
        ],
      ),
    );
  }
}

class _FilesList extends StatelessWidget {
  const _FilesList();

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
          prev.tag != next.tag,
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
          LibraryStatus.empty => const EmptyLibraryView(),
          LibraryStatus.success => RefreshIndicator(
            onRefresh: refresh,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (_, i) => LibraryTile(
                item: items[i],
                onLongPress: () => FileActionsSheet.show(context, items[i]),
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
      padding: const EdgeInsets.fromLTRB(32, 96, 32, 32),
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

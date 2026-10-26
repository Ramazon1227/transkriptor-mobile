import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_loading_view.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/empty_library_view.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/library_tile.dart';

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
        builder: (context, workspaceId) => BlocProvider(
          // A new workspace is a new list, not a refresh of the old one.
          key: ValueKey(workspaceId),
          create: (_) => getIt<LibraryBloc>()..add(LibraryStarted(workspaceId)),
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
          prev.status != next.status || prev.items != next.items,
      builder: (context, state) {
        final bloc = context.read<LibraryBloc>();
        return switch (state.status) {
          LibraryStatus.initial ||
          LibraryStatus.loading => const AppLoadingView(),
          LibraryStatus.failure => AppErrorView(
            failure: state.failure!,
            onRetry: () => bloc.add(const LibraryRefreshed()),
          ),
          LibraryStatus.empty => const EmptyLibraryView(),
          LibraryStatus.success => RefreshIndicator(
            onRefresh: () async {
              bloc.add(const LibraryRefreshed());
              await bloc.stream.firstWhere((s) => !s.refreshing);
            },
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: state.items.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (_, i) => LibraryTile(item: state.items[i]),
            ),
          ),
        };
      },
    );
  }
}

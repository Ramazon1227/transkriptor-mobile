import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/app_mark.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/balance_pill.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';
import 'package:transkriptor_uz/features/home/presentation/widgets/entry_cards.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/library/presentation/widgets/library_tile.dart';
import 'package:transkriptor_uz/features/upload/application/pick_file_cubit.dart';

/// How many files the home screen previews.
const int _recentCount = 3;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PickFileCubit>(),
      child: Scaffold(
        body: ContentWidth(
          maxWidth: ContentWidth.list,
          child: SafeArea(
            child: WorkspaceGate(
              builder: (context, workspaceId) => BlocProvider(
                key: ValueKey(workspaceId),
                create: (_) =>
                    getIt<LibraryBloc>()..add(LibraryStarted(workspaceId)),
                child: const _HomeBody(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final name = context.select<AccountCubit, String>(
      (c) => c.state.account?.user.fullName.trim() ?? '',
    );
    final firstName = name.split(' ').first;

    return BlocListener<PickFileCubit, PickFileState>(
      listener: (context, state) {
        final file = state.file;
        if (state.status == PickFileStatus.picked && file != null) {
          context.read<PickFileCubit>().consumed();
          unawaited(context.push(Routes.send, extra: file));
        } else if (state.status == PickFileStatus.failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.failure!.message(l10n))));
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          final library = context.read<LibraryBloc>()
            ..add(const LibraryRefreshed());
          await Future.wait([
            context.read<AccountCubit>().load(),
            library.stream.firstWhere((s) => !s.refreshing),
          ]);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            const Row(children: [AppMark(), Spacer(), BalancePill()]),
            const SizedBox(height: 22),
            Text(
              firstName.isEmpty
                  ? l10n.homeGreetingNoName
                  : l10n.homeGreeting(firstName),
              style: AppText.display,
            ),
            const SizedBox(height: 6),
            Text(
              l10n.homeSubtitle,
              style: AppText.muted.copyWith(fontSize: 15),
            ),
            const SizedBox(height: 20),
            const EntryCards(),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.homeRecent.toUpperCase(),
                    style: AppText.label,
                  ),
                ),
                TextButton(
                  onPressed: () => context.go(Routes.files),
                  child: Text(l10n.homeSeeAll),
                ),
              ],
            ),
            const _RecentFiles(),
          ],
        ),
      ),
    );
  }
}

class _RecentFiles extends StatelessWidget {
  const _RecentFiles();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      buildWhen: (prev, next) =>
          prev.status != next.status || prev.items != next.items,
      builder: (context, state) {
        final l10n = context.l10n;
        return switch (state.status) {
          LibraryStatus.initial || LibraryStatus.loading => const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          ),
          // The home screen still works without the list; keep it short.
          LibraryStatus.failure => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(state.failure!.message(l10n), style: AppText.muted),
          ),
          LibraryStatus.empty => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(l10n.filesEmptyTitle, style: AppText.muted),
          ),
          LibraryStatus.success => Column(
            children: [
              for (final item in state.items.take(_recentCount)) ...[
                LibraryTile(item: item, showTags: false),
                const Divider(color: AppColors.sf2),
              ],
            ],
          ),
        };
      },
    );
  }
}

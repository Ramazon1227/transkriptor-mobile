import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/app_mark.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/core/widgets/illustrated_card.dart';
import 'package:transkriptor_uz/core/widgets/section_header.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/balance_pill.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';
import 'package:transkriptor_uz/features/calendar/application/calendar_cubit.dart';
import 'package:transkriptor_uz/features/calendar/presentation/widgets/calendar_section.dart';
import 'package:transkriptor_uz/features/home/presentation/widgets/capture_actions.dart';
import 'package:transkriptor_uz/features/home/presentation/widgets/recent_files.dart';
import 'package:transkriptor_uz/features/library/application/library_bloc.dart';
import 'package:transkriptor_uz/features/upload/application/pick_file_cubit.dart';
import 'package:transkriptor_uz/features/workspace/presentation/widgets/workspace_chip.dart';

/// Studio: the home tab. The shell above it provides the file picker.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // The calendar belongs to the person, not the workspace: it is not
      // rebuilt when the workspace changes.
      create: (_) {
        final cubit = getIt<CalendarCubit>();
        unawaited(cubit.load());
        return cubit;
      },
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

  Future<void> _refresh(BuildContext context) async {
    final library = context.read<LibraryBloc>()..add(const LibraryRefreshed());
    await Future.wait([
      context.read<AccountCubit>().load(),
      context.read<CalendarCubit>().load(),
      library.stream.firstWhere((s) => !s.refreshing),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final name = context.select<AccountCubit, String>(
      (c) => c.state.account?.user.fullName.trim() ?? '',
    );
    final firstName = name.split(' ').first;

    return RefreshIndicator(
      onRefresh: () => _refresh(context),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Row(
            children: [
              const AppMark(),
              const SizedBox(width: 12),
              const Flexible(child: WorkspaceChip()),
              const Spacer(),
              IconButton(
                tooltip: l10n.settingsTitle,
                icon: const Icon(Icons.settings_outlined),
                onPressed: () => context.push(Routes.settings),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            firstName.isEmpty
                ? l10n.homeWelcomeNoName
                : l10n.homeWelcome(firstName),
            style: AppText.display,
          ),
          const SizedBox(height: 12),
          const Align(alignment: Alignment.centerLeft, child: BalancePill()),
          const SizedBox(height: 24),
          SectionHeader(title: l10n.sourceSheetTitle),
          const SizedBox(height: 8),
          const _StartGrid(),
          const SizedBox(height: 24),
          SectionHeader(
            title: l10n.homeRecent,
            actionLabel: l10n.homeSeeAll,
            onAction: () => context.go(Routes.files),
          ),
          const SizedBox(height: 4),
          const RecentFiles(),
          const SizedBox(height: 24),
          const CalendarSection(),
        ],
      ),
    );
  }
}

/// «Boshlash»: the four most common ways in, two by two.
class _StartGrid extends StatelessWidget {
  const _StartGrid();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final picking = context.select<PickFileCubit, bool>(
      (c) => c.state.status == PickFileStatus.picking,
    );
    Widget card(CaptureSource source, String title, {bool busy = false}) =>
        Expanded(
          child: IllustratedCard(
            source: source,
            title: title,
            busy: busy,
            onTap: () => startCapture(context, source),
          ),
        );
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              card(CaptureSource.upload, l10n.sourceUploadTitle, busy: picking),
              const SizedBox(width: 10),
              card(CaptureSource.youtube, l10n.sourceYoutubeTitle),
            ],
          ),
        ),
        const SizedBox(height: 10),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              card(CaptureSource.recording, l10n.homeCardRecord),
              const SizedBox(width: 10),
              card(CaptureSource.meeting, l10n.sourceMeetingTitle),
            ],
          ),
        ),
      ],
    );
  }
}

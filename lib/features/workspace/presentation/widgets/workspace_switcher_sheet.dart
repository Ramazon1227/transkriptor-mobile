import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/workspace/application/workspace_list_cubit.dart';
import 'package:transkriptor_uz/features/workspace/presentation/widgets/workspace_role_label.dart';

/// Opens the switcher. Picking a workspace switches the whole app to it:
/// library, upload and folders all sit behind `WorkspaceGate`.
Future<void> showWorkspaceSwitcher(BuildContext context) {
  final account = context.read<AccountCubit>();
  return showAppSheet<void>(
    context,
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: account),
        BlocProvider(
          create: (_) {
            final cubit = getIt<WorkspaceListCubit>();
            unawaited(cubit.load());
            return cubit;
          },
        ),
      ],
      child: const WorkspaceSwitcherSheet(),
    ),
  );
}

class WorkspaceSwitcherSheet extends StatelessWidget {
  const WorkspaceSwitcherSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final currentId = context.select<AccountCubit, String?>(
      (c) => c.state.account?.currentWorkspace?.id,
    );
    return AppSheet(
      title: l10n.workspaceSwitchTitle,
      child: BlocBuilder<WorkspaceListCubit, WorkspaceListState>(
        builder: (context, state) => switch (state.status) {
          WorkspaceListStatus.initial ||
          WorkspaceListStatus.loading => const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          ),
          WorkspaceListStatus.failure => AppErrorView(
            failure: state.failure!,
            onRetry: () => context.read<WorkspaceListCubit>().load(),
          ),
          // Every account has a personal workspace; an empty list is a
          // server oddity, shown as nothing rather than an error.
          WorkspaceListStatus.empty => const SizedBox.shrink(),
          WorkspaceListStatus.success => Column(
            children: [
              for (final w in state.items)
                _WorkspaceRow(
                  workspace: w,
                  current: w.id == currentId,
                  onTap: () {
                    unawaited(
                      context.read<AccountCubit>().selectWorkspace(w.id),
                    );
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        },
      ),
    );
  }
}

class _WorkspaceRow extends StatelessWidget {
  const _WorkspaceRow({
    required this.workspace,
    required this.current,
    required this.onTap,
  });

  final Workspace workspace;
  final bool current;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final details = [
      if (workspace.isPersonal) l10n.workspacePersonal,
      ?workspace.role.label(l10n),
    ].join(' · ');
    return Semantics(
      selected: current,
      button: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.segment),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
          // The current one carries the left-edge bar, never a fill.
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: current ? AppColors.accent : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                workspace.isPersonal
                    ? Icons.person_outline_rounded
                    : Icons.groups_outlined,
                color: AppColors.mutedDark,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workspace.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.bodyMedium,
                    ),
                    if (details.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(details, style: AppText.caption),
                    ],
                  ],
                ),
              ),
              if (current) ...[
                const SizedBox(width: 8),
                const Icon(Icons.check_rounded, color: AppColors.accent),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

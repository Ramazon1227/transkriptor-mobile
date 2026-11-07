import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_loading_view.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';

/// Builds [builder] once the account knows its workspace, so screens can
/// hand the id to their own blocs.
class WorkspaceGate extends StatelessWidget {
  const WorkspaceGate({required this.builder, super.key});

  final Widget Function(BuildContext context, String workspaceId) builder;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AccountCubit>().state;
    final workspaceId = state.account?.currentWorkspace?.id;
    if (workspaceId != null) return builder(context, workspaceId);
    if (state.status == AccountStatus.failure) {
      return AppErrorView(
        failure: state.failure ?? const Failure.unknown(),
        onRetry: () => context.read<AccountCubit>().load(),
      );
    }
    // No workspace left (W-4: before the server refused it, a founder could
    // be removed from their own one): a way out, not an endless spinner.
    // After the failure check, so a failed retry still shows its error.
    if (state.account != null && state.account!.workspaces.isEmpty) {
      return const _NoWorkspace();
    }
    return const AppLoadingView();
  }
}

class _NoWorkspace extends StatelessWidget {
  const _NoWorkspace();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final account = context.read<AccountCubit>();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.noWorkspaceTitle,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(l10n.noWorkspaceBody, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: account.load, child: Text(l10n.retry)),
            const SizedBox(height: 8),
            TextButton(
              onPressed: account.logout,
              child: Text(l10n.profileLogout),
            ),
          ],
        ),
      ),
    );
  }
}

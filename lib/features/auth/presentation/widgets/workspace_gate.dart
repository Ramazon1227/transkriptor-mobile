import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
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
    return const AppLoadingView();
  }
}

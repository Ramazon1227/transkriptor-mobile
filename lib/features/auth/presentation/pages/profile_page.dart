import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final l10n = context.l10n;
    final cubit = context.read<AccountCubit>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.profileLogoutTitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.profileLogout),
          ),
        ],
      ),
    );
    // The session expiry the logout raises takes the router to login.
    if (ok ?? false) await cubit.logout();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileTitle, style: AppText.title),
        centerTitle: false,
      ),
      body: WorkspaceGate(
        builder: (context, _) {
          final account = context.select<AccountCubit, Account?>(
            (c) => c.state.account,
          );
          if (account == null) return const SizedBox.shrink();
          return RefreshIndicator(
            onRefresh: () => context.read<AccountCubit>().load(),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              children: [
                _UserRow(user: account.user),
                const SizedBox(height: 20),
                _BalanceCard(workspace: account.currentWorkspace!),
                const SizedBox(height: 24),
                Text(l10n.profileWorkspace.toUpperCase(), style: AppText.label),
                for (final w in account.workspaces)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(w.name),
                    trailing: Text(
                      l10n.minutesShort(
                        Formatters.minutesLeft(w.balanceSeconds),
                      ),
                      style: AppText.mono,
                    ),
                  ),
                const SizedBox(height: 16),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.logout_rounded),
                  title: Text(l10n.profileLogout),
                  onTap: () => _confirmLogout(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _UserRow extends StatelessWidget {
  const _UserRow({required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final name = user.fullName.trim();
    final initials = name.isEmpty
        ? user.email.characters.first.toUpperCase()
        : name
              .split(RegExp(r'\s+'))
              .take(2)
              .map((p) => p.characters.first.toUpperCase())
              .join();
    return Row(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: AppColors.sf2,
          child: Text(
            initials,
            style: const TextStyle(
              color: AppColors.cotton,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (name.isNotEmpty)
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              Text(user.email, style: AppText.muted),
            ],
          ),
        ),
      ],
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.workspace});

  final Workspace workspace;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.balanceLabel.toUpperCase(), style: AppText.label),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${Formatters.minutesLeft(workspace.balanceSeconds)}',
                style: AppText.mono.copyWith(
                  fontSize: 36,
                  color: AppColors.cotton,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Text(l10n.profileMinutesLeft, style: AppText.muted),
            ],
          ),
          const SizedBox(height: 6),
          Text(workspace.name, style: AppText.muted),
        ],
      ),
    );
  }
}

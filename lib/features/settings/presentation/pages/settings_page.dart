import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/constants/app_info.dart';
import 'package:transkriptor_uz/core/constants/public_links.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/action_row.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/core/widgets/initials_avatar.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';
import 'package:transkriptor_uz/features/billing/application/balance_cubit.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';
import 'package:transkriptor_uz/features/links/presentation/open_link.dart';
import 'package:transkriptor_uz/features/push/application/push_cubit.dart';
import 'package:transkriptor_uz/features/settings/presentation/widgets/delete_account_sheet.dart';
import 'package:transkriptor_uz/features/settings/presentation/widgets/logout_sheet.dart';
import 'package:transkriptor_uz/features/workspace/presentation/widgets/workspace_role_label.dart';
import 'package:transkriptor_uz/features/workspace/presentation/widgets/workspace_switcher_sheet.dart';

/// Settings, above the shell. The app is dark by design: there is no
/// theme toggle here on purpose.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settingsTitle)),
      body: ContentWidth(
        child: WorkspaceGate(
          // The balance belongs to the current workspace; a switch is a
          // new cubit, not a reload of the old one.
          builder: (context, workspaceId) => BlocProvider(
            key: ValueKey(workspaceId),
            create: (_) {
              final cubit = getIt<BalanceCubit>();
              unawaited(cubit.load(workspaceId));
              return cubit;
            },
            child: const _SettingsBody(),
          ),
        ),
      ),
    );
  }
}

class _SettingsBody extends StatelessWidget {
  const _SettingsBody();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final account = context.select<AccountCubit, Account?>(
      (c) => c.state.account,
    );
    final workspace = account?.currentWorkspace;
    if (account == null || workspace == null) return const SizedBox.shrink();
    final version = AppInfo.version;

    return RefreshIndicator(
      onRefresh: () async {
        final balance = context.read<BalanceCubit>();
        await Future.wait([
          context.read<AccountCubit>().load(),
          balance.load(workspace.id),
        ]);
      },
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _Header(user: account.user),
          const SizedBox(height: 24),
          ActionGroup(
            title: l10n.settingsAccount,
            children: [
              _BalanceRow(fallbackSeconds: workspace.balanceSeconds),
              const _PlanRow(),
              ActionRow(
                icon: Icons.workspace_premium_outlined,
                label: l10n.settingsPlans,
                onTap: () => context.push(Routes.plans),
              ),
              ActionRow(
                icon: Icons.person_outline_rounded,
                label: l10n.settingsProfile,
                onTap: () => context.push(Routes.settingsProfile),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ActionGroup(
            title: l10n.settingsWorkspace,
            children: [
              ActionRow(
                icon: workspace.isPersonal
                    ? Icons.person_outline_rounded
                    : Icons.groups_outlined,
                label: workspace.name,
                subtitle: workspace.role.label(l10n),
                onTap: () => showWorkspaceSwitcher(context),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ActionGroup(
            title: l10n.settingsApp,
            children: [
              // One locale exists; it is shown, not offered.
              ActionRow(
                icon: Icons.translate_rounded,
                label: l10n.settingsLanguage,
                value: l10n.settingsLanguageUzbek,
              ),
              const _NotificationsRow(),
            ],
          ),
          const SizedBox(height: 20),
          ActionGroup(
            title: l10n.settingsHelp,
            children: [
              _LinkRow(
                icon: Icons.help_outline_rounded,
                label: l10n.settingsHelpCenter,
                url: PublicLinks.help,
              ),
              _LinkRow(
                icon: Icons.bug_report_outlined,
                label: l10n.settingsReportBug,
                url: PublicLinks.bugReport,
              ),
              _LinkRow(
                icon: Icons.shield_outlined,
                label: l10n.settingsPrivacy,
                url: PublicLinks.privacy,
              ),
              _LinkRow(
                icon: Icons.description_outlined,
                label: l10n.settingsTerms,
                url: PublicLinks.terms,
              ),
              if (version.isNotEmpty)
                ActionRow(
                  icon: Icons.info_outline_rounded,
                  label: l10n.settingsVersion,
                  value: version,
                ),
            ],
          ),
          const SizedBox(height: 20),
          ActionGroup(
            children: [
              ActionRow(
                icon: Icons.logout_rounded,
                label: l10n.profileLogout,
                showChevron: false,
                onTap: () => showLogoutSheet(context),
              ),
              ActionRow(
                icon: Icons.delete_forever_outlined,
                label: l10n.settingsDeleteAccount,
                destructive: true,
                showChevron: false,
                onTap: () => showDeleteAccountSheet(context, account.user),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final name = user.fullName.trim();
    final plan = context.select<BalanceCubit, Plan?>(
      (c) => c.state.balance?.plan,
    );
    return Column(
      children: [
        InitialsAvatar(name: name, fallback: user.email, radius: 36),
        // A paid plan shows as a badge under the avatar.
        if (plan != null && !plan.isFree && plan.name.isNotEmpty) ...[
          const SizedBox(height: 8),
          _PlanBadge(plan.name),
        ],
        const SizedBox(height: 12),
        if (name.isNotEmpty)
          Text(name, textAlign: TextAlign.center, style: AppText.heading),
        const SizedBox(height: 2),
        Text(user.email, textAlign: TextAlign.center, style: AppText.caption),
      ],
    );
  }
}

class _PlanBadge extends StatelessWidget {
  const _PlanBadge(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(color: AppColors.accent),
      ),
      child: Text(
        name.toUpperCase(),
        style: AppText.label.copyWith(color: AppColors.accent),
      ),
    );
  }
}

class _BalanceRow extends StatelessWidget {
  const _BalanceRow({required this.fallbackSeconds});

  /// From `GET /me`, shown until the balance call answers.
  final int fallbackSeconds;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final seconds = context.select<BalanceCubit, int>(
      (c) => c.state.balance?.balanceSeconds ?? fallbackSeconds,
    );
    return ActionRow(
      icon: Icons.timer_outlined,
      label: l10n.settingsBalance,
      value: l10n.minutesShort(Formatters.minutesLeft(seconds)),
    );
  }
}

class _PlanRow extends StatelessWidget {
  const _PlanRow();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final balance = context.select<BalanceCubit, Balance?>(
      (c) => c.state.balance,
    );
    final plan = balance?.plan;
    if (balance == null || plan == null) {
      return ActionRow(
        icon: Icons.receipt_long_outlined,
        label: l10n.settingsPlan,
      );
    }
    final status = _status(l10n, balance.status);
    final end = balance.periodEnd;
    final period = end == null || balance.status != SubscriptionStatus.active
        ? null
        : balance.cancelAtPeriodEnd
        ? l10n.planEnds(Formatters.date(end))
        : l10n.planRenews(Formatters.date(end));
    return ActionRow(
      icon: Icons.receipt_long_outlined,
      label: l10n.settingsPlan,
      subtitle: period,
      value: [plan.name, ?status].join(' · '),
    );
  }

  static String? _status(AppLocalizations l10n, SubscriptionStatus s) =>
      switch (s) {
        SubscriptionStatus.active => l10n.planStatusActive,
        SubscriptionStatus.pastDue => l10n.planStatusPastDue,
        SubscriptionStatus.cancelled => l10n.planStatusCancelled,
        SubscriptionStatus.expired => l10n.planStatusExpired,
        SubscriptionStatus.none || SubscriptionStatus.unknown => null,
      };
}

class _NotificationsRow extends StatelessWidget {
  const _NotificationsRow();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final available = context.select<PushCubit, bool>((c) => c.state.available);
    return ActionRow(
      icon: Icons.notifications_none_rounded,
      label: l10n.settingsNotifications,
      value: available
          ? l10n.settingsNotificationsOn
          : l10n.settingsNotificationsOff,
    );
  }
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({required this.icon, required this.label, this.url});

  final IconData icon;
  final String label;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return ActionRow(
      icon: icon,
      label: label,
      value: url == null ? context.l10n.comingSoon : null,
      // Leaves the app: the «open outside» mark instead of a chevron.
      trailing: url == null
          ? null
          : const Icon(
              Icons.open_in_new_rounded,
              size: 18,
              color: AppColors.mutedDark,
            ),
      showChevron: false,
      // Opens in the browser; copied with a SnackBar when nothing opens it.
      onTap: () => openLinkOrCopy(context, url),
    );
  }
}

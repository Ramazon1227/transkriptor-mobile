import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/app_empty_view.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_loading_view.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/billing/application/plans_cubit.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';

/// Settings › Tariflar: the real plan list. Buying is not possible in the
/// app yet (the payment provider is not chosen), so the button says so.
class PlansPage extends StatelessWidget {
  const PlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<PlansCubit>();
        unawaited(cubit.load());
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.plansTitle)),
        body: const ContentWidth(child: _PlansBody()),
      ),
    );
  }
}

class _PlansBody extends StatelessWidget {
  const _PlansBody();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final currentCode = context.select<AccountCubit, String>(
      (c) => c.state.account?.currentWorkspace?.planCode ?? '',
    );
    return BlocBuilder<PlansCubit, PlansState>(
      builder: (context, state) => switch (state.status) {
        PlansStatus.initial || PlansStatus.loading => const AppLoadingView(),
        PlansStatus.failure => AppErrorView(
          failure: state.failure!,
          onRetry: () => context.read<PlansCubit>().load(),
        ),
        PlansStatus.empty => AppEmptyView(message: l10n.plansEmpty),
        PlansStatus.success => ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            for (final plan in state.plans) ...[
              _PlanCard(plan: plan, current: plan.code == currentCode),
              const SizedBox(height: 12),
            ],
            Text(
              l10n.plansPaymentSoon,
              textAlign: TextAlign.center,
              style: AppText.caption,
            ),
          ],
        ),
      },
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan, required this.current});

  final Plan plan;
  final bool current;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
        // The current plan carries the left-edge bar.
        border: Border(
          left: BorderSide(
            color: current ? AppColors.accent : AppColors.sf1,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(plan.name, style: AppText.title),
              if (current)
                Text(
                  l10n.planCurrent.toUpperCase(),
                  style: AppText.label.copyWith(color: AppColors.accent),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            plan.isFree
                ? l10n.planFree
                : l10n.planPrice(Formatters.money(plan.priceUzs)),
            style: AppText.heading,
          ),
          const SizedBox(height: 10),
          Text(
            l10n.planMinutesPerMonth(
              Formatters.minutesLeft(plan.monthlySeconds),
            ),
            style: AppText.body,
          ),
          if (plan.maxMembers > 1)
            Text(l10n.planMembers(plan.maxMembers), style: AppText.caption),
          if (!plan.isFree && !current) ...[
            const SizedBox(height: 14),
            // Payments are not decided yet (Payme / Click / Uzum).
            OutlinedButton(onPressed: null, child: Text(l10n.comingSoon)),
          ],
        ],
      ),
    );
  }
}

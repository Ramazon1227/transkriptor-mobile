import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/features/billing/application/quota_warning_cubit.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';

/// The closable 95 % minute warning (B-18): minutes left and when they
/// come back. Coral left-edge bar — needs attention, like the demo banner.
class QuotaBanner extends StatelessWidget {
  const QuotaBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuotaWarningCubit>().state;
    final balance = state.balance;
    if (!state.banner || balance == null) return const SizedBox.shrink();
    final l10n = context.l10n;
    final renewal = _renewal(context, balance);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Semantics(
        container: true,
        liveRegion: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 6, 4, 6),
          decoration: BoxDecoration(
            color: AppColors.sf1,
            borderRadius: BorderRadius.circular(AppRadii.segment),
            border: const Border(
              left: BorderSide(color: AppColors.warn, width: 3),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.hourglass_bottom_rounded,
                size: 18,
                color: AppColors.warn,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.quotaWarnTitle(
                        Formatters.minutesLeft(balance.balanceSeconds),
                      ),
                      style: AppText.bodyStrong.copyWith(
                        color: AppColors.cotton,
                      ),
                    ),
                    if (renewal != null) Text(renewal, style: AppText.caption),
                    TextButton(
                      onPressed: () => context.push(Routes.plans),
                      child: Text(l10n.quotaSeePlans),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: l10n.quotaClose,
                icon: const Icon(Icons.close, size: 18),
                onPressed: () => context.read<QuotaWarningCubit>().dismiss(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// When the minutes come back, or why they do not.
  String? _renewal(BuildContext context, Balance b) {
    final l10n = context.l10n;
    final end = b.periodEnd;
    final subscribed =
        b.status != SubscriptionStatus.none &&
        b.status != SubscriptionStatus.unknown;
    if (subscribed && end != null) {
      final day = Formatters.date(end);
      return b.cancelAtPeriodEnd ? l10n.quotaEnds(day) : l10n.quotaRenews(day);
    }
    return b.plan?.isFree ?? false ? l10n.quotaFreeOnce : null;
  }
}

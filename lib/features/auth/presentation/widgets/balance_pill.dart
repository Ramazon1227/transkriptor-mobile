import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';

/// Minutes are the currency, so the balance is always in view.
class BalancePill extends StatelessWidget {
  const BalancePill({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final seconds = context.select<AccountCubit, int?>(
      (c) => c.state.account?.currentWorkspace?.balanceSeconds,
    );
    if (seconds == null) return const SizedBox.shrink();
    return Material(
      color: AppColors.sf1,
      borderRadius: BorderRadius.circular(7),
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () => context.push(Routes.settings),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.balanceLabel.toUpperCase(), style: AppText.label),
                const SizedBox(width: 8),
                Text(
                  l10n.minutesShort(Formatters.minutesLeft(seconds)),
                  style: AppText.mono.copyWith(
                    color: AppColors.cotton,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontVariations: const [FontVariation('wght', 500)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

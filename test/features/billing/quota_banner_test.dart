import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' show Right;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations_uz.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/balance_pill.dart';
import 'package:transkriptor_uz/features/billing/application/quota_warning_cubit.dart';
import 'package:transkriptor_uz/features/billing/domain/entities/billing.dart';
import 'package:transkriptor_uz/features/billing/domain/i_billing_facade.dart';
import 'package:transkriptor_uz/features/billing/domain/i_quota_warning_facade.dart';
import 'package:transkriptor_uz/features/billing/presentation/widgets/quota_banner.dart';

class _Account extends MockCubit<AccountState> implements AccountCubit;

class _Billing extends Mock implements IBillingFacade;

class _Store implements IQuotaWarningFacade {
  final map = <String, String>{};

  @override
  Future<String?> closedPeriod(String workspaceId) async => map[workspaceId];

  @override
  Future<void> close(String workspaceId, String period) async =>
      map[workspaceId] = period;

  @override
  Future<void> forget(String workspaceId) async => map.remove(workspaceId);
}

const _pro = Plan(code: 'pro', name: 'Pro', monthlySeconds: 36000);
const _free = Plan(code: 'free', name: 'Bepul', monthlySeconds: 1800);

void main() {
  final l10n = AppLocalizationsUz();

  Future<QuotaWarningCubit> pump(WidgetTester t, Balance b) async {
    final account = _Account();
    when(() => account.state).thenReturn(
      AccountState(
        status: AccountStatus.success,
        account: Account(
          user: const AppUser(id: 'u1', email: 'a@misol.uz'),
          workspaces: [
            Workspace(
              id: 'w1',
              name: 'Shaxsiy',
              balanceSeconds: b.balanceSeconds,
            ),
          ],
          selectedWorkspaceId: 'w1',
        ),
      ),
    );
    final billing = _Billing();
    when(() => billing.balance('w1')).thenAnswer((_) async => Right(b));
    final cubit = QuotaWarningCubit(billing, _Store());
    await cubit.load('w1', personal: true);
    await t.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<AccountCubit>.value(value: account),
          BlocProvider<QuotaWarningCubit>.value(value: cubit),
        ],
        child: MaterialApp(
          theme: AppTheme.dark(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(
            body: Column(children: [BalancePill(), QuotaBanner()]),
          ),
        ),
      ),
    );
    return cubit;
  }

  Future<void> done(WidgetTester t, QuotaWarningCubit cubit) async {
    // Unmount first: closing a cubit the widget still listens to hangs.
    await t.pumpWidget(const SizedBox.shrink());
    await cubit.close();
  }

  testWidgets('80 %: a mark on the balance, no banner', (t) async {
    final cubit = await pump(
      t,
      const Balance(balanceSeconds: 7200, plan: _pro),
    );
    expect(find.bySemanticsLabel(RegExp(l10n.quotaUsed(80))), findsOneWidget);
    expect(find.text(l10n.quotaWarnTitle(120)), findsNothing);
    await done(t, cubit);
  });

  testWidgets('95 %: minutes left and the renewal date, closable', (t) async {
    final cubit = await pump(
      t,
      Balance(
        balanceSeconds: 1200,
        plan: _pro,
        status: SubscriptionStatus.active,
        periodEnd: DateTime(2026, 12, 1, 12),
      ),
    );
    expect(find.bySemanticsLabel(RegExp(l10n.quotaUsed(95))), findsOneWidget);
    expect(find.text(l10n.quotaWarnTitle(20)), findsOneWidget);
    expect(find.text(l10n.quotaRenews('01.12.2026')), findsOneWidget);
    expect(find.text(l10n.quotaSeePlans), findsOneWidget);

    await t.tap(find.byTooltip(l10n.quotaClose));
    await t.pump();
    expect(find.text(l10n.quotaWarnTitle(20)), findsNothing);
    // The mark stays: it is a state, not a warning.
    expect(find.bySemanticsLabel(RegExp(l10n.quotaUsed(95))), findsOneWidget);
    await done(t, cubit);
  });

  testWidgets('free minutes: says they do not come back', (t) async {
    final cubit = await pump(t, const Balance(balanceSeconds: 60, plan: _free));
    expect(find.text(l10n.quotaFreeOnce), findsOneWidget);
    await done(t, cubit);
  });

  testWidgets('plenty left: neither mark nor banner', (t) async {
    final cubit = await pump(
      t,
      const Balance(balanceSeconds: 30000, plan: _pro),
    );
    expect(find.bySemanticsLabel(RegExp('foizi ishlatildi')), findsNothing);
    expect(find.byTooltip(l10n.quotaClose), findsNothing);
    await done(t, cubit);
  });
  testWidgets('at zero: the minutes are over', (t) async {
    final cubit = await pump(t, const Balance(plan: _pro));
    expect(find.text(l10n.quotaOver), findsOneWidget);
    expect(find.text(l10n.quotaWarnTitle(0)), findsNothing);
    await done(t, cubit);
  });

  testWidgets('a renewal date in the past is not shown', (t) async {
    final cubit = await pump(
      t,
      Balance(
        balanceSeconds: 600,
        plan: _pro,
        status: SubscriptionStatus.pastDue,
        periodEnd: DateTime(2020),
      ),
    );
    expect(find.text(l10n.quotaWarnTitle(10)), findsOneWidget);
    expect(find.textContaining('Yangilanish'), findsNothing);
    await done(t, cubit);
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations_uz.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/meeting_bot/application/meeting_bot_cubit.dart';
import 'package:transkriptor_uz/features/meeting_bot/presentation/pages/meeting_page.dart';
import 'package:transkriptor_uz/features/summary/application/summary_cubit.dart';

class _Meeting extends MockCubit<MeetingBotState> implements MeetingBotCubit;

class _Summary extends MockCubit<SummaryState> implements SummaryCubit;

class _Account extends MockCubit<AccountState> implements AccountCubit;

void main() {
  late _Meeting meeting;
  late _Summary summary;
  late _Account account;
  final l10n = AppLocalizationsUz();

  setUp(() {
    meeting = _Meeting();
    summary = _Summary();
    account = _Account();
    when(() => meeting.load(any())).thenAnswer((_) async {});
    when(() => summary.state).thenReturn(const SummaryState());
    when(() => account.state).thenReturn(
      const AccountState(
        status: AccountStatus.success,
        account: Account(
          user: AppUser(id: 'u1', email: 'a@misol.uz'),
          workspaces: [Workspace(id: 'w1', name: 'Shaxsiy')],
        ),
      ),
    );
    getIt
      ..registerFactory<MeetingBotCubit>(() => meeting)
      ..registerFactory<SummaryCubit>(() => summary);
  });

  tearDown(() async => await getIt.reset());

  Future<void> pump(WidgetTester tester, MeetingBotState state) async {
    when(() => meeting.state).thenReturn(state);
    await tester.pumpWidget(
      BlocProvider<AccountCubit>.value(
        value: account,
        child: MaterialApp(
          theme: AppTheme.dark(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MeetingPage(),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('bot off on the server: «Tez orada», no form to send it', (
    tester,
  ) async {
    await pump(
      tester,
      const MeetingBotState(workspaceId: 'w1', available: false),
    );
    expect(find.text(l10n.comingSoon), findsOneWidget);
    expect(find.text(l10n.meetUnavailable), findsOneWidget);
    expect(find.text(l10n.meetJoin), findsNothing);
    expect(find.byType(TextField), findsNothing);
  });

  testWidgets('bot on: the form, and no «Tez orada»', (tester) async {
    await pump(tester, const MeetingBotState(workspaceId: 'w1'));
    expect(find.text(l10n.comingSoon), findsNothing);
    expect(find.text(l10n.meetUrlLabel), findsOneWidget);
  });
}

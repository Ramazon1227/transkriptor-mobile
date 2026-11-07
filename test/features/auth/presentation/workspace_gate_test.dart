import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations_uz.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/presentation/widgets/workspace_gate.dart';

class _Account extends MockCubit<AccountState> implements AccountCubit;

void main() {
  final l10n = AppLocalizationsUz();

  testWidgets('an account with no workspace gets a way out (W-4)', (
    tester,
  ) async {
    final account = _Account();
    when(() => account.state).thenReturn(
      const AccountState(
        status: AccountStatus.success,
        account: Account(
          user: AppUser(id: 'u1', email: 'a@misol.uz'),
        ),
      ),
    );
    when(account.logout).thenAnswer((_) async {});
    await tester.pumpWidget(
      BlocProvider<AccountCubit>.value(
        value: account,
        child: MaterialApp(
          theme: AppTheme.dark(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: WorkspaceGate(builder: (_, id) => Text('ws $id')),
          ),
        ),
      ),
    );
    expect(find.text(l10n.noWorkspaceTitle), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    await tester.tap(find.text(l10n.profileLogout));
    verify(account.logout).called(1);
  });
}

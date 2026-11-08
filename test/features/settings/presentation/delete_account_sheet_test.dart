import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/features/auth/application/delete_account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';
import 'package:transkriptor_uz/features/settings/presentation/widgets/delete_account_sheet.dart';

class _MockAuthFacade extends Mock implements IAuthFacade;

void main() {
  const user = AppUser(id: 'u', email: 'e@misol.uz');

  Future<String?> refusal(WidgetTester tester, Failure failure) async {
    final facade = _MockAuthFacade();
    when(() => facade.deleteAccount(password: 'parol-123'))
        .thenAnswer((_) async => Left(failure));
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider(
            create: (_) => DeleteAccountCubit(facade),
            child: const DeleteAccountSheet(user: user),
          ),
        ),
      ),
    );
    await tester.enterText(find.byType(TextField), 'parol-123');
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    final error = tester
        .widget<TextField>(find.byType(TextField))
        .decoration
        ?.errorText;
    await tester.pumpWidget(const SizedBox.shrink());
    return error;
  }

  testWidgets('SOLE_OWNER names the workspaces (W-3)', (tester) async {
    final error = await refusal(
      tester,
      const Failure.soleOwner(['Sud', 'Klinika']),
    );
    expect(error, contains('Sud, Klinika'));
  });

  testWidgets('an older server’s 409 keeps the generic sentence', (
    tester,
  ) async {
    final error = await refusal(
      tester,
      const Failure.server(statusCode: 409, message: 'ziddiyat'),
    );
    expect(error, isNot(contains('ziddiyat')));
    expect(
      error,
      'Siz boshqa aʼzolari bor ish maydonining yagona egasisiz. '
      'Avval egalikni boshqa aʼzoga bering.',
    );
  });

  testWidgets('LAST_ADMIN says why, not «sole owner» (AD-1)', (tester) async {
    final error = await refusal(tester, const Failure.lastAdmin());
    expect(
      error,
      'Siz yagona platforma adminisiz — avval boshqa hisobni admin qiling.',
    );
  });

  Future<void> openWith(WidgetTester tester, int unsent) async {
    final facade = _MockAuthFacade();
    when(facade.unsentRecordings).thenAnswer((_) async => Right(unsent));
    final cubit = DeleteAccountCubit(facade);
    await cubit.loadUnsent();
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider.value(
            value: cubit,
            child: const DeleteAccountSheet(user: user),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('warns how many unsent recordings go too (MB-12)', (
    tester,
  ) async {
    await openWith(tester, 3);
    expect(
      find.text('Telefondagi 3 ta yuborilmagan yozuv ham oʻchadi.'),
      findsOneWidget,
    );
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('no unsent recordings, no warning', (tester) async {
    await openWith(tester, 0);
    expect(find.textContaining('yuborilmagan yozuv'), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}

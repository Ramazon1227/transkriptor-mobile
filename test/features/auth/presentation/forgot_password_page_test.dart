import 'package:dartz/dartz.dart' show Right, unit;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/features/auth/application/forgot_password_bloc.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';
import 'package:transkriptor_uz/features/auth/presentation/pages/forgot_password_page.dart';

class _MockAuthFacade extends Mock implements IAuthFacade;

void main() {
  late _MockAuthFacade facade;

  setUp(() {
    facade = _MockAuthFacade();
    when(() => facade.requestPasswordReset(email: any(named: 'email')))
        .thenAnswer((_) async => const Right(unit));
    // The page takes its bloc from DI, as in the app.
    getIt.registerFactory(() => ForgotPasswordBloc(facade));
  });
  tearDown(getIt.reset);

  testWidgets('the email from login is prefilled, sent, and kept for a '
      'second request', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ForgotPasswordPage(initialEmail: 'ali@misol.uz'),
      ),
    );

    await tester.tap(find.byKey(const Key('forgot_submit')));
    await tester.pumpAndSettle();
    expect(find.text('Pochtangizni tekshiring'), findsOneWidget);
    expect(find.textContaining('ali@misol.uz'), findsOneWidget);

    await tester.tap(find.byKey(const Key('forgot_again')));
    await tester.pumpAndSettle();
    final field = tester.widget<TextField>(
      find.byKey(const Key('forgot_email')),
    );
    expect(field.controller!.text, 'ali@misol.uz');
    verify(() => facade.requestPasswordReset(email: 'ali@misol.uz')).called(1);
  });
}

import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/events/library_changes.dart';
import 'package:transkriptor_uz/core/l10n/gen/app_localizations.dart';
import 'package:transkriptor_uz/core/network/session_manager.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/application/profile_name_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';
import 'package:transkriptor_uz/features/auth/domain/i_auth_facade.dart';
import 'package:transkriptor_uz/features/auth/presentation/pages/profile_page.dart';
import 'package:transkriptor_uz/features/push/domain/i_push_facade.dart';
import 'package:transkriptor_uz/features/workspace/domain/i_workspace_facade.dart';

class _MockAuthFacade extends Mock implements IAuthFacade;

class _MockPushFacade extends Mock implements IPushFacade;

class _MockWorkspaceFacade extends Mock implements IWorkspaceFacade;

void main() {
  late _MockAuthFacade facade;
  late LibraryChanges changes;
  late AccountCubit account;

  setUp(() {
    facade = _MockAuthFacade();
    changes = LibraryChanges();
    account =
        AccountCubit(
          facade,
          changes,
          SessionManager(),
          _MockPushFacade(),
          _MockWorkspaceFacade(),
        )..signedIn(
          const Account(
            user: AppUser(id: 'u1', email: 'ali@misol.uz', fullName: 'Ali'),
          ),
        );
    getIt.registerFactory(() => ProfileNameCubit(facade));
  });

  tearDown(() async {
    await account.close();
    await changes.dispose();
    await getIt.reset();
  });

  Widget host() => MaterialApp(
    theme: AppTheme.dark(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: BlocProvider.value(value: account, child: const ProfilePage()),
  );

  testWidgets('edit the name: saved, account updated, sheet closed', (
    tester,
  ) async {
    when(() => facade.updateName(any())).thenAnswer(
      (_) async => const Right(
        AppUser(id: 'u1', email: 'ali@misol.uz', fullName: 'Ali Valiyev'),
      ),
    );
    await tester.pumpWidget(host());
    await tester.tap(find.byKey(const Key('profile_name_row')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('profile_name_field')), '   ');
    await tester.tap(find.byKey(const Key('profile_name_save')));
    await tester.pumpAndSettle();
    expect(find.text('Ismni kiriting.'), findsOneWidget);
    verifyNever(() => facade.updateName(any()));

    await tester.enterText(
      find.byKey(const Key('profile_name_field')),
      ' Ali  Valiyev ',
    );
    await tester.tap(find.byKey(const Key('profile_name_save')));
    await tester.pumpAndSettle();
    verify(() => facade.updateName('Ali Valiyev')).called(1);
    expect(find.byKey(const Key('profile_name_field')), findsNothing);
    expect(account.state.account?.user.fullName, 'Ali Valiyev');
    expect(find.text('Ali Valiyev'), findsOneWidget);
    expect(find.text('Ism saqlandi'), findsOneWidget);
  });

  testWidgets('a failed save stays in the sheet with the error', (
    tester,
  ) async {
    when(() => facade.updateName(any()))
        .thenAnswer((_) async => const Left(Failure.network()));
    await tester.pumpWidget(host());
    await tester.tap(find.byKey(const Key('profile_name_row')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('profile_name_field')), 'B');
    await tester.tap(find.byKey(const Key('profile_name_save')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('profile_name_field')), findsOneWidget);
    expect(account.state.account?.user.fullName, 'Ali');
    final field = tester.widget<TextField>(
      find.byKey(const Key('profile_name_field')),
    );
    expect(field.decoration?.errorText, isNotNull);
  });
}

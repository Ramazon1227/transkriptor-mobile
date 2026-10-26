import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/app_router.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';

class App extends StatelessWidget {
  const App({required this.signedIn, super.key});

  /// Tokens were found at start; the account is loaded straight away.
  final bool signedIn;

  @override
  Widget build(BuildContext context) {
    // Above the router: every screen reads the account and its workspace.
    return BlocProvider(
      create: (_) {
        final cubit = getIt<AccountCubit>();
        if (signedIn) unawaited(cubit.load());
        return cubit;
      },
      child: MaterialApp.router(
        onGenerateTitle: (context) => context.l10n.appTitle,
        theme: AppTheme.dark(),
        routerConfig: getIt<AppRouter>().config,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

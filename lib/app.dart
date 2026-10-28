import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/app_router.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/push/application/push_cubit.dart';

class App extends StatelessWidget {
  const App({required this.signedIn, super.key});

  /// Tokens were found at start; the account is loaded straight away.
  final bool signedIn;

  @override
  Widget build(BuildContext context) {
    // Above the router: every screen reads the account and its workspace.
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final cubit = getIt<AccountCubit>();
            if (signedIn) unawaited(cubit.load());
            return cubit;
          },
        ),
        BlocProvider(create: (_) => getIt<PushCubit>()),
      ],
      child: const _PushListener(child: _AppView()),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      theme: AppTheme.dark(),
      routerConfig: getIt<AppRouter>().config,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Registers this phone for push once an account is in hand, and opens
/// the page of a tapped notification.
class _PushListener extends StatelessWidget {
  const _PushListener({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AccountCubit, AccountState>(
          listenWhen: (prev, next) =>
              prev.account?.user.id != next.account?.user.id &&
              next.account != null,
          listener: (context, _) =>
              unawaited(context.read<PushCubit>().start()),
        ),
        BlocListener<PushCubit, PushState>(
          listenWhen: (prev, next) => prev.tapCount != next.tapCount,
          listener: (context, state) {
            final message = state.opened;
            if (message == null) return;
            if (context.read<AccountCubit>().state.account == null) return;
            final transcriptId = message.transcriptId;
            final jobId = message.jobId;
            final target = transcriptId != null
                ? Routes.transcriptOf(transcriptId)
                : jobId != null
                ? Routes.jobOf(jobId)
                : null;
            if (target == null) return;
            unawaited(getIt<AppRouter>().config.push(target));
          },
        ),
      ],
      child: child,
    );
  }
}

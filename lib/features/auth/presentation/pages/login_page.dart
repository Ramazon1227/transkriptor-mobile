import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/app_mark.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';
import 'package:transkriptor_uz/features/auth/application/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginBloc>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    context.read<LoginBloc>().add(
      LoginSubmitted(email: _email.text, password: _password.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (prev, next) => prev.status != next.status,
      listener: (context, state) {
        final account = state.account;
        if (state.status == LoginStatus.success && account != null) {
          context.read<AccountCubit>().signedIn(account);
          context.go(Routes.home);
        }
      },
      builder: (context, state) {
        final loading = state.status == LoginStatus.loading;
        final failure = state.failure;
        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: AppMark(size: 48),
                ),
                const SizedBox(height: 18),
                Text(l10n.loginTitle, style: AppText.display),
                const SizedBox(height: 8),
                Text(l10n.loginSubtitle, style: AppText.muted),
                const SizedBox(height: 32),
                TextField(
                  key: const Key('login_email'),
                  controller: _email,
                  enabled: !loading,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.emailLabel,
                    errorText: state.emailMissing
                        ? l10n.loginEmailRequired
                        : null,
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  key: const Key('login_password'),
                  controller: _password,
                  enabled: !loading,
                  obscureText: _obscure,
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    labelText: l10n.passwordLabel,
                    errorText: state.passwordMissing
                        ? l10n.loginPasswordRequired
                        : null,
                    suffixIcon: IconButton(
                      tooltip: _obscure ? l10n.showPassword : l10n.hidePassword,
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                ),
                if (failure != null) ...[
                  const SizedBox(height: 14),
                  Text(
                    // On this screen a 401 means the password is wrong.
                    failure is UnauthorizedFailure
                        ? l10n.loginWrongCredentials
                        : failure.message(l10n),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                FilledButton(
                  key: const Key('login_submit'),
                  onPressed: loading ? null : _submit,
                  child: loading
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.loginButton),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.loginNoAccount, style: AppText.muted),
                    TextButton(
                      key: const Key('login_to_register'),
                      onPressed: loading
                          ? null
                          : () => context.push(Routes.register),
                      child: Text(l10n.registerButton),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

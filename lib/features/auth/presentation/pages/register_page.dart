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
import 'package:transkriptor_uz/features/auth/application/register_bloc.dart';
import 'package:transkriptor_uz/features/auth/domain/password_rules.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegisterBloc>(),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    context.read<RegisterBloc>().add(
      RegisterSubmitted(
        fullName: _name.text,
        email: _email.text,
        password: _password.text,
      ),
    );
  }

  String? _passwordError(AppLocalizations l10n, PasswordProblem? problem) =>
      switch (problem) {
        null => null,
        PasswordProblem.tooShort => l10n.passwordTooShort,
        PasswordProblem.tooLong => l10n.passwordTooLong,
        PasswordProblem.needsLetterAndOther => l10n.passwordNeedsMix,
      };

  String _failureText(AppLocalizations l10n, Failure failure) =>
      switch (failure) {
        ServerFailure(statusCode: 409) => l10n.registerEmailTaken,
        _ => failure.message(l10n),
      };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<RegisterBloc, RegisterState>(
      listenWhen: (prev, next) => prev.status != next.status,
      listener: (context, state) {
        final account = state.account;
        if (state.status == RegisterStatus.success && account != null) {
          context.read<AccountCubit>().signedIn(account);
          context.go(Routes.home);
        }
      },
      builder: (context, state) {
        final loading = state.status == RegisterStatus.loading;
        final failure = state.failure;
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            top: false,
            child: AutofillGroup(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: AppMark(size: 40),
                  ),
                  const SizedBox(height: 18),
                  Text(l10n.registerTitle, style: AppText.display),
                  const SizedBox(height: 8),
                  Text(l10n.registerSubtitle, style: AppText.muted),
                  const SizedBox(height: 28),
                  TextField(
                    key: const Key('register_name'),
                    controller: _name,
                    enabled: !loading,
                    textCapitalization: TextCapitalization.words,
                    autofillHints: const [AutofillHints.name],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: l10n.registerName,
                      helperText: l10n.registerNameHint,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    key: const Key('register_email'),
                    controller: _email,
                    enabled: !loading,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: l10n.emailLabel,
                      errorText: state.emailInvalid
                          ? l10n.registerEmailInvalid
                          : null,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    key: const Key('register_password'),
                    controller: _password,
                    enabled: !loading,
                    obscureText: _obscure,
                    autofillHints: const [AutofillHints.newPassword],
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submit(),
                    decoration: InputDecoration(
                      labelText: l10n.passwordLabel,
                      // The rule is shown up front, not only after a miss.
                      helperText: l10n.passwordRules,
                      helperMaxLines: 2,
                      errorText: _passwordError(l10n, state.passwordProblem),
                      errorMaxLines: 2,
                      suffixIcon: IconButton(
                        tooltip: _obscure
                            ? l10n.showPassword
                            : l10n.hidePassword,
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
                      _failureText(l10n, failure),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                    key: const Key('register_submit'),
                    onPressed: loading ? null : _submit,
                    child: loading
                        ? const SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.registerButton),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.registerHaveAccount, style: AppText.muted),
                      TextButton(
                        onPressed: loading ? null : () => context.pop(),
                        child: Text(l10n.loginButton),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

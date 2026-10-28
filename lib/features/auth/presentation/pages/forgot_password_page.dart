import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/app_mark.dart';
import 'package:transkriptor_uz/core/widgets/content_width.dart';
import 'package:transkriptor_uz/features/auth/application/forgot_password_bloc.dart';

/// Asks for a reset link by mail. The link opens the web app, where the
/// new password is set; this screen only requests it.
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({this.initialEmail = '', super.key});

  /// What was typed on the login screen, so it is not typed twice.
  final String initialEmail;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ForgotPasswordBloc>(),
      child: _ForgotPasswordView(initialEmail: initialEmail),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView({required this.initialEmail});

  final String initialEmail;

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> {
  late final _email = TextEditingController(text: widget.initialEmail);

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    context.read<ForgotPasswordBloc>().add(
      ForgotPasswordSubmitted(email: _email.text),
    );
  }

  String _failureText(AppLocalizations l10n, Failure failure) =>
      switch (failure) {
        ServerFailure(statusCode: 503) => l10n.forgotUnavailable,
        ServerFailure(statusCode: 400) => l10n.registerEmailInvalid,
        _ => failure.message(l10n),
      };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        final sentTo = state.sentTo;
        return Scaffold(
          appBar: AppBar(),
          body: ContentWidth(
            child: SafeArea(
              top: false,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: AppMark(size: 40),
                  ),
                  const SizedBox(height: 18),
                  if (state.status == ForgotPasswordStatus.success &&
                      sentTo != null)
                    ..._sent(context, l10n, sentTo)
                  else
                    ..._form(context, l10n, state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _form(
    BuildContext context,
    AppLocalizations l10n,
    ForgotPasswordState state,
  ) {
    final loading = state.status == ForgotPasswordStatus.loading;
    final failure = state.failure;
    return [
      Text(l10n.forgotTitle, style: AppText.display),
      const SizedBox(height: 8),
      Text(l10n.forgotSubtitle, style: AppText.muted),
      const SizedBox(height: 28),
      TextField(
        key: const Key('forgot_email'),
        controller: _email,
        enabled: !loading,
        autofocus: widget.initialEmail.isEmpty,
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _submit(),
        decoration: InputDecoration(
          labelText: l10n.emailLabel,
          errorText: state.emailInvalid ? l10n.registerEmailInvalid : null,
        ),
      ),
      if (failure != null) ...[
        const SizedBox(height: 14),
        Text(
          _failureText(l10n, failure),
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ],
      const SizedBox(height: 24),
      FilledButton(
        key: const Key('forgot_submit'),
        onPressed: loading ? null : _submit,
        child: loading
            ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(l10n.forgotSubmit),
      ),
      const SizedBox(height: 20),
      _BackToLogin(enabled: !loading),
    ];
  }

  List<Widget> _sent(
    BuildContext context,
    AppLocalizations l10n,
    String sentTo,
  ) {
    return [
      Text(l10n.forgotSentTitle, style: AppText.display),
      const SizedBox(height: 16),
      Text(l10n.forgotSentBody(sentTo)),
      const SizedBox(height: 12),
      Text(l10n.forgotSentHint, style: AppText.muted),
      const SizedBox(height: 28),
      OutlinedButton(
        key: const Key('forgot_again'),
        onPressed: () => context.read<ForgotPasswordBloc>().add(
          const ForgotPasswordRestarted(),
        ),
        child: Text(l10n.forgotSendAgain),
      ),
      const SizedBox(height: 20),
      const _BackToLogin(enabled: true),
    ];
  }
}

class _BackToLogin extends StatelessWidget {
  const _BackToLogin({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // Wraps under large text instead of running off the right edge.
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(l10n.forgotRemembered, style: AppText.muted),
        TextButton(
          onPressed: enabled ? () => context.pop() : null,
          child: Text(l10n.loginButton),
        ),
      ],
    );
  }
}

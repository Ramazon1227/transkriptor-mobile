import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/features/auth/application/delete_account_cubit.dart';
import 'package:transkriptor_uz/features/auth/domain/entities/account.dart';

/// Account deletion, confirmed inside the sheet with the password (or,
/// for a Google-only account, the person's own email). On success the
/// session ends and the router goes to login.
Future<void> showDeleteAccountSheet(BuildContext context, AppUser user) {
  return showAppSheet<void>(
    context,
    builder: (_) => BlocProvider(
      create: (_) => getIt<DeleteAccountCubit>(),
      child: DeleteAccountSheet(user: user),
    ),
  );
}

class DeleteAccountSheet extends StatefulWidget {
  const DeleteAccountSheet({required this.user, super.key});

  final AppUser user;

  @override
  State<DeleteAccountSheet> createState() => _DeleteAccountSheetState();
}

class _DeleteAccountSheetState extends State<DeleteAccountSheet> {
  final _field = TextEditingController();

  @override
  void dispose() {
    _field.dispose();
    super.dispose();
  }

  void _submit() => unawaited(
    context.read<DeleteAccountCubit>().submit(
      confirmation: _field.text,
      hasPassword: widget.user.hasPassword,
    ),
  );

  String? _error(AppLocalizations l10n, DeleteAccountState state) {
    if (state.confirmationMissing) return l10n.deleteRequired;
    return switch (state.failure) {
      null => null,
      ServerFailure(statusCode: 403) => l10n.deleteWrong,
      ServerFailure(statusCode: 409) => l10n.deleteSoleOwner,
      ServerFailure(statusCode: 400) => l10n.deleteRequired,
      final f => f.message(l10n),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final password = widget.user.hasPassword;
    return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
      listenWhen: (prev, next) => prev.status != next.status,
      listener: (context, state) {
        if (state.status == DeleteAccountStatus.success) {
          Navigator.of(context).maybePop();
        }
      },
      builder: (context, state) {
        final busy = state.status == DeleteAccountStatus.loading;
        final error = _error(l10n, state);
        return AppSheet(
          title: l10n.deleteTitle,
          footer: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.bad,
                  foregroundColor: AppColors.sf0,
                ),
                onPressed: busy ? null : _submit,
                child: busy
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.deleteConfirm),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: busy ? null : () => Navigator.of(context).pop(),
                child: Text(l10n.cancel),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.deleteBody, style: AppText.body),
              const SizedBox(height: 16),
              TextField(
                controller: _field,
                enabled: !busy,
                obscureText: password,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: password
                    ? TextInputType.visiblePassword
                    : TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                decoration: InputDecoration(
                  labelText: password
                      ? l10n.deletePasswordLabel
                      : l10n.deleteEmailLabel,
                  hintText: password
                      ? null
                      : l10n.deleteEmailHint(widget.user.email),
                  errorText: error,
                  errorMaxLines: 4,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';
import 'package:transkriptor_uz/features/auth/application/account_cubit.dart';

/// Sign-out, confirmed inside a sheet — never a bare system dialog. The
/// session expiry the logout raises takes the router to login.
Future<void> showLogoutSheet(BuildContext context) async {
  final cubit = context.read<AccountCubit>();
  final ok = await showAppSheet<bool>(
    context,
    builder: (sheetContext) {
      final l10n = sheetContext.l10n;
      return AppSheet(
        title: l10n.profileLogoutTitle,
        footer: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              onPressed: () => Navigator.of(sheetContext).pop(true),
              child: Text(l10n.profileLogout),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.of(sheetContext).pop(false),
              child: Text(l10n.cancel),
            ),
          ],
        ),
        child: Text(l10n.logoutBody, style: AppText.caption),
      );
    },
  );
  if (ok ?? false) await cubit.logout();
}

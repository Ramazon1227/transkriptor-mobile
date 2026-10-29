import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/widgets/app_sheet.dart';

/// Asks before something is lost, inside a sheet — never a system dialog
/// (the user rejected `window.confirm` on the web for the same reason).
/// Resolves to true only when [confirmLabel] was pressed.
Future<bool> showConfirmSheet(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool destructive = true,
}) async {
  final confirmed = await showAppSheet<bool>(
    context,
    builder: (context) => AppSheet(
      title: title,
      footer: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              key: const Key('confirm_sheet_cancel'),
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(context.l10n.cancel),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              key: const Key('confirm_sheet_confirm'),
              style: destructive
                  ? FilledButton.styleFrom(
                      backgroundColor: AppColors.bad,
                      foregroundColor: AppColors.accentText,
                    )
                  : null,
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                confirmLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      child: Text(message, style: AppText.body),
    ),
  );
  return confirmed ?? false;
}

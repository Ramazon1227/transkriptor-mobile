import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';

/// Stands in for an editor tab whose screen is built elsewhere (AI suhbat,
/// Xulosa, Oʻrganish — phase M-R5). It says so instead of faking content.
class TabPlaceholder extends StatelessWidget {
  const TabPlaceholder({required this.icon, super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: AppColors.mutedDark),
            const SizedBox(height: 12),
            Text(
              context.l10n.editorTabSoon,
              textAlign: TextAlign.center,
              style: AppText.caption,
            ),
          ],
        ),
      ),
    );
  }
}

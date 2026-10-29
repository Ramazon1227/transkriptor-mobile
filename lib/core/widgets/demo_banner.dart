import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';

/// Says that what follows comes from a demo source, not the server: a
/// coral left-edge bar (attention), never mint (that is the model's).
/// Every screen fed by a `Demo…Repository` shows it.
class DemoBanner extends StatelessWidget {
  const DemoBanner({this.message, super.key});

  /// Overrides the default «Namuna — server hali tayyor emas».
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.segment),
        border: const Border(left: BorderSide(color: AppColors.warn, width: 3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.science_outlined, size: 18, color: AppColors.warn),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message ?? context.l10n.demoBanner,
              style: AppText.caption.copyWith(color: AppColors.cotton),
            ),
          ),
        ],
      ),
    );
  }
}

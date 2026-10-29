import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';

/// One chip of the folder or tag row under the source tabs. Active is
/// saffron on its soft ground with a saffron edge — never a filled pill;
/// the underline belongs to the source tabs above.
class FilterTab extends StatelessWidget {
  const FilterTab({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
    this.count,
    this.onLongPress,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final IconData? icon;
  final int? count;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.accent : AppColors.mutedDark;
    final glyph = icon;
    final n = count;
    final radius = BorderRadius.circular(AppRadii.button);
    // The row's height is fixed; large text must not push the label out.
    final scaler = MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 1.3);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
      child: Semantics(
        selected: selected,
        button: true,
        child: Material(
          color: selected ? AppColors.accentSoft : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: BorderSide(
              color: selected ? AppColors.accent : AppColors.sf3,
            ),
          ),
          child: InkWell(
            borderRadius: radius,
            onTap: onTap,
            onLongPress: onLongPress,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (glyph != null) ...[
                    Icon(glyph, size: 15, color: color),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    label,
                    textScaler: scaler,
                    style: AppText.caption.copyWith(
                      color: selected ? AppColors.accent : AppColors.cotton,
                    ),
                  ),
                  if (n != null) ...[
                    const SizedBox(width: 6),
                    Text(
                      '$n',
                      textScaler: scaler,
                      style: AppText.mono.copyWith(fontSize: 11),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

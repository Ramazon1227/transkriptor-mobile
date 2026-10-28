import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';

/// One tab of a horizontal filter bar; the active one is underlined, as
/// in the transcript's speaker bar.
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
    final color = selected ? AppColors.cotton : AppColors.mutedDark;
    final glyph = icon;
    final n = count;
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? AppColors.accent : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Row(
            children: [
              if (glyph != null) ...[
                Icon(glyph, size: 16, color: color),
                const SizedBox(width: 6),
              ],
              Text(label, style: TextStyle(fontSize: 13, color: color)),
              if (n != null) ...[
                const SizedBox(width: 6),
                Text(
                  '$n',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.mutedDark,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

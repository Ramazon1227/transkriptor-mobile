import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';

/// A titled group of [ActionRow]s on one card, rows split by hairlines —
/// the settings-list shape.
class ActionGroup extends StatelessWidget {
  const ActionGroup({required this.children, this.title, super.key});

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(title.toUpperCase(), style: AppText.label),
          ),
        Material(
          color: AppColors.sf1,
          borderRadius: BorderRadius.circular(AppRadii.card),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0)
                  const Divider(height: 1, indent: 52, color: AppColors.sf2),
                children[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// One row: icon, label (and an optional second line), then on the right
/// a [value], a custom [trailing] widget (a switch, a badge) or a chevron.
/// The chevron shows when the row is tappable and nothing else is there.
class ActionRow extends StatelessWidget {
  const ActionRow({
    required this.label,
    this.icon,
    this.subtitle,
    this.value,
    this.trailing,
    this.onTap,
    this.destructive = false,
    this.showChevron,
    super.key,
  });

  final IconData? icon;
  final String label;
  final String? subtitle;
  final String? value;
  final Widget? trailing;
  final VoidCallback? onTap;

  /// Red label and icon: sign-out-like actions that lose something.
  final bool destructive;

  /// Null: shown when [onTap] is set and there is no [trailing].
  final bool? showChevron;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? AppColors.bad : AppColors.cotton;
    final chevron = showChevron ?? (onTap != null && trailing == null);
    final subtitle = this.subtitle;
    final value = this.value;
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 52),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 20,
                  color: destructive ? AppColors.bad : AppColors.mutedDark,
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: AppText.body.copyWith(color: color)),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle, style: AppText.caption),
                    ],
                  ],
                ),
              ),
              if (value != null) ...[
                const SizedBox(width: 12),
                Flexible(
                  flex: 2,
                  child: Text(
                    value,
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.body.copyWith(color: AppColors.mutedDark),
                  ),
                ),
              ],
              if (trailing != null) ...[const SizedBox(width: 12), trailing!],
              if (chevron) ...[
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.mutedDark,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

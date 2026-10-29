import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';

/// One option of a [ChoiceGroup].
class ChoiceOption<T> {
  const ChoiceOption(this.value, this.label);

  final T value;
  final String label;
}

/// A row of equal buttons, one of them active («5 · 10 · 15 · 20»,
/// «Oson · Oʻrta · Qiyin»). Active is saffron on its soft ground with a
/// saffron edge — never a filled saffron pill.
class ChoiceGroup<T> extends StatelessWidget {
  const ChoiceGroup({
    required this.options,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final List<ChoiceOption<T>> options;
  final T? selected;

  /// Null disables the whole group.
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < options.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: _Choice(option: options[i], group: this),
          ),
        ],
      ],
    );
  }
}

class _Choice<T> extends StatelessWidget {
  const _Choice({required this.option, required this.group});

  final ChoiceOption<T> option;
  final ChoiceGroup<T> group;

  @override
  Widget build(BuildContext context) {
    final active = option.value == group.selected;
    final onChanged = group.onChanged;
    final radius = BorderRadius.circular(AppRadii.button);
    return Semantics(
      selected: active,
      button: true,
      child: Material(
        color: active ? AppColors.accentSoft : AppColors.sf1,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: active ? AppColors.accent : AppColors.sf3),
        ),
        child: InkWell(
          borderRadius: radius,
          onTap: onChanged == null ? null : () => onChanged(option.value),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 44),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Text(
                  option.label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.button.copyWith(
                    fontSize: 14,
                    color: active ? AppColors.accent : AppColors.cotton,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

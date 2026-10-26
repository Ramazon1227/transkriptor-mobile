import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';

/// "All" plus the first few jsonplaceholder users.
class UserFilterBar extends StatelessWidget {
  const UserFilterBar({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final int? selected;
  final ValueChanged<int?> onChanged;

  static const List<int?> _options = [null, 1, 2, 3];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _options.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final id = _options[i];
          return ChoiceChip(
            label: Text(
              id == null ? l10n.exampleFilterAll : l10n.exampleFilterUser(id),
            ),
            selected: selected == id,
            onSelected: (_) => onChanged(id),
          );
        },
      ),
    );
  }
}

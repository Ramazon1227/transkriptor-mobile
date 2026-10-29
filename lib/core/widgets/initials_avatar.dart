import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';

/// A round avatar with up to two initials of [name], or the first letter
/// of [fallback] (an email) when the name is empty.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    required this.name,
    this.fallback = '',
    this.radius = 26,
    super.key,
  });

  final String name;
  final String fallback;
  final double radius;

  static String initialsOf(String name, String fallback) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isNotEmpty) {
      return parts.take(2).map((p) => p.characters.first.toUpperCase()).join();
    }
    final f = fallback.trim();
    return f.isEmpty ? '' : f.characters.first.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.sf2,
      child: Text(
        initialsOf(name, fallback),
        style: AppText.heading.copyWith(fontSize: radius * .65),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';

/// Type roles from the design book. The display face (Unbounded) is not
/// bundled yet, so display text is the system face, heavy and tight.
abstract final class AppText {
  static const TextStyle display = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
    height: 1.1,
    color: AppColors.cotton,
  );

  static const TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.6,
    height: 1.15,
    color: AppColors.cotton,
  );

  /// Timecodes, durations, percentages: digits that line up.
  static const TextStyle mono = TextStyle(
    fontFeatures: [FontFeature.tabularFigures()],
    color: AppColors.mutedDark,
    fontSize: 12,
  );

  /// Small uppercase section labels.
  static const TextStyle label = TextStyle(
    fontSize: 11,
    letterSpacing: 1.6,
    fontWeight: FontWeight.w500,
    color: AppColors.mutedDark,
  );

  static const TextStyle muted = TextStyle(
    color: AppColors.mutedDark,
    fontSize: 13,
  );
}

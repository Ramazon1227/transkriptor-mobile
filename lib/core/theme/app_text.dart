import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';

/// Type roles from the design book (`design/tokens.css`): Unbounded for
/// display, Golos Text for everything else. Both are bundled as variable
/// fonts and both cover Cyrillic and Uzbek's U+02BB / U+02BC.
///
/// A variable font only gets heavier when its `wght` axis moves, so every
/// style here sets `fontVariations` alongside `fontWeight`. To change the
/// weight of a style, use [AppTextWeight.weighted] — a bare
/// `copyWith(fontWeight: ...)` keeps the old axis value and renders at the
/// old weight.
abstract final class AppText {
  static const String bodyFamily = 'GolosText';
  static const String displayFamily = 'Unbounded';

  static const List<FontVariation> _w400 = [FontVariation('wght', 400)];
  static const List<FontVariation> _w500 = [FontVariation('wght', 500)];
  static const List<FontVariation> _w600 = [FontVariation('wght', 600)];
  static const List<FontVariation> _w700 = [FontVariation('wght', 700)];

  /// Large page greetings and hero numbers. Display only, never body.
  static const TextStyle display = TextStyle(
    fontFamily: displayFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontVariations: _w700,
    letterSpacing: -0.8,
    height: 1.2,
    color: AppColors.cotton,
  );

  /// Page and app-bar titles.
  static const TextStyle title = TextStyle(
    fontFamily: displayFamily,
    fontSize: 19,
    fontWeight: FontWeight.w600,
    fontVariations: _w600,
    letterSpacing: -0.5,
    height: 1.2,
    color: AppColors.cotton,
  );

  /// Card and sheet headings.
  static const TextStyle heading = TextStyle(
    fontFamily: bodyFamily,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    fontVariations: _w600,
    height: 1.3,
    color: AppColors.cotton,
  );

  /// Emphasised body: list titles, card titles.
  static const TextStyle bodyStrong = TextStyle(
    fontFamily: bodyFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontVariations: _w600,
    height: 1.35,
    color: AppColors.cotton,
  );

  /// A list row's name: a little lighter than [bodyStrong].
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: bodyFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    fontVariations: _w500,
    height: 1.35,
    color: AppColors.cotton,
  );

  static const TextStyle body = TextStyle(
    fontFamily: bodyFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontVariations: _w400,
    height: 1.45,
    color: AppColors.cotton,
  );

  /// Secondary lines under a title.
  static const TextStyle caption = TextStyle(
    fontFamily: bodyFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    fontVariations: _w400,
    height: 1.35,
    color: AppColors.mutedDark,
  );

  /// Same as [caption]; the name existing screens use.
  static const TextStyle muted = caption;

  /// Small uppercase section labels (`--tr-label: 0.16em`).
  static const TextStyle label = TextStyle(
    fontFamily: bodyFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    fontVariations: _w600,
    letterSpacing: 1.6,
    color: AppColors.mutedDark,
  );

  /// Buttons.
  static const TextStyle button = TextStyle(
    fontFamily: bodyFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontVariations: _w600,
  );

  /// Timecodes, durations, percentages: digits that line up.
  static const TextStyle mono = TextStyle(
    fontFamily: bodyFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontVariations: _w400,
    fontFeatures: [FontFeature.tabularFigures()],
    color: AppColors.mutedDark,
  );
}

extension AppTextWeight on TextStyle {
  /// Sets the weight on both the style and the variable font's axis.
  TextStyle weighted(FontWeight weight) => copyWith(
    fontWeight: weight,
    fontVariations: [FontVariation('wght', weight.value.toDouble())],
  );
}

import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';

/// Radii from the design book: button 7, segment 8, card 10.
abstract final class AppRadii {
  static const double button = 7;
  static const double segment = 8;
  static const double card = 10;
}

abstract final class AppTheme {
  static ThemeData dark() {
    // tokens.css has no error red yet, so `error` keeps the Material
    // default of ColorScheme.dark().
    const scheme = ColorScheme.dark(
      primary: AppColors.accent,
      onPrimary: AppColors.accentText,
      primaryContainer: AppColors.accentSoft,
      secondary: AppColors.mint,
      // Material 3 paints selected chips and nav indicators with this pair:
      // the design book's active state, saffron on its soft ground.
      secondaryContainer: AppColors.accentSoft,
      onSecondaryContainer: AppColors.accent,
      tertiary: AppColors.warn,
      surface: AppColors.sf0,
      onSurface: AppColors.cotton,
      onSurfaceVariant: AppColors.mutedDark,
      surfaceContainerLow: AppColors.sf1,
      surfaceContainer: AppColors.sf1,
      surfaceContainerHigh: AppColors.sf2,
      outline: AppColors.sf3,
      outlineVariant: AppColors.sf3,
    );

    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.sf0,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.sf0,
        foregroundColor: AppColors.cotton,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.sf1,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.card)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppRadii.button)),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          foregroundColor: AppColors.cotton,
          side: const BorderSide(color: AppColors.sf3),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppRadii.button)),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 48),
          foregroundColor: AppColors.accent,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.sf1,
        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.button)),
          borderSide: BorderSide(color: AppColors.sf3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.button)),
          borderSide: BorderSide(color: AppColors.sf3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.button)),
          borderSide: BorderSide(color: AppColors.accent),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.sf2,
        contentTextStyle: TextStyle(color: AppColors.cotton),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: AppColors.sf1,
        side: BorderSide(color: AppColors.sf3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.button)),
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.sf3, space: 1),
    );
  }
}

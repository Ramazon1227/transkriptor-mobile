import 'package:flutter/material.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';

/// Radii from the design book: button 7, segment 8, card 10.
abstract final class AppRadii {
  static const double button = 7;
  static const double segment = 8;
  static const double card = 10;

  /// Top corners of a bottom sheet. Not in the design book (it has no
  /// sheets); a little rounder than a card so a sheet reads as a layer.
  static const double sheet = 14;
}

/// The app is dark by design: there is no light theme and no toggle.
abstract final class AppTheme {
  static ThemeData dark() {
    const scheme = ColorScheme.dark(
      primary: AppColors.accent,
      onPrimary: AppColors.accentText,
      primaryContainer: AppColors.accentSoft,
      onPrimaryContainer: AppColors.accent,
      secondary: AppColors.mint,
      // Material 3 paints selected chips and nav indicators with this pair:
      // the design book's active state, saffron on its soft ground.
      secondaryContainer: AppColors.accentSoft,
      onSecondaryContainer: AppColors.accent,
      tertiary: AppColors.warn,
      error: AppColors.bad,
      onError: AppColors.sf0,
      errorContainer: AppColors.badSoft,
      onErrorContainer: AppColors.bad,
      surface: AppColors.sf0,
      onSurface: AppColors.cotton,
      onSurfaceVariant: AppColors.mutedDark,
      surfaceContainerLowest: AppColors.sf0,
      surfaceContainerLow: AppColors.sf1,
      surfaceContainer: AppColors.sf1,
      surfaceContainerHigh: AppColors.sf2,
      surfaceContainerHighest: AppColors.sf2,
      outline: AppColors.sf3,
      outlineVariant: AppColors.sf3,
    );

    const buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppRadii.button)),
    );
    const cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppRadii.card)),
    );
    const inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppRadii.button)),
      borderSide: BorderSide(color: AppColors.sf3),
    );

    return ThemeData(
      colorScheme: scheme,
      fontFamily: AppText.bodyFamily,
      textTheme: _textTheme,
      scaffoldBackgroundColor: AppColors.sf0,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.sf0,
        foregroundColor: AppColors.cotton,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppText.title,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.sf1,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: cardShape,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          textStyle: AppText.button,
          shape: buttonShape,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          foregroundColor: AppColors.cotton,
          side: const BorderSide(color: AppColors.sf3),
          textStyle: AppText.button,
          shape: buttonShape,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 48),
          foregroundColor: AppColors.accent,
          textStyle: AppText.button.copyWith(fontSize: 14),
          shape: buttonShape,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: AppColors.cotton),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.sf1,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        hintStyle: AppText.body.copyWith(color: AppColors.mutedDark),
        labelStyle: AppText.body.copyWith(color: AppColors.mutedDark),
        floatingLabelStyle: AppText.caption.copyWith(color: AppColors.accent),
        helperStyle: AppText.caption,
        errorStyle: AppText.caption.copyWith(color: AppColors.bad),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.accent),
        ),
        errorBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.bad),
        ),
        focusedErrorBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.bad),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.accent,
        selectionColor: AppColors.accentSoft,
        selectionHandleColor: AppColors.accent,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.sf2,
        contentTextStyle: AppText.body,
        actionTextColor: AppColors.accent,
        shape: buttonShape,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.sf1,
        selectedColor: AppColors.accentSoft,
        labelStyle: AppText.caption.copyWith(color: AppColors.cotton),
        side: const BorderSide(color: AppColors.sf3),
        shape: buttonShape,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.sf3, space: 1),
      // Every modal sheet carries the handle, AppSheet's and plain
      // showModalBottomSheet alike.
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.sf1,
        modalBackgroundColor: AppColors.sf1,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        modalElevation: 0,
        showDragHandle: true,
        dragHandleColor: AppColors.sf3,
        dragHandleSize: Size(36, 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadii.sheet),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.sf1,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: cardShape,
        titleTextStyle: AppText.heading,
        contentTextStyle: AppText.body.copyWith(color: AppColors.mutedDark),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.mutedDark,
        textColor: AppColors.cotton,
        titleTextStyle: AppText.body,
        subtitleTextStyle: AppText.caption,
        leadingAndTrailingTextStyle: AppText.caption,
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        minLeadingWidth: 24,
        shape: buttonShape,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? AppColors.accentText
              : AppColors.mutedDark,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? AppColors.accent
              : AppColors.sf3,
        ),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? AppColors.accent : null,
        ),
        checkColor: const WidgetStatePropertyAll(AppColors.accentText),
        side: const BorderSide(color: AppColors.sf3, width: 1.5),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? AppColors.accent
              : AppColors.mutedDark,
        ),
      ),
      // Choices: the active one is saffron on its soft ground, outlined.
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          shape: const WidgetStatePropertyAll(buttonShape),
          side: const WidgetStatePropertyAll(BorderSide(color: AppColors.sf3)),
          textStyle: WidgetStatePropertyAll(
            AppText.button.copyWith(fontSize: 14),
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected)
                ? AppColors.accentSoft
                : AppColors.sf1,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected)
                ? AppColors.accent
                : AppColors.cotton,
          ),
        ),
      ),
      // Tabs: underline, never a filled pill.
      tabBarTheme: TabBarThemeData(
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColors.accent, width: 2),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: AppColors.cotton,
        unselectedLabelColor: AppColors.mutedDark,
        labelStyle: AppText.button.copyWith(fontSize: 14),
        unselectedLabelStyle: AppText.body.copyWith(fontSize: 14),
        dividerColor: AppColors.sf2,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        tabAlignment: TabAlignment.start,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.accent,
        linearTrackColor: AppColors.sf2,
        circularTrackColor: Colors.transparent,
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: AppColors.sf2,
        surfaceTintColor: Colors.transparent,
        textStyle: AppText.body,
        shape: buttonShape,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: const BoxDecoration(
          color: AppColors.sf3,
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.button)),
        ),
        textStyle: AppText.caption.copyWith(color: AppColors.cotton),
      ),
    );
  }

  /// Material roles mapped onto the design book's styles, so stock
  /// widgets (dialogs, list tiles, buttons) render in Golos/Unbounded with
  /// the right axis weight.
  static const TextTheme _textTheme = TextTheme(
    displayLarge: AppText.display,
    displayMedium: AppText.display,
    displaySmall: AppText.display,
    headlineLarge: AppText.title,
    headlineMedium: AppText.title,
    headlineSmall: AppText.title,
    titleLarge: AppText.title,
    titleMedium: AppText.heading,
    titleSmall: AppText.bodyStrong,
    bodyLarge: AppText.body,
    bodyMedium: AppText.body,
    bodySmall: AppText.caption,
    labelLarge: AppText.button,
    labelMedium: AppText.caption,
    labelSmall: AppText.label,
  );
}

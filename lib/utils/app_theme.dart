import 'package:flutter/material.dart';

class AppTheme {
  // Prevent instantiation
  AppTheme._();

  // Define primary and secondary colors
  static const Color primaryColor = Color(0xFF1E88E5); // Blue
  static const Color secondaryColor = Color(0xFF64B5F6); // Light Blue
  static const Color accentColor = Color(0xFFFF5722); // Orange
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Color(0xFF212121); // Dark Gray
  static const Color lightTextColor = Color(0xFF757575); // Light Gray

  // Define text styles
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    color: textColor,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    color: lightTextColor,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  // Define button styles
  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: primaryColor,
    side: const BorderSide(color: primaryColor, width: 2),
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  // Define card theme
  static final CardTheme cardTheme = CardTheme(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    color: backgroundColor,
  );

  // Define input decoration theme
  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: primaryColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: secondaryColor, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: primaryColor),
    ),
    labelStyle: const TextStyle(
      color: lightTextColor,
    ),
    hintStyle: const TextStyle(
      color: lightTextColor,
    ),
  );

  // Define app bar theme
  static final AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: headlineSmall.copyWith(fontSize: 20),
  );

  // Define scaffold background color
  static const Color scaffoldBackgroundColor = backgroundColor;

  // Define snack bar theme
  static final SnackBarThemeData snackBarTheme = SnackBarThemeData(
    backgroundColor: primaryColor,
    contentTextStyle: bodyMedium.copyWith(color: Colors.white),
  );

  // Define progress indicator theme
  static final ThemeData theme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    textTheme: const TextTheme(
      headlineSmall: headlineSmall,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      titleMedium: titleMedium,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedButtonStyle),
    cardTheme: cardTheme,
    inputDecorationTheme: inputDecorationTheme,
    appBarTheme: appBarTheme,
    snackBarTheme: snackBarTheme,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryColor,
    ),
  );
}

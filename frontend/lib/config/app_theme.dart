// lib/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: const Color(0xFFA54E4E),
        primaryContainer: const Color(0xFF21899C),
        secondary: Color(0xFFFE9879),
        background: Color(0xFFFE9879),
        surface: Color(0xFFFE9879),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onBackground: Colors.black,
        onSurface: Colors.black,
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      buttonTheme: ButtonThemeData(
        buttonColor: const Color(0xFF21899C),
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF78909C),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF333333)),
        bodyMedium: TextStyle(color: Color(0xFF333333)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFFFE9879),
        contentTextStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}

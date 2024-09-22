// lib/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: const Color(0xFFA54E4E),
        primaryContainer: const Color(0xFFFEC107),
        secondary: const Color(0xFFF5E6CA),
        background: const Color(0xFFF5E6CA),
        surface: const Color(0xFFF5E6CA),
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
        buttonColor: const Color(0xFFFEC107),
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF78909C),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF333333)),
        bodyMedium: TextStyle(color: Color(0xFF333333)),
      ),
    );
  }
}

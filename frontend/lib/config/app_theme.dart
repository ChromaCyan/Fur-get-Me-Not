import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: const Color(0xFF21899C), // Primary color
        primaryContainer: const Color(0xFFFE9879), // Optional, adjust if needed
        secondary: const Color(0xFFFE9879), // Secondary color
        background: Colors.white, // Background color
        surface: const Color(0xFFFE9879), // Set surface to white
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onBackground: Colors.black,
        onSurface: Colors.black,
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white, // Overall scaffold background
      buttonTheme: ButtonThemeData(
        buttonColor: const Color(0xFF21899C), // Button background color
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF21899C), // Use primary color for AppBar
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF333333)), // Body text color
        bodyMedium: TextStyle(color: Color(0xFF333333)), // Body text color
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFFFE9879), // SnackBar background color
        contentTextStyle: const TextStyle(color: Colors.white), // SnackBar text color
      ),
    );
  }
}

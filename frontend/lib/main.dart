// lib/main.dart
import 'package:flutter/material.dart';
import 'package:fur_get_me_not/screens/pet_owner/adoption_list.dart';
import 'package:fur_get_me_not/screens/splash_screen.dart';
import 'package:fur_get_me_not/app_theme.dart';  // Import your theme file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fur-get Me Not',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const PetsOnBoardingScreen(),
    );
  }
}

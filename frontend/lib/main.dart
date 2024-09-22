import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:fur_get_me_not/screens/splash_screen.dart';
import 'package:fur_get_me_not/app_theme.dart';
import 'package:fur_get_me_not/bloc/authentication/login_bloc.dart';
import 'package:fur_get_me_not/repositories/login_repository.dart';
import 'package:fur_get_me_not/repositories/pet_repository.dart';
import 'package:fur_get_me_not/providers/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PetRepository>(
          create: (_) => PetRepository(), // Add PetRepository provider
        ),
        ...AppProviders.getProviders(), // Other providers
      ],
      child: MaterialApp(
        title: 'Fur-get Me Not',
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        home: const PetsOnBoardingScreen(), // Ensure your home screen is correctly referenced
      ),
    );
  }
}
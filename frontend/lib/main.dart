import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:fur_get_me_not/screens/splash_screen.dart';
import 'package:fur_get_me_not/app_theme.dart';
import 'package:fur_get_me_not/repositories/pet_repository.dart';
import 'package:fur_get_me_not/repositories/chat_list_repository.dart';
import 'package:fur_get_me_not/repositories/chat_repository.dart';
import 'package:fur_get_me_not/bloc/authentication/login_bloc.dart';
import 'package:fur_get_me_not/repositories/login_repository.dart';
import 'package:fur_get_me_not/providers/provider.dart';
import 'package:fur_get_me_not/screens/adopter/reminder_form_screen.dart'; // Import AddReminderScreen

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
          create: (_) => PetRepository(),
        ),
        Provider<ChatListRepository>(
          create: (_) => ChatListRepository(),
        ),
        Provider<ChatRepository>(
          create: (_) => ChatRepository(),
        ),
        ...AppProviders
            .getProviders(), // Other providers (e.g., LoginBloc, etc.)
      ],
      child: MaterialApp(
        title: 'Fur-get Me Not',
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        home: const PetsOnBoardingScreen(),
        routes: {
          //Added Reminder stuff here!
          '/add_reminder': (context) =>
              AddReminderScreen(), // Route for adding reminders
          // Define any other routes here if needed
        },
      ),
    );
  }
}

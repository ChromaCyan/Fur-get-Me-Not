import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fur_get_me_not/app_splash/screens/splash_screen.dart';
import 'package:fur_get_me_not/config/app_theme.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_list/pet_repository.dart';
import 'package:fur_get_me_not/adopter/repositories/chat/chat_list_repository.dart';
import 'package:fur_get_me_not/adopter/repositories/chat/chat_repository.dart';
import 'package:fur_get_me_not/providers/provider.dart';
import 'package:fur_get_me_not/adopter/screens/reminder/reminder_form_screen.dart';

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
            .getProviders(),
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
        },
      ),
    );
  }
}

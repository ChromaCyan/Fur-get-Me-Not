import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fur_get_me_not/app_splash/screens/splash_screen.dart';
import 'package:fur_get_me_not/config/app_theme.dart';
import 'package:fur_get_me_not/providers/provider.dart';
import 'package:fur_get_me_not/adopter/screens/reminder/reminder_form_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:fur_get_me_not/adopter/screens/home_screen.dart';
import 'package:fur_get_me_not/adoptee/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'jwt');

  String? role;
  if (token != null) {
    try {
      final jwt = JWT.verify(token, SecretKey('my_super_secret_jwt_key_12345'));
      role = jwt.payload['role'];
    } catch (e) {
      print('Invalid token: $e');
    }
  }

  runApp(MyApp(isLoggedIn: token != null, role: role));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? role;

  const MyApp(
      {super.key, required this.isLoggedIn, this.role});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...AppProviders.getProviders(),
      ],
      child: MaterialApp(
        title: 'Fur-get Me Not',
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? _getHomeScreen(role) : const PetsOnBoardingScreen(),
        // Get home screen based on role
        routes: {
          '/add_reminder': (context) => AddReminderScreen(),
          // Route for adding reminders
        },
      ),
    );
  }

  // Function to return the appropriate home screen based on user role
  Widget _getHomeScreen(String? role) {
    if (role == 'adopter') {
      return AdopterHomeScreen();
    } else if (role == 'adoptee') {
      return AdopteeHomeScreen();
    } else {
      return const PetsOnBoardingScreen();
    }
  }
}

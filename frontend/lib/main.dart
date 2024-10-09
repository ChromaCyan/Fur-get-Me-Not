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
import 'package:fur_get_me_not/authentication/screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = FlutterSecureStorage();

  // Check if onboarding is completed
  String? hasCompletedOnboarding = await storage.read(key: 'onboarding_completed');
  String? token = await storage.read(key: 'jwt');
  String? role;

  // If token exists, verify it
  if (token != null) {
    try {
      final jwt = JWT.verify(token, SecretKey('my_super_secret_jwt_key_12345'));
      role = jwt.payload['role'];
    } catch (e) {
      print('Invalid token: $e');
    }
  }

  runApp(
    MyApp(
      isLoggedIn: token != null,
      role: role,
      hasCompletedOnboarding: hasCompletedOnboarding == 'true', // Check onboarding completion status
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? role;
  final bool hasCompletedOnboarding;

  const MyApp({
    super.key,
    required this.isLoggedIn,
    this.role,
    required this.hasCompletedOnboarding,
  });

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
        home: _getInitialScreen(), // Determine the initial screen
        routes: {
          '/add_reminder': (context) => AddReminderScreen(),
          // Other routes...
        },
      ),
    );
  }

  // Determine the initial screen based on onboarding, login, and role status
  Widget _getInitialScreen() {
    if (!hasCompletedOnboarding) {
      return PetsOnBoardingScreen(); // Show onboarding if not completed
    } else if (!isLoggedIn) {
      return LoginScreen(); // Show login screen if user is logged out
    } else {
      return _getHomeScreen(role); // Show home screen based on role
    }
  }

  // Return the appropriate home screen based on user role
  Widget _getHomeScreen(String? role) {
    if (role == 'adopter') {
      return AdopterHomeScreen();
    } else if (role == 'adoptee') {
      return AdopteeHomeScreen();
    } else {
      return LoginScreen(); // Fallback to login screen if role is unknown
    }
  }
}

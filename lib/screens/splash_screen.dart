import 'package:flutter/material.dart';
import 'package:fur_get_me_not/screens/register_screen.dart';
import 'package:fur_get_me_not/screens/login_screen.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or App Image
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://static.vecteezy.com/system/resources/previews/022/049/958/original/isolated-kitten-with-heart-on-a-white-background-drawn-character-cat-design-cute-hand-drawn-style-vector.jpg',
                  ),
                ),
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            const SizedBox(height: 24),
            // App Title
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Fur-get ',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 32,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Me Not',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 32,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            // Get Started Button
            ElevatedButton(
              onPressed: () {
                // Navigate to Register Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text('Get Started'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                textStyle: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Sign In Button
            GestureDetector(
              onTap: () {
                // Navigate to Login Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

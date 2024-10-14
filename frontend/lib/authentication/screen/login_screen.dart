import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fur_get_me_not/authentication/bloc/auth_bloc.dart';
import 'package:fur_get_me_not/authentication/bloc/auth_event.dart';
import 'package:fur_get_me_not/authentication/bloc/auth_state.dart';
import 'package:fur_get_me_not/authentication/repositories/auth_repository.dart';
import 'package:fur_get_me_not/adopter/screens/home_screen.dart';
import 'package:fur_get_me_not/adoptee/screens/home_screen.dart';
import 'package:fur_get_me_not/authentication/screen/register_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF21899C), Color(0xFFFE9879)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: BlocProvider(
            create: (context) => AuthBloc(authRepository: AuthRepository()),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  color: Colors.white.withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        logo(size.height / 10), // Adjusted logo height
                        SizedBox(height: size.height * 0.02),
                        richText(24),
                        SizedBox(height: size.height * 0.02),
                        emailTextField(),
                        SizedBox(height: size.height * 0.02),
                        passwordTextField(),
                        SizedBox(height: size.height * 0.03),
                        signInButton(context),
                        SizedBox(height: size.height * 0.02),
                        signInWithText(),
                        SizedBox(height: size.height * 0.02),
                        footerText(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logo(double height) {
    return SvgPicture.asset(
      'images/cat.svg',
      height: height,
    );
  }

  Widget richText(double fontSize) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: fontSize,
          color: const Color(0xFF21899C),
          letterSpacing: 3,
          height: 1.03,
        ),
        children: const [
          TextSpan(
              text: 'LOGIN ', style: TextStyle(fontWeight: FontWeight.w800)),
          TextSpan(
            text: 'PAGE ',
            style: TextStyle(
                color: Color(0xFFFE9879), fontWeight: FontWeight.w800),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget emailTextField() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1.0, color: const Color(0xFFEFEFEF)),
      ),
      child: TextField(
        controller: _emailController,
        style:
        GoogleFonts.inter(fontSize: 16.0, color: const Color(0xFF15224F)),
        maxLines: 1,
        cursorColor: const Color(0xFF15224F),
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle:
          GoogleFonts.inter(fontSize: 12.0, color: const Color(0xFF969AA8)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1.0, color: const Color(0xFFEFEFEF)),
      ),
      child: TextField(
        controller: _passwordController,
        style:
        GoogleFonts.inter(fontSize: 16.0, color: const Color(0xFF15224F)),
        maxLines: 1,
        obscureText: !_isPasswordVisible,
        cursorColor: const Color(0xFF15224F),
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle:
          GoogleFonts.inter(fontSize: 12.0, color: const Color(0xFF969AA8)),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xFF969AA8),
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget signInButton(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginSuccess) {
          final storage = FlutterSecureStorage();
          storage.write(key: 'jwt', value: state.token);
          print('Stored JWT: ${state.token}');

          if (state.role == "adopter") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AdopterHomeScreen()));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AdopteeHomeScreen()));
          }
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Container(
          alignment: Alignment.center,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: const Color(0xFF21899C),
          ),
          child: ElevatedButton(
            onPressed: () {
              final email = _emailController.text;
              final password = _passwordController.text;

              context
                  .read<AuthBloc>()
                  .add(LoginSubmitted(email: email, password: password));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
            child: Text(
              'Sign In',
              style: GoogleFonts.inter(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Widget signInWithText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(child: Divider()),
        const SizedBox(width: 16),
        Text(
          'Or Sign in with',
          style:
          GoogleFonts.inter(fontSize: 12.0, color: const Color(0xFF969AA8)),
        ),
        const SizedBox(width: 16),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget footerText(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Don't have an account yet?"),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
            },
            child: const Text('Create Account'),
          ),
        ],
      ),
    );
  }
}

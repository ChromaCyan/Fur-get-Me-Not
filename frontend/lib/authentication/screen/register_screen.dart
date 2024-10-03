import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fur_get_me_not/authentication/bloc/register/register_bloc.dart';
import 'package:fur_get_me_not/authentication/bloc/register/register_event.dart';
import 'package:fur_get_me_not/authentication/bloc/register/register_state.dart';
import 'package:fur_get_me_not/authentication/repositories/register_repository.dart';
import 'package:fur_get_me_not/authentication/screen/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => RegisterBloc(registerRepository: RegisterRepository()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  logo(size.height / 8),
                  SizedBox(height: size.height * 0.03),
                  richText(24),
                  SizedBox(height: size.height * 0.03),
                  fullNameTextField(),
                  SizedBox(height: size.height * 0.02),
                  emailTextField(),
                  SizedBox(height: size.height * 0.02),
                  passwordTextField(),
                  SizedBox(height: size.height * 0.02),
                  confirmPasswordTextField(),
                  SizedBox(height: size.height * 0.03),
                  registerButton(context),
                  SizedBox(height: size.height * 0.02),
                  footerText(context),
                ],
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
          TextSpan(text: 'REGISTER ', style: TextStyle(fontWeight: FontWeight.w800)),
          TextSpan(text: 'PAGE ', style: TextStyle(color: Color(0xFFFE9879), fontWeight: FontWeight.w800)),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget fullNameTextField() {
    return inputField(
      controller: _fullNameController,
      labelText: 'Full Name',
    );
  }

  Widget emailTextField() {
    return inputField(
      controller: _emailController,
      labelText: 'Email',
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget passwordTextField() {
    return inputField(
      controller: _passwordController,
      labelText: 'Password',
      obscureText: true,
    );
  }

  Widget confirmPasswordTextField() {
    return inputField(
      controller: _confirmPasswordController,
      labelText: 'Confirm Password',
      obscureText: true,
      validator: (value) {
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget inputField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1.0, color: const Color(0xFFEFEFEF)),
      ),
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.inter(fontSize: 16.0, color: const Color(0xFF15224F)),
        maxLines: 1,
        cursorColor: const Color(0xFF15224F),
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.inter(fontSize: 12.0, color: const Color(0xFF969AA8)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget registerButton(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        if (state is RegisterLoading) {
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
              if (state is! RegisterLoading) {
                context.read<RegisterBloc>().add(
                  RegisterSubmitted(
                    fullName: _fullNameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
            child: Text(
              'Register',
              style: GoogleFonts.inter(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget footerText(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Already have an account?"),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

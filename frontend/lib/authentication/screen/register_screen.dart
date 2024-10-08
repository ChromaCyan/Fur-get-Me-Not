import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fur_get_me_not/authentication/bloc/auth_bloc.dart';
import 'package:fur_get_me_not/authentication/bloc/auth_event.dart';
import 'package:fur_get_me_not/authentication/bloc/auth_state.dart';
import 'package:fur_get_me_not/authentication/repositories/auth_repository.dart';
import 'package:fur_get_me_not/authentication/screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Variables to toggle visibility of passwords
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String _selectedRole = 'adopter'; // Default role

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AuthBloc(authRepository: AuthRepository()),
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
                  SizedBox(height: size.height * 0.02),
                  roleDropdown(),
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
          TextSpan(
              text: 'REGISTER ', style: TextStyle(fontWeight: FontWeight.w800)),
          TextSpan(
              text: 'PAGE ',
              style: TextStyle(
                  color: Color(0xFFFE9879), fontWeight: FontWeight.w800)),
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
      obscureText: !_isPasswordVisible,
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
    );
  }

  Widget confirmPasswordTextField() {
    return inputField(
      controller: _confirmPasswordController,
      labelText: 'Confirm Password',
      obscureText: !_isConfirmPasswordVisible,
      suffixIcon: IconButton(
        icon: Icon(
          _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: const Color(0xFF969AA8),
        ),
        onPressed: () {
          setState(() {
            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
          });
        },
      ),
    );
  }

  Widget roleDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1.0, color: const Color(0xFFEFEFEF)),
      ),
      child: DropdownButton<String>(
        value: _selectedRole,
        items: <String>['adopter', 'adoptee'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value[0].toUpperCase() +
                  value.substring(1), // Capitalize first letter
              style: GoogleFonts.inter(
                  fontSize: 16.0, color: const Color(0xFF15224F)),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedRole = newValue!;
          });
        },
        isExpanded: true,
        underline: SizedBox(), // Remove the underline
      ),
    );
  }

  Widget inputField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
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
        style:
            GoogleFonts.inter(fontSize: 16.0, color: const Color(0xFF15224F)),
        maxLines: 1,
        cursorColor: const Color(0xFF15224F),
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle:
              GoogleFonts.inter(fontSize: 12.0, color: const Color(0xFF969AA8)),
          border: InputBorder.none,
          suffixIcon: suffixIcon, // Add suffix icon if provided
        ),
      ),
    );
  }

  Widget registerButton(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('User registered!')));

          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          });
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
              if (_passwordController.text != _confirmPasswordController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Passwords do not match!')));
                return;
              }

              final fullName = _fullNameController.text.split(' ');
              String firstName = fullName.isNotEmpty ? fullName[0] : '';
              String lastName =
                  fullName.length > 1 ? fullName.sublist(1).join(' ') : '';

              if (_fullNameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill up Full Name')));
              } else if (_emailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill up Email')));
              } else if (_passwordController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill up Password')));
              } else if (_confirmPasswordController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill up Confirm Password')));
              } else if (lastName.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill up Last Name')));
              } else {
                context.read<AuthBloc>().add(
                      RegisterSubmitted(
                        firstName: firstName,
                        lastName: lastName,
                        email: _emailController.text,
                        password: _passwordController.text,
                        role: _selectedRole,
                      ),
                    );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
            child: Text(
              'Register',
              style: GoogleFonts.inter(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.5),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}

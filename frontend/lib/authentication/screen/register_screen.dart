import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fur_get_me_not/authentication/bloc/auth_bloc.dart';
import 'package:fur_get_me_not/authentication/bloc/auth_event.dart';
import 'package:fur_get_me_not/authentication/bloc/auth_state.dart';
import 'package:fur_get_me_not/authentication/repositories/auth_repository.dart';
import 'package:fur_get_me_not/authentication/screen/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String _selectedRole = 'adopter';
  // final ImagePicker _picker = ImagePicker();
  File? _profileImage;

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
                    borderRadius: BorderRadius.circular(40),
                  ),
                  color: Colors.white.withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        logo(size.height / 10),
                        SizedBox(height: size.height * 0.02),
                        richText(24),
                        SizedBox(height: size.height * 0.02),
                        // profilePictureWidget(),
                        SizedBox(height: size.height * 0.03),
                        fullNameTextField(),
                        SizedBox(height: size.height * 0.02),
                        emailTextField(),
                        SizedBox(height: size.height * 0.02),
                        passwordTextField(),
                        SizedBox(height: size.height * 0.02),
                        confirmPasswordTextField(),
                        SizedBox(height: size.height * 0.02),
                        addressTextField(),
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

  // Widget profilePictureWidget() {
  //   return GestureDetector(
  //     onTap: () async {
  //       final ImagePicker _picker = ImagePicker();
  //       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //
  //       setState(() {
  //         // Convert XFile to File
  //         _profileImage = image != null ? File(image!.path) : null;
  //       });
  //     },
  //     child: CircleAvatar(
  //       radius: 50,
  //       backgroundColor: Colors.grey[300],
  //       backgroundImage: _profileImage != null
  //           ? FileImage(File(_profileImage!.path))
  //           : null,
  //       child: _profileImage == null
  //           ? Icon(Icons.camera_alt, color: Colors.white)
  //           : null,
  //     ),
  //   );
  // }

  Widget richText(double fontSize) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: fontSize,
          color: const Color(0xFF15224F),
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

  Widget addressTextField() {
    return inputField(
      controller: _addressController,
      labelText: 'Address',
      obscureText: false,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
              value[0].toUpperCase() + value.substring(1),
              style: GoogleFonts.inter(fontSize: 16.0, color: const Color(0xFF15224F)),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedRole = newValue!;
          });
        },
        isExpanded: true,
        underline: SizedBox(),
      ),
    );
  }

  Widget inputField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1.0, color: const Color(0xFFEFEFEF)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.inter(fontSize: 16.0, color: const Color(0xFF15224F)),
        maxLines: 1,
        cursorColor: const Color(0xFF15224F),
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.inter(fontSize: 14.0, color: const Color(0xFF969AA8)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  Widget registerButton(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpSent) {
          // Display success message for registration
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('🐾 User registered! OTP has been sent. 🐶')),
          );

          // Navigate to the OTP screen; OTP has already been sent in the registration logic
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OtpScreen(email: state.email)),
          );
        } else if (state is AuthFailure) {
          SnackBar(content: Text('🐾 Having Problems creating your account. 🐶'));
        }
      },
  builder: (context, state) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          child: ElevatedButton(
            onPressed: state is AuthLoading
                // s
                ? null
                : () async {
              // try {
              //   // Upload the profile image
              //   if (_profileImage == null) {
              //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a profile image')));
              //     return;
              //   }
              //
              //   String? imageUrl = await AuthRepository().uploadProfileImage(_profileImage!);
              //
              //   if (imageUrl == null) {
              //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload profile image')));
              //     return;
              //   }

                // Proceed with registration
                final fullName = _fullNameController.text.trim().split(' ');
                String firstName = fullName.isNotEmpty ? fullName[0] : '';
                String lastName = fullName.length > 1 ? fullName.sublist(1).join(' ') : '';

                if (_fullNameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill up Full Name')));
                  return;
                } else if (_emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill up Email')));
                  return;
                } else if (_passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill up Password')));
                  return;
                } else if (_confirmPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill up Confirm Password')));
                  return;
                } else if (_selectedRole.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select Role')));
                  return;
                } else if (_addressController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill up Address')));
                  return;
                }

                context.read<AuthBloc>().add(
                  RegisterSubmitted(
                    // profileImage: imageUrl!,
                    context: context,
                    firstName: firstName,
                    lastName: lastName,
                    email: _emailController.text,
                    password: _passwordController.text,
                    role: _selectedRole,
                    address: _addressController.text,
                  ),
                );
              // } catch (e) {
              //   print('Error during registration: ${e.toString()}');
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred during registration: ${e.toString()}')));
              // }
            },
             style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              fixedSize: Size(240, 60),
            ),
            child: state is AuthLoading ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.5,
              ),
            ) : Text(
              'Register',
              style: GoogleFonts.inter(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
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
          const Text(
            "Already have an account?",
            style: TextStyle(color: Color(0xFF15224F)),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const Text(
              'Sign In',
              style: TextStyle(color: Color(0xFFFE9879)),
            ),
          ),
        ],
      ),
    );
  }
}
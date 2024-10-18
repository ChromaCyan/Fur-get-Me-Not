import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fur_get_me_not/authentication/bloc/auth_bloc.dart';
import 'package:fur_get_me_not/authentication/bloc/auth_event.dart';
import 'package:fur_get_me_not/authentication/bloc/auth_state.dart';
import 'package:fur_get_me_not/authentication/repositories/auth_repository.dart';
import 'package:fur_get_me_not/authentication/screen/login_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

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
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
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
                        otpTextField(),
                        SizedBox(height: size.height * 0.03),
                        verifyOtpButton(context),
                        SizedBox(height: size.height * 0.02),
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
      'images/cat.svg', // Can be customized
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
              text: 'OTP ', style: TextStyle(fontWeight: FontWeight.w800)),
          TextSpan(
            text: 'VERIFICATION',
            style: TextStyle(
                color: Color(0xFFFE9879), fontWeight: FontWeight.w800),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget otpTextField() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1.0, color: const Color(0xFFEFEFEF)),
      ),
      child: TextField(
        controller: _otpController,
        keyboardType: TextInputType.number,
        style: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF15224F),
        ),
        maxLines: 1,
        cursorColor: const Color(0xFF15224F),
        decoration: InputDecoration(
          labelText: 'Enter OTP',
          labelStyle: GoogleFonts.inter(
            fontSize: 12.0,
            color: const Color(0xFF969AA8),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget verifyOtpButton(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpVerificationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('🐾 OTP successfully verified! 😺')),
          );

          Future.delayed(const Duration(seconds: 4), () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          });
        } else if (state is AuthOtpVerificationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('🐾 Incorrect OTP, Please try again 😿')),
          );
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
              final otp = _otpController.text;

              if (otp.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter the OTP.')),
                );
                return;
              }

              context.read<AuthBloc>().add(
                OtpSubmitted(email: widget.email, otp: otp),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text(
              'Verify OTP',
              style: GoogleFonts.inter(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
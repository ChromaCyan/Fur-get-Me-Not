import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:fur_get_me_not/authentication/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:fur_get_me_not/authentication/screen/otp_screen.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<OtpSubmitted>(_onOtpSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.login(
          email: event.email, password: event.password);
      if (result['success']) {
        emit(AuthLoginSuccess(
            result['userId'], result['token'], result['role']));
      } else {
        emit(AuthFailure(error: 'Invalid email or password'));
      }
    } catch (error) {
      emit(AuthFailure(error: error.toString()));
    }
  }

  Future<void> _onOtpSubmitted(
      OtpSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.verifyOtp(
        email: event.email,
        otp: event.otp,
      );

      if (result['success']) {
        emit(AuthOtpVerificationSuccess());
      } else {
        final errorMessage = result['message'] ?? 'OTP verification failed';
        emit(AuthOtpVerificationFailure(error: errorMessage));
      }
    } catch (error) {
      emit(AuthOtpVerificationFailure(error: error.toString()));
    }
  }

  Future<void> _onRegisterSubmitted(
      RegisterSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Call the register method in AuthRepository
      await authRepository.register(
        context: event.context,
        profileImage: event.profileImage,
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        role: event.role,
        address: event.address,
      );

      Navigator.push(
        event.context,
        MaterialPageRoute(builder: (context) => OtpScreen(email: event.email)),
      );
      emit(AuthOtpSent(event.email));
    } catch (error) {
      emit(AuthFailure(error: error.toString()));
    }
  }
}

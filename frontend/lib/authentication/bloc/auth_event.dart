import 'dart:io';
import 'package:flutter/material.dart';

abstract class AuthEvent {}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});
}

class SendOtp extends AuthEvent {
  final String email;

  SendOtp({required this.email});
}

class OtpSubmitted extends AuthEvent {
  final String email;
  final String otp;

  OtpSubmitted({required this.email, required this.otp});
}

class RegisterSubmitted extends AuthEvent {
  final BuildContext context;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String address;
  final String role;
  final String? profileImage;

  RegisterSubmitted({
    required this.context,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    required this.address,
    this.profileImage,
  });
}

// lib/repositories/register_repository.dart

import 'dart:async';
import 'package:fur_get_me_not/models/user.dart';

class RegisterRepository {
  Future<User> registerUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    print('User registered with fullName: $fullName, email: $email');

    // Return a dummy User object
    return User(
      id: 'dummy-id',
      fullName: fullName,
      email: email,
      password: password,
    );
  }
}

import 'dart:async';

class UserRepository {
  // Simulates user registration
  Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    // Simulating network delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate successful registration
    return {
      'success': true,
      'message': 'User registered successfully!',
    };

    // Uncomment the following to simulate a failure
    // return {
    //   'success': false,
    //   'error': 'Failed to register user',
    // };
  }
}

import 'package:fur_get_me_not/authentication/models/user.dart';

class LoginRepository {
  // Dummy data for now
  final List<User> _dummyUsers = [
    User(id: 'dummy-id', fullName: 'josh',email: '456', password: '456', userType: 0), // Adoptee
    User(id: 'dummy-id2', fullName: 'bogart', email: '123', password: '123', userType: 1), // Adopter
  ];

  Future<Map<String, dynamic>> login({required String email, required String password}) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));

    // Check for matching user
    for (var user in _dummyUsers) {
      if (user.email == email && user.password == password) {
        return {'success': true, 'userType': user.userType}; // Return userType
      }
    }
    return {'success': false}; // Login failed
  }
}

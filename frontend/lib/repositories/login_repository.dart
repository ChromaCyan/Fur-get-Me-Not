class LoginRepository {
  // Dummy data for now
  final String _dummyEmail = '123';
  final String _dummyPassword = '123';

  Future<bool> login({required String email, required String password}) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));

    // Check if email and password match dummy data
    if (email == _dummyEmail && password == _dummyPassword) {
      return true; // Login success
    }
    return false; // Login failed
  }
}

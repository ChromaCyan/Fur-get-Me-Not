import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  final String baseUrl = 'http://localhost:5000/users';

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'userId': data['userId'],
          'token': data['token'],
          'role': data['role'],
        };
      } else {
        // Log the response status and body for debugging
        print('Login failed: ${response.statusCode}, ${response.body}');
        return {'success': false, 'message': response.body};
      }
    } catch (e) {
      // Log the error for debugging
      print('Login error: ${e.toString()}');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          'role': role,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 201) {
        // Log the response status and body for debugging
        print('Registration failed: ${response.statusCode}, ${response.body}');
        throw Exception('Failed to register user: ${response.body}');
      }
    } catch (e) {
      // Log the error for debugging
      print('Registration error: ${e.toString()}');
      throw Exception('Failed to register: ${e.toString()}');
    }
  }
}
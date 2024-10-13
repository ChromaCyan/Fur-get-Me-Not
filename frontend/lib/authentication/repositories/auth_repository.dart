import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';

class AuthRepository {
  final String baseUrl = 'http://192.168.18.239:5000/users';

  final FlutterSecureStorage storage = FlutterSecureStorage();

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
        await storage.write(key: 'jwt', value: data['token']); // Save the token
        return {
          'success': true,
          'userId': data['userId'],
          'token': data['token'],
          'role': data['role'],
        };
      } else {
        print('Login failed: ${response.statusCode}, ${response.body}');
        return {'success': false, 'message': response.body};
      }
    } catch (e) {
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
    required String address,
    File? profileImage,
  }) async {
    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/register'));

      // Add the fields
      request.fields['firstName'] = firstName;
      request.fields['lastName'] = lastName;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['role'] = role;
      request.fields['address'] = address;

      // Add the file if it exists
      if (profileImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profileImage', // The name of the field in the backend
          profileImage.path,
        ));
      }

      // Send the request
      final response = await request.send();

      // Get the response from the server
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode != 201) {
        print('Registration failed: ${response.statusCode}, ${responseData.body}');
        throw Exception('Failed to register user: ${responseData.body}');
      }
    } catch (e) {
      print('Registration error: ${e.toString()}');
      throw Exception('Failed to register: ${e.toString()}');
    }
  }

  Future<void> updateProfile({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required String address,
    File? profileImage,
  }) async {
    try {
      // Create a multipart request
      var request = http.MultipartRequest('PUT', Uri.parse('$baseUrl/profile/$userId'));

      // Add the fields
      request.fields['firstName'] = firstName;
      request.fields['lastName'] = lastName;
      request.fields['email'] = email;
      request.fields['address'] = address;

      // Retrieve the JWT token
      final token = await storage.read(key: 'jwt');

      // Add the token to the headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add the file if it exists
      if (profileImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profileImage',
          profileImage.path,
        ));
      }

      // Send the request
      final response = await request.send();

      // Get the response from the server
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode != 200) {
        print('Update failed: ${response.statusCode}, ${responseData.body}');
        throw Exception('Failed to update profile: ${responseData.body}');
      }
    } catch (e) {
      print('Update profile error: ${e.toString()}');
      throw Exception('Failed to update profile: ${e.toString()}');
    }
  }
}
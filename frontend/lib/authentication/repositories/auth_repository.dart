import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fur_get_me_not/authentication/screen/otp_screen.dart';

class AuthRepository {
  final String baseUrl = 'http://localhost:5000/users';
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
        await storage.write(key: 'jwt', value: data['token']);
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

  Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify-otp'),
        body: jsonEncode({
          'email': email,
          'otp': otp,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
        };
      } else {
        return {'success': false, 'message': response.body};
      }
    } catch (e) {
      print('OTP verification error: ${e.toString()}');
      return {'success': false, 'message': e.toString()};
    }
  }


  Future<void> register({
    required BuildContext context,
    required String? profileImage,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String role,
    required String address,
  }) async {
    String? imageUrl;

    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/register'));

      // Add the fields to the request
      request.fields['firstName'] = firstName;
      request.fields['lastName'] = lastName;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['role'] = role;
      request.fields['address'] = address;

      // Add the file if it exists
      if (profileImage != null) {
        request.files.add(await http.MultipartFile.fromPath('profileImage', profileImage));
      }

      // Send the request
      final response = await request.send();

      // Get the response from the server
      final responseData = await http.Response.fromStream(response);

      // Check the status code
      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        return;
      } else {
        print('Registration failed: ${responseData.statusCode}, ${responseData.body}');
        throw Exception('Failed to register user: ${responseData.body}');
      }
    } catch (e) {
      print('Registration error: ${e.toString()}');
      throw Exception('Failed to register: ${e.toString()}');
    }
  }

  // Function to upload profile image
  Future<String> uploadProfileImage(File? profileImage) async {
    if (profileImage == null) {
      throw Exception('Profile image is null. Please select an image.');
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload'));

      // Add the file to the request
      request.files.add(await http.MultipartFile.fromPath(
        'profileImage',
        profileImage.path,
      ));

      // Retrieve the JWT token
      final token = await storage.read(key: 'jwt');
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Send the request
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode != 200) {
        print(
            'Image upload failed: ${response.statusCode}, ${responseData.body}');
        throw Exception('Failed to upload profile image: ${responseData.body}');
      }

      // Assuming the server responds with the image URL in the response body
      final Map<String, dynamic> responseBody = jsonDecode(responseData.body);
      return responseBody[
          'imageUrl']; // Replace 'imageUrl' with your actual key
    } catch (e) {
      print('Profile image upload error: ${e.toString()}');
      throw Exception('Failed to upload profile image: ${e.toString()}');
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
      // Create a multipart request for user profile update
      var request =
          http.MultipartRequest('PUT', Uri.parse('$baseUrl/profile/$userId'));

      // Add the fields
      request.fields['firstName'] = firstName;
      request.fields['lastName'] = lastName;
      request.fields['email'] = email;
      request.fields['address'] = address;

      // Retrieve the JWT token
      final token = await storage.read(key: 'jwt');

      // Add the token to the headers
      request.headers['Authorization'] = 'Bearer $token';

      // If there's a profile image, upload it separately
      if (profileImage != null) {
        await uploadProfileImage(profileImage);
      }

      // Send the request
      final response = await request.send();
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

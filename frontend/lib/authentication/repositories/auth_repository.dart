import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AuthRepository {
  final String baseUrl = 'http://192.168.18.239:5000/users';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt');
  }

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
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/register'));

      // Add the fields to the request
      request.fields['firstName'] = firstName;
      request.fields['lastName'] = lastName;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['role'] = role;
      request.fields['address'] = address;

      // Add the file if it exists
      if (profileImage != null) {
        request.files.add(
            await http.MultipartFile.fromPath('profileImage', profileImage));
      }

      // Send the request
      final response = await request.send();

      // Get the response from the server
      final responseData = await http.Response.fromStream(response);

      // Check the status code
      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        return;
      } else {
        print(
            'Registration failed: ${responseData.statusCode}, ${responseData.body}');
        throw Exception('Failed to register user: ${responseData.body}');
      }
    } catch (e) {
      print('Registration error: ${e.toString()}');
      throw Exception('Failed to register: ${e.toString()}');
    }
  }

  // Upload profile image
  Future<String> uploadProfileImage(File image) async {
    print('Uploading profile image to: $baseUrl/upload-profile-image');
    try {
      final token = await getToken(); // Get JWT token
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/upload'),
      );

      // Add the image file to the request
      request.files.add(await http.MultipartFile.fromPath(
        'profileImage',
        image.path,
        filename: basename(image.path),
      ));

      request.headers['Authorization'] = 'Bearer $token';

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final result = String.fromCharCodes(responseData);
        final imageUrl = json.decode(result)['imageUrl'];
        return imageUrl;
      } else {
        throw Exception('Profile image upload failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }

  Future<void> updateUserProfile({
    required String userId,
    required String firstName,
    required String lastName,
    required String address,
    File? image,
  }) async {
    try {
      final token = await getToken();

      // Create a request
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/profile/$userId'),
      );

      // Add the authorization header
      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields
      request.fields['firstName'] = firstName;
      request.fields['lastName'] = lastName;
      request.fields['address'] = address;

      // If an image is provided, add it to the request
      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profileImage', // This must match the field name in multer
          image.path,
          filename: basename(image.path),
        ));
      }

      // Send the request
      final response = await request.send();

      if (response.statusCode != 200) {
        final responseBody = await response.stream.bytesToString();
        throw Exception('Failed to update profile: ${response.reasonPhrase} - $responseBody');
      }
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<Map<String, dynamic>> getProfileById(String userId) async {
    try {
      final token = await storage.read(key: 'jwt');
      final response = await http.get(
        Uri.parse('$baseUrl/profile/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'profile': data,
        };
      } else {
        print(
            'Failed to fetch profile: ${response.statusCode}, ${response.body}');
        return {
          'success': false,
          'message': response.body,
        };
      }
    } catch (e) {
      print('Get profile error: ${e.toString()}');
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}

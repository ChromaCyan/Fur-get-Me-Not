import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fur_get_me_not/adopter/models/adoption_status/adoption_status.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdoptionStatusRepository {
  final String baseUrl = 'http://localhost:5000/adoption'; // Make sure this is correct
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt');
  }

  Future<List<AdoptionStatus>> fetchAdoptions() async {
    try {
      final token = await getToken();
      print('Token: $token');

      // Ensure to handle the case where the token might be null
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/adoption-status'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Move the status check inside the try block
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((data) => AdoptionStatus.fromJson(data))
            .toList();
      } else {
        // Log the response body for debugging
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load adoption statuses: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle any other errors (like network issues)
      print('Error fetching adoption statuses: $error');
      throw Exception('Error fetching adoption statuses');
    }
  }
}

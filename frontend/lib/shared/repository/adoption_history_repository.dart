import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fur_get_me_not/shared/models/adoption_history.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdoptionHistoryRepository {
  final String baseUrl = 'http://192.168.18.235:5000/adoption';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt');
  }

  // Fetch adoption history for the logged-in user (adopter or adoptee)
  Future<List<AdoptionHistory>> fetchAdoptionHistory() async {
    try {
      final token = await getToken();
      print('Token: $token');

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/adoption-history'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((data) => AdoptionHistory.fromJson(data))
            .toList();
      } else {
        throw Exception('Failed to load adoption history: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching adoption history: $error');
      throw Exception('Error fetching adoption history');
    }
  }
}

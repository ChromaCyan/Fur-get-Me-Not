import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fur_get_me_not/adoptee/models/adoption_request/adoption_request.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdoptionRequestRepository {
  final String baseUrl = 'http://192.168.244.108:5000/adoption';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt');
  }

  Future<List<AdoptionRequest>> fetchAdoptionRequests() async {
    try {
      final token = await getToken();
      print('Token: $token');

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/adoption-request'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((data) => AdoptionRequest.fromJson(data))
            .toList();
      } else {
        throw Exception(
            'Failed to load adoption requests: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching adoption requests: $error');
      throw Exception('Error fetching adoption requests');
    }
  }

  Future<void> updateAdoptionRequestStatus(
      String requestId, AdoptionRequest request, String newStatus) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.put(
        Uri.parse('$baseUrl/update-status'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'requestId': requestId, // Use the requestId here
          'status': newStatus,
        }),
      );

      if (response.statusCode != 200) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception(
            'Failed to update adoption request status: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error updating adoption request status: $error');
      throw Exception('Error updating adoption request status');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fur_get_me_not/adopter/models/adoption_list/adoption_form.dart';

class AdoptionFormRepository {
  final String baseUrl = 'http://192.168.115.106:5000/adoption';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<bool> submitAdoptionForm(AdoptionFormModel adoptionForm) async {
    try {
      final token = await storage.read(key: 'jwt');
      final response = await http.post(
        Uri.parse('$baseUrl/adoption-form'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(adoptionForm.toJson()),
      );

      // Print the request details
      print('Submitting adoption form with data: ${adoptionForm.toJson()}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return response.statusCode == 201;
    } catch (e) {
      print('Error submitting adoption form: $e');
      return false;
    }
  }
}

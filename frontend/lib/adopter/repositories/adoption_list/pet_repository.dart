import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fur_get_me_not/adopter/models/adoption_list/pet.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PetRepository {
  final String baseUrl = 'http://192.168.100.130:5000/pets';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt');
  }

  // Fetch available pets
  Future<List<Pet>> getAvailablePets() async {
    try {
      final token = await getToken();
      print('Token: $token');

      final response = await http.get(
        Uri.parse('$baseUrl/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        List jsonData = jsonDecode(response.body) as List;
        return jsonData.map((pet) => Pet.fromJson(pet)).toList();
      } else {
        throw Exception('Failed to load pets: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to fetch pets: $e');
    }
  }

  // Fetch pet details by ID (including image URL)
  Future<Pet> getPetDetails(String id) async {
    try {
      final token = await getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Decode and return a single Pet object
        final jsonData = jsonDecode(response.body);
        return Pet.fromJson(jsonData);
      } else {
        throw Exception('Failed to load pet details');
      }
    } catch (e) {
      throw Exception('Failed to fetch pet details: $e');
    }
  }
}

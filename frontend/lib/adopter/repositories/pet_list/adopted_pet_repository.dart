import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fur_get_me_not/adopter/models/pet_list/adopted_pet.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdoptedPetRepository {
  final String baseUrl = 'http://192.168.18.235:5000/adopted-pets';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt');
  }

  // Fetch all adopted pets
  Future<List<AdoptedPet>> getAllAdoptedPets() async {
    try {
      final token = await getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/my-adopted-pets'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        List jsonData = jsonDecode(response.body) as List;
        return jsonData
            .map((pet) => AdoptedPet.fromJson(pet))
            .toList(); // Use AdoptedPet here
      } else {
        print(response.body);
        throw Exception(
            'Failed to load adopted pets: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to fetch adopted pets: $e');
    }
  }

  // Fetch pet details by ID
  Future<AdoptedPet> getPetDetails(String petId) async {
    try {
      final token = await getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/$petId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return AdoptedPet.fromJson(jsonData);
      } else {
        throw Exception('Failed to load adopted pet details');
      }
    } catch (e) {
      throw Exception('Failed to fetch adopted pet details: $e');
    }
  }

  // Update an adopted pet
  Future<void> updateAdoptedPet(String petId, AdoptedPet updatedPet) async {
    try {
      final token = await getToken();
      final response = await http.put(
        Uri.parse('$baseUrl/$petId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body:
            jsonEncode(updatedPet.toJson()), // Convert the updated pet to JSON
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to update adopted pet: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to update adopted pet: $e');
    }
  }

  // Archive (soft delete) an adopted pet
  Future<void> archiveAdoptedPet(String petId) async {
    try {
      final token = await getToken();
      final response = await http.patch(
        Uri.parse('$baseUrl/$petId/archive'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'status': 'Archived'}),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to archive adopted pet: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to archive adopted pet: $e');
    }
  }
}

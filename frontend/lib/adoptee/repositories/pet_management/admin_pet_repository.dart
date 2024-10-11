import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdminPetRepository {
  final String baseUrl = 'http://localhost:5000/pets';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt');
  }

  // Fetch pets of adoptee only
  Future<List<AdminPet>> getAvailablePets() async {
    try {
      final token = await getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/my-pets'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List jsonData = jsonDecode(response.body) as List;
        return jsonData.map((pet) => AdminPet.fromJson(pet)).toList();
      } else {
        throw Exception('Failed to load pets: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to fetch pets: $e');
    }
  }

  // Add a new pet
  Future<void> addPet(AdminPet pet) async {
    try {
      final token = await getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/add-pet'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(pet.toJson()), // Convert Pet object to JSON
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add pet: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to add pet: $e');
    }
  }

  // Update an existing pet
  Future<void> updatePet(AdminPet pet) async {
    try {
      final token = await getToken();
      final response = await http.put(
        Uri.parse('$baseUrl/${pet.id}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(pet.toJson()), // Convert Pet object to JSON
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update pet: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to update pet: $e');
    }
  }

  // Fetch user's pets
  Future<List<AdminPet>> getUserPets() async {
    try {
      final token = await getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/my-pets'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List jsonData = jsonDecode(response.body) as List;
        return jsonData.map((pet) => AdminPet.fromJson(pet)).toList();
      } else {
        throw Exception('Failed to load user pets: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to fetch user pets: $e');
    }
  }

  // Delete a pet by ID
  Future<void> deletePet(String petId) async {
    try {
      final token = await getToken();
      final response = await http.delete(
        Uri.parse('$baseUrl/$petId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete pet: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to delete pet: $e');
    }
  }

  // Fetch pet details by ID
  Future<AdminPet> getPetDetails(String id) async {
    try {
      final token = await getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return AdminPet.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load pet details: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to fetch pet details: $e');
    }
  }
}

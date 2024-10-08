import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fur_get_me_not/adoptee/models/adoption_request/pet.dart';

class PetRepository {
  final String baseUrl = 'http://<your-backend-url>/pets';

  Future<List<Pet>> getPets() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> petData = json.decode(response.body);
      return petData.map((json) => Pet.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pets');
    }
  }

  Future<Pet> getPetDetails(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Pet.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pet details');
    }
  }

  Future<Pet> createPet(Pet pet) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_pet'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pet.toJson()),
    );
    if (response.statusCode == 201) {
      return Pet.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create pet');
    }
  }

  Future<void> updatePet(String id, Pet pet) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update pet');
    }
  }

  Future<void> deletePet(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete pet');
    }
  }

  Future<String> uploadVaccineHistory(File file) async {
    final request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/add_vaccine'));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    final response = await request.send();
    if (response.statusCode == 201) {
      final respStr = await response.stream.bytesToString();
      return json.decode(respStr)['imageUrl'];
    } else {
      throw Exception('Failed to upload vaccine history');
    }
  }

  Future<String> uploadMedicalHistory(File file) async {
    final request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/add_medical'));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    final response = await request.send();
    if (response.statusCode == 201) {
      final respStr = await response.stream.bytesToString();
      return json.decode(respStr)['imageUrl'];
    } else {
      throw Exception('Failed to upload medical history');
    }
  }
}

import 'dart:convert';
import 'dart:io'; // Add this import for File handling
import 'package:http/http.dart' as http;
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart';


class AdminPetRepository {
  final String baseUrl = 'http://192.168.18.239:5000/pets';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt');
  }

  // Upload pet image
  Future<String> uploadImage(File image) async {
    print('Uploading image to: $baseUrl/upload-image');
    try {
      final token = await getToken();
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/upload-image'),
      );

      // Add the image file to the request
      request.files.add(await http.MultipartFile.fromPath(
        'petImage',
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
        throw Exception('Image upload failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
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
  Future<void> addPet(AdminPet pet, File image) async {
    try {
      // Upload the image and get the image URL
      print('Uploading image...');
      String imageUrl = await uploadImage(image);
      print('Image URL obtained: $imageUrl');

      pet.petImageUrl = imageUrl;


      final token = await getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/add-pet'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(pet.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add pet: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to add pet: $e');
    }
  }


  // Update an existing pet
  Future<void> updatePet(AdminPet pet, {File? image}) async {
    try {
      final token = await getToken();

      if (image != null) {
        String imageUrl = await uploadImage(image);
        pet.petImageUrl = imageUrl;
      }

      final response = await http.put(
        Uri.parse('$baseUrl/${pet.id}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(pet.toJson()),
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

  // Update pet status to 'removed' by ID (Soft Delete)
  Future<void> removePet(String petId) async {
    try {
      final token = await getToken();
      final response = await http.put(
        Uri.parse('$baseUrl/$petId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'status': 'removed'}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to remove pet: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to remove pet: $e');
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

import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fur_get_me_not/adoptee/models/pet_management/pet.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Comment in mobile
import 'dart:html' as html; // Comment in mobile
import 'package:path/path.dart';

class AdminPetRepository {
  final String baseUrl = 'http://localhost:5000/pets';

  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt');
  }

  Future<void> downloadExcel() async {
    try {
      final token = await getToken();
      final response = await _dio.get(
        '$baseUrl/export-excel',
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        String filePath;
        // Comment in web ==========
        // // Mobile implementation: Get the downloads directory
        // final Directory downloadsDirectory =
        //     await getApplicationDocumentsDirectory();
        // filePath = '${downloadsDirectory.path}/pet_table.xlsx';

        // // Save the file
        // final File file = File(filePath);
        // await file.writeAsBytes(response.data);

        // print('Excel file downloaded at: $filePath');
        // ============

        // Comment in mobile ==========
        if (kIsWeb) {
          final blob = html.Blob([response.data]);
          final url = html.Url.createObjectUrlFromBlob(blob);

          final anchor = html.AnchorElement(href: url)
            ..setAttribute('download', 'pet_table.xlsx')
            ..click();

          html.Url.revokeObjectUrl(url);
          print('Excel file downloaded for web');
          return;
        }
        // ============
        
        // Comment in web ==========
        //else {
        // // Mobile implementation: Get the downloads directory
        // final Directory downloadsDirectory = await getApplicationDocumentsDirectory();
        // filePath = '${downloadsDirectory.path}/pet_table.xlsx';
        //
        // // Save the file
        // final File file = File(filePath);
        // await file.writeAsBytes(response.data);
        //
        // print('Excel file downloaded at: $filePath');
        // }
        // ============
      } else {
        throw Exception(
            'Failed to download Excel file: ${response.statusMessage}');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to download Excel file: $e');
    }
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

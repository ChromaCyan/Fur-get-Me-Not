import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  static const _storage = FlutterSecureStorage();

  // Method to get the stored User ID
  static Future<String?> getUserId() async {
    return await _storage.read(key: 'userId');
  }
}

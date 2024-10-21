import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fur_get_me_not/authentication/screen/login_screen.dart';
import 'package:fur_get_me_not/adoptee/screens/adoptee_profile/adoptee_profile.dart';
import 'package:fur_get_me_not/adoptee/repositories/pet_management/admin_pet_repository.dart';

class AdopteeDrawer extends StatelessWidget {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final AdminPetRepository _petRepository =
      AdminPetRepository(); // Instance of repository

  AdopteeDrawer({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    await _storage.delete(key: 'jwt');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Future<String?> _getUserId() async {
    return await _storage.read(key: 'userId');
  }

  Future<void> _downloadExcel(BuildContext context) async {
    try {
      await _petRepository.downloadExcel(); // Call the download method
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pet table downloaded successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download pet table: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: const Text(
              'Fur Get Me Not',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () async {
              final userId = await _getUserId();
              if (userId != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AdopteeProfilePage(userId: userId),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User not found. Please log in again.'),
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Download Pet Table'),
            onTap: () => _downloadExcel(context), // Call the download function
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await _logout(context);
            },
          ),
        ],
      ),
    );
  }
}

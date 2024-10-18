import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fur_get_me_not/authentication/screen/login_screen.dart';
import 'package:fur_get_me_not/adopter/screens/adopter_profile/adopter_profile.dart';

class AppDrawer extends StatelessWidget {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  AppDrawer({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    await _storage.delete(key: 'jwt'); // Remove JWT token from secure storage
    // Navigate to the LoginScreen after logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Future<String?> _getUserId() async {
    // Retrieve the userId from secure storage
    return await _storage.read(key: 'userId');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Fur Get Me Not',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () async {
              final userId = await _getUserId();
              if (userId != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(userId: userId),
                  ),
                );
              } else {
                // Handle case where userId is null, e.g., show an error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User not found. Please log in again.')),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await _logout(context);
            },
          ),
        ],
      ),
    );
  }
}

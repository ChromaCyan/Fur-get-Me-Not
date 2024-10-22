import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_list/pet_repository.dart';
import 'package:fur_get_me_not/authentication/screen/login_screen.dart';
import 'package:fur_get_me_not/adopter/screens/adopter_profile/adopter_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/shared/blocs/profile_bloc.dart';

class AppDrawer extends StatelessWidget {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final PetRepository _petRepository = PetRepository();

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

  // Future<void> _downloadExcel(BuildContext context) async {
  //   try {
  //     await _petRepository.downloadExcel();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Pet table downloaded successfully!')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to download pet table: $e')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF21899C),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: 45),
            // const DrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Colors.transparent,
            //   ),
            //   child: Text(
            //     'Fur Get Me Not',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 24,
            //     ),
            //   ),
            // ),
            FutureBuilder<String?>(
              future: _getUserId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                final userId = snapshot.data;
                if (userId != null) {
                  return BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProfileLoaded) {
                        final profile = state.profileData;
                        return _buildProfileSection(profile);
                      } else {
                        return const Center(
                          child: Text('Unable to load profile.'),
                        );
                      }
                    },
                  );
                }
                return const Center(
                  child: Text('User not found. Please log in again.'),
                );
              },
            ),
            _buildListTile(
              icon: Icons.person,
              text: 'Profile',
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
                    const SnackBar(
                        content: Text('User not found. Please log in again.')),
                  );
                }
              },
            ),
            // _buildListTile(
            //   icon: Icons.download,
            //   text: 'Download Pet Table',
            //   onTap: () => _downloadExcel(context),
            // ),
            _buildListTile(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () async {
                await _logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(Map<String, dynamic> profile) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: profile['profileImage'] != null &&
                  profile['profileImage'].isNotEmpty
              ? NetworkImage(profile['profileImage']) as ImageProvider
              : const AssetImage('assets/default_profile.png'),
        ),
        const SizedBox(height: 8),
        Text(
          '${profile['firstName']} ${profile['lastName']}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Adoptee',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const Divider(
            color: Colors.white70, thickness: 1, indent: 16, endIndent: 16),
      ],
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}

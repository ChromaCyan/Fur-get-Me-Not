import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_list/pet_repository.dart';
import 'package:fur_get_me_not/authentication/screen/login_screen.dart';
import 'package:fur_get_me_not/adopter/screens/adopter_profile/adopter_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/shared/blocs/profile_bloc.dart';
import 'package:fur_get_me_not/shared/screens/adoption_history_screen.dart';

class AppDrawer extends StatelessWidget {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final PetRepository _petRepository = PetRepository();

  AppDrawer({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF21899C),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: 45),
            FutureBuilder<String?>(
              future: _getUserId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                final userId = snapshot.data;
                if (userId != null) {
                  context.read<ProfileBloc>().add(FetchProfile(userId));

                  return BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProfileLoaded) {
                        final profile = state.profileData;
                        return _buildProfileSection(profile);
                      } else if (state is ProfileError) {
                        return Center(
                          child: Text(
                            'Error: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else {
                        return _buildProfileSection(
                            {});
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User not found. Please log in again.'),
                    ),
                  );
                }
              },
            ),
            _buildListTile(
              icon: Icons.history,
              text: 'Adoption History',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AdoptionHistoryScreen(),
                  ),
                );
              },
            ),
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
    final String firstName = profile['firstName'] ?? 'User';
    final String lastName = profile['lastName'] ?? 'Name';
    final String? profileImage = profile['profileImage'];

    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: profileImage != null && profileImage.isNotEmpty
              ? NetworkImage(profileImage) as ImageProvider
              : const AssetImage('assets/default_profile.png'),
        ),
        const SizedBox(height: 8),
        Text(
          '$firstName $lastName',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Adopter',
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

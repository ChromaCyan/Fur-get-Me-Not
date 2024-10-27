import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fur_get_me_not/authentication/screen/login_screen.dart';
import 'package:fur_get_me_not/adoptee/screens/adoptee_profile/adoptee_profile.dart';
import 'package:fur_get_me_not/adoptee/repositories/pet_management/admin_pet_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/shared/blocs/profile_bloc.dart';
import 'package:fur_get_me_not/shared/screens/adoption_history_screen.dart';

class AdopteeDrawer extends StatelessWidget {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final AdminPetRepository _petRepository = AdminPetRepository();

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
      await _petRepository.downloadExcel();
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
      child: Container(
        color: const Color(0xFF21899C),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(height: 45),
            FutureBuilder<String?>(
              future: _getUserId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                final userId = snapshot.data;
                if (userId != null) {
                  // Dispatch FetchProfile event for the user
                  context.read<ProfileBloc>().add(FetchProfile(userId));

                  return BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProfileLoaded) {
                        return _buildProfileSection(state.profileData);
                      } else if (state is ProfileError) {
                        return Center(
                          child: Text(
                            'Error: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else {
                        return _buildPlaceholderProfileSection();
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
              icon: Icons.download,
              text: 'Download Pet Table',
              onTap: () => _downloadExcel(context),
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

  Widget _buildPlaceholderProfileSection() {
    return const Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white24, // Blank circle
        ),
        SizedBox(height: 8),
        Text(
          'User Name',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Adoptee',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        Divider(color: Colors.white70, thickness: 1, indent: 16, endIndent: 16),
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

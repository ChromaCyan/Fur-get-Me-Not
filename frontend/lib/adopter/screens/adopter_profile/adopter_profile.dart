import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/authentication/models/user.dart';
import 'package:fur_get_me_not/shared/blocs/profile_bloc.dart';
import 'package:fur_get_me_not/widgets/headers/app_bar.dart';
import 'package:fur_get_me_not/widgets/buttons/edit_profile_btn.dart';

class ProfilePage extends StatefulWidget {
  final String userId; // userId parameter

  ProfilePage({required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfile(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Your Profile",
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final profile = state.profileData;
            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 24),
                buildProfileSection(profile),
                const SizedBox(height: 24),
                buildName(profile),
                const SizedBox(height: 32),
                buildUserInfoCard(profile),
                const SizedBox(height: 32),
              ],
            );
          } else if (state is ProfileError) {
            return Center(child: Text('Failed to load profile: ${state.message}'));
          }
          return const SizedBox();
        },
      ),
    );
  }

  // Profile section with image handling
  Widget buildProfileSection(Map<String, dynamic> profile) => Column(
    children: [
      Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
          image: DecorationImage(
            image: profile['profileImage'] != null && profile['profileImage'].isNotEmpty
                ? NetworkImage(profile['profileImage'])
                : const AssetImage('assets/default_profile.png') as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            profile['profileImage'] == null || profile['profileImage'].isEmpty
                ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
            )
                : Container(),
            profile['profileImage'] == null || profile['profileImage'].isEmpty
                ? const Center(
              child: Text(
                'No Profile Image Added',
                style: TextStyle(color: Colors.black54),
                textAlign: TextAlign.center, // Center align the text
              ),
            )
                : Container(), // Empty container if image is present
          ],
        ),
      ),
      const SizedBox(height: 16),
      EditButton(
        onClicked: () {
          // Navigate to profile edit screen
          Navigator.pushNamed(context, '/editProfile', arguments: widget.userId);
        },
      ),
    ],
  );

  Widget buildName(Map<String, dynamic> profile) => Column(
    children: [
      Text(
        '${profile['firstName']} ${profile['lastName']}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: Colors.black,
        ),
      ),
    ],
  );

  Widget buildUserInfoCard(Map<String, dynamic> profile) => Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildUserDetailRow('Role:', profile['role'] == 'adopter' ? 'Adopter' : 'Adoptee'),
        const SizedBox(height: 20),
        buildUserDetailRow('Email:', profile['email']),
        const SizedBox(height: 20),
        buildUserDetailRow('Address:', profile['address']),
      ],
    ),
  );

  Widget buildUserDetailRow(String label, String value) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    ],
  );
}

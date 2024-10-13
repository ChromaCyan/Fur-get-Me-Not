import 'package:flutter/material.dart';
import 'package:fur_get_me_not/widgets/headers/app_bar.dart';
import 'package:fur_get_me_not/widgets/buttons/edit_profile_btn.dart';
import 'package:fur_get_me_not/adoptee/models/profile/profile_model.dart';
import 'package:fur_get_me_not/adoptee/screens/adoptee_profile/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: CustomAppBar(title: "Your Profile",),
      body: Container(
        color: Colors.white,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Colors.blue.shade500,
        //       Colors.orange.shade500,
        //     ],
        //   ),
        // ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 24),
            buildProfileSection(user),
            const SizedBox(height: 24),
            buildName(user),
            const SizedBox(height: 32),
            buildUserInfoCard(user),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // Profile Section with Edit Button below the profile image
  Widget buildProfileSection(User user) => Column(
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
            imageSize: 150,
          ),
          const SizedBox(height: 16), // Space between profile image and button
          EditButton(
            onClicked: () {
              // Action when edit button is clicked
              print("Edit button clicked");
            },
          ),
        ],
      );

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ],
      );

  Widget buildUserInfoCard(User user) => Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust the margin as needed
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
        buildUserDetailRow('Role:', user.role),
        const SizedBox(height: 20),
        buildUserDetailRow('Bio:', user.bio),
        const SizedBox(height: 20),
        buildUserDetailRow('Email:', user.email),
        const SizedBox(height: 20),
        buildUserDetailRow('Sex:', user.sex),
        const SizedBox(height: 20),
        buildUserDetailRow('Address:', user.address),
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

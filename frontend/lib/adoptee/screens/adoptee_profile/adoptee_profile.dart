import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/authentication/repositories/auth_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fur_get_me_not/shared/blocs/profile_bloc.dart';
import 'package:fur_get_me_not/widgets/headers/app_bar.dart';

class AdopteeProfilePage extends StatefulWidget {
  final String userId;

  AdopteeProfilePage({required this.userId});

  @override
  _AdopteeProfilePageState createState() => _AdopteeProfilePageState();
}

class _AdopteeProfilePageState extends State<AdopteeProfilePage> {
  bool _isEditing = false;
  final _imagePicker = ImagePicker();
  XFile? _imageFile;

  // Controllers for the editable fields
  late TextEditingController _nameController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfile(widget.userId));

    // Initialize controllers
    _nameController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
        print('Debug: Picked image: ${_imageFile!.path}');
      });
    } else {
      print('Debug: No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Adoptee Profile",
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final profile = state.profileData;

            // Set controllers with the profile data
            if (!_isEditing) {
              _nameController.text = '${profile['firstName']} ${profile['lastName']}';
              _addressController.text = profile['address'];
            }

            return Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 24),
                  _buildProfileSection(profile),
                  const SizedBox(height: 16), // Adjust spacing
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50), // Set width and height
                      backgroundColor: Color(0xFFFE9879),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      _isEditing ? "Cancel" : "Edit Profile",
                      style: const TextStyle(fontSize: 18), // Text size
                    ),
                  ),
                  const SizedBox(height: 16), // Spacing before save button
                  if (_isEditing)
                    ElevatedButton(
                      onPressed: () {
                        File? profileImageFile;
                        if (_imageFile != null) {
                          profileImageFile = File(_imageFile!.path);
                        }

                        context.read<ProfileBloc>().add(UpdateProfile(
                          userId: widget.userId,
                          firstName: _nameController.text.split(' ').first,
                          lastName: _nameController.text.split(' ').length > 1
                              ? _nameController.text.split(' ').sublist(1).join(' ')
                              : '',
                          address: _addressController.text,
                          profileImage: profileImageFile,
                        ));

                        setState(() {
                          _isEditing = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 50), // Set width and height
                        backgroundColor: Colors.green, // Green background
                        foregroundColor: Colors.white, // White text
                      ),
                      child: const Text("Save Changes", 
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  const SizedBox(height: 32), // Spacing before details
                  _buildDetailsContainer(profile),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text('Failed to load profile: ${state.message}'));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildProfileSection(Map<String, dynamic> profile) {
    return Column(
      children: [
        GestureDetector(
          onTap: _isEditing ? _pickImage : null,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
              image: DecorationImage(
                image: _imageFile != null
                    ? FileImage(File(_imageFile!.path))
                    : (profile['profileImage'] != null && profile['profileImage'].isNotEmpty
                        ? NetworkImage(profile['profileImage'])
                        : const AssetImage('assets/default_profile.png') as ImageProvider),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_imageFile == null && profile['profileImage'] == null)
                  const Icon(Icons.camera_alt, color: Colors.white),
                if (_isEditing) const Icon(Icons.edit, color: Colors.white),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (_isEditing)
          SizedBox(
            width: 200,
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Enter full name',
                border: OutlineInputBorder(),
              ),
            ),
          )
        else
          Text(
            '${_nameController.text}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),
          ),
      ],
    );
  }

  Widget _buildDetailsContainer(Map<String, dynamic> profile) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRoleDetail(profile['role']),
          const SizedBox(height: 10),
          _buildEmailDetail(profile['email']),
          const SizedBox(height: 10),
          _buildAddressField(),
        ],
      ),
    );
  }

  Widget _buildRoleDetail(String role) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity, // Match the container's width
      decoration: BoxDecoration(
        color: const Color(0xFFF5E6CA), // Grey background for the role
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Role:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(role == 'adopter' ? 'Adopter' : 'Adoptee'), // Role value displayed below the title
        ],
      ),
    );
  }

  Widget _buildEmailDetail(String email) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity, // Match the container's width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Email:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(email), // Email value displayed below the title
        ],
      ),
    );
  }

  Widget _buildAddressField() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity, // Match the container's width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Address:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          if (_isEditing)
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  hintText: 'Enter address',
                  border: OutlineInputBorder(),
                ),
              ),
            )
          else
            Text(
              _addressController.text.isNotEmpty
                  ? _addressController.text
                  : 'No address provided',
            ),
        ],
      ),
    );
  }
}

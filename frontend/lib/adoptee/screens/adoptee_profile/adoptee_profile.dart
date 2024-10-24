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

  Future<String?> _uploadImage() async {
    if (_imageFile != null) {
      print('Debug: Image file is available: ${_imageFile!.path}');
      try {
        // Convert the path string to a File object
        File imageFile = File(_imageFile!.path);
        String imageUrl = await AuthRepository().uploadProfileImage(imageFile);
        print('Debug: Image uploaded successfully. URL: $imageUrl');
        return imageUrl; // Return the uploaded URL for use in the profile update
      } catch (e) {
        print('Error uploading image: $e');
        return null;
      }
    }
    return null; // No image to upload
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

            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 24),
                _buildBox(Column(
                  children: [
                    buildProfileSection(profile),
                    const SizedBox(height: 16),
                    buildName(),
                    const SizedBox(height: 32),
                    _buildDetailContainer('Role:', 'Adoptee'),
                    const SizedBox(height: 20),
                    _buildDetailField('Email:', profile['email'], false),
                    const SizedBox(height: 20),
                    buildAddress(),
                  ],
                )),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  child: Text(_isEditing ? "Cancel" : "Edit Profile"),
                ),
                const SizedBox(height: 20),
                if (_isEditing)
                  ElevatedButton(
                    onPressed: () async {
                      File? profileImageFile;
                      if (_imageFile != null) {
                        profileImageFile = File(_imageFile!.path);
                      }

                      // Update profile
                      context.read<ProfileBloc>().add(UpdateProfile(
                        userId: widget.userId,
                        firstName: _nameController.text.split(' ').first,
                        lastName: _nameController.text.split(' ').length > 1
                            ? _nameController.text.split(' ').sublist(1).join(' ')
                            : '',
                        address: _addressController.text,
                        profileImage: profileImageFile,
                      ));

                      // Reset editing state
                      setState(() {
                        _isEditing = false;
                      });
                    },
                    child: const Text("Save Changes"),
                  ),
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

  Widget buildProfileSection(Map<String, dynamic> profile) {
    return GestureDetector(
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
    );
  }

  Widget _buildDetailContainer(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAEFF1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildDetailField(String title, String value, bool isEditing, {bool editable = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        if (isEditing && editable)
          SizedBox(
            width: 200,
            child: TextField(
              controller: title == 'Email' ? null : title == 'Address' ? _addressController : _nameController,
              enabled: isEditing,
              decoration: InputDecoration(
                hintText: value,
                border: const OutlineInputBorder(),
              ),
            ),
          )
        else
          Text(value),
      ],
    );
  }

  Widget buildAddress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Address:', style: TextStyle(fontWeight: FontWeight.bold)),
        if (_isEditing)
          SizedBox(
            width: 200,
            child: TextField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: 'Enter address',
                border: const OutlineInputBorder(),
              ),
            ),
          )
        else
          Text(_addressController.text.isNotEmpty ? _addressController.text : 'No address provided'),
      ],
    );
  }

  Widget buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Full Name:', style: TextStyle(fontWeight: FontWeight.bold)),
        if (_isEditing)
          SizedBox(
            width: 200,
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter full name',
                border: const OutlineInputBorder(),
              ),
            ),
          )
        else
          Text('${_nameController.text}'),
      ],
    );
  }

  Widget _buildBox(Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }
}

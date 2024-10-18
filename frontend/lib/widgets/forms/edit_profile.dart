import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class EditProfileForm extends StatelessWidget {
  final File? selectedImage;

  EditProfileForm({this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // Implement image selection here if needed
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: selectedImage != null
                    ? FileImage(selectedImage!)
                    : null,
                child: selectedImage == null
                    ? Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            // Add TextFields for editing user details
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            // Add a save button to submit the changes
            ElevatedButton(
              onPressed: () {
                // Implement the save logic
                Navigator.pop(context); // Return to the profile page
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

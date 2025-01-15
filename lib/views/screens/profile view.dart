import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var name = "User Name".obs; // Observable for username
  var email = "user@example.com".obs; // Observable for user email
  var imageBase64 = "".obs; // Observable for storing image in Base64 format
  final ImagePicker _picker = ImagePicker();

  // Method to update user data after login
  void loadUserProfile(String username, String emailAddress, String? base64Image) {
    name.value = username;
    email.value = emailAddress;
    if (base64Image != null) {
      imageBase64.value = base64Image;
    }
  }

  void onAvatarPressed(BuildContext context) {
    // Show dialog to pick an image
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Profile Picture'),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Capture from camera'),
                onTap: () => _pickImage(ImageSource.camera, context),
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Upload from gallery'),
                onTap: () => _pickImage(ImageSource.gallery, context),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      imageBase64.value = base64Encode(bytes);
    }
    Navigator.of(context).pop();
  }

  void onEditAccountPressed(BuildContext context) {
    // Show dialog to edit account details
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: name.value),
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => name.value = value,
              ),
              TextField(
                controller: TextEditingController(text: email.value),
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => email.value = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void onShowCardPressed(BuildContext context) {
    // Show dialog displaying user card information
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Card'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green[100],
                backgroundImage: imageBase64.isNotEmpty
                    ? MemoryImage(base64Decode(imageBase64.value))
                    : null,
                child: imageBase64.isEmpty
                    ? Icon(Icons.person, size: 30, color: Colors.grey[400])
                    : null,
              ),
              SizedBox(height: 10),
              Text(
                'Name: ${name.value}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'Email: ${email.value}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void onViewHistoryPressed() {
    // Implement view history functionality here
  }

  void onRefreshPressed() {
    // Implement refresh functionality here
  }
}
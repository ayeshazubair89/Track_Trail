import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var name = "".obs; // Observable for username
  var streak = 0.obs; // Observable for user's streak
  var imageFile = Rxn<XFile>(); // Observable for the selected image file

  final ImagePicker _picker = ImagePicker();

  void loadUserProfile(String username, int userStreak) {
    name.value = username;
    streak.value = userStreak;
  }

  void onBackPressed() {
    Get.back();
  }

  void onRefreshPressed() {
    print('Profile refreshed');
  }

  void onEditAccountPressed(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();
    _usernameController.text = name.value;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Username'),
          content: TextField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_usernameController.text.isNotEmpty) {
                  name.value = _usernameController.text;
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void onShowCardPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Card'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Name: ${name.value}'),
              SizedBox(height: 8),
              Text('Streak: ${streak.value} days'),
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
    // Handle the logic to view history, such as navigating to a history screen or showing a dialog
    print('Viewing history');
    // Example: Get.to(() => HistoryScreen());
  }

  void onAvatarPressed(BuildContext context) {
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
      imageFile.value = pickedFile;
    }
    Navigator.of(context).pop();
  }
}

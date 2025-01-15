import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';

/*
class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture with camera icon if no image selected
            Obx(() => Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.teal[100],
                  backgroundImage: controller.imageFile.value != null
                      ? FileImage(File(controller.imageFile.value!.path))
                      : null,
                  child: controller.imageFile.value == null
                      ? Icon(Icons.person, size: 60, color: Colors.grey[400])
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => controller.onAvatarPressed(context),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(height: 24),

            // Username (Reactively updated using Obx)
            Obx(() => Text(
              controller.name.value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black,
              ),
            )),
            SizedBox(height: 8),
            Divider(color: Colors.grey[300], thickness: 1, height: 32),

            // Buttons: Edit account and Show your card
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => controller.onEditAccountPressed(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[50],
                    foregroundColor: Colors.teal[800],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Edit account'),
                ),
                ElevatedButton(
                  onPressed: () => controller.onShowCardPressed(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[50],
                    foregroundColor: Colors.teal[800],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Show your card'),
                ),
              ],
            ),
            SizedBox(height: 24),

            // History section
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.history, color: Colors.orange),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'View your activity history.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: controller.onViewHistoryPressed,
                    child: Text(
                      'View',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    color: Colors.grey,
                    onPressed: controller.onRefreshPressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trail2/views/screens/profile%20view.dart';


class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // Profile picture with camera icon if no image selected
            Obx(() {
              Widget profileImage;
              if (controller.imageBase64.value.isNotEmpty) {
                // Convert Base64 string to Uint8List and display it
                Uint8List imageBytes = base64Decode(controller.imageBase64.value);
                profileImage = CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.green[100],
                  backgroundImage: MemoryImage(imageBytes),
                );
              } else {
                // Show default icon if no image is selected
                profileImage = CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.green[100],
                  child: Icon(Icons.person, size: 60, color: Colors.grey[400]),
                );
              }

              return Stack(
                alignment: Alignment.bottomRight,
                children: [
                  profileImage,
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => controller.onAvatarPressed(context),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 24),

            // Username (Reactively updated using Obx)
            Obx(() => Text(
              controller.name.value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black,
              ),
            )),
            SizedBox(height: 8),
            Divider(color: Colors.grey[300], thickness: 1, height: 32),

            // Buttons: Edit account and Show your card
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => controller.onEditAccountPressed(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[50],
                    foregroundColor: Colors.green[800],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Edit account'),
                ),
                ElevatedButton(
                  onPressed: () => controller.onShowCardPressed(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[50],
                    foregroundColor: Colors.green[800],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Show your card'),
                ),
              ],
            ),
            SizedBox(height: 24),

            // History section
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.history, color: Colors.green),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'View your activity history.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: controller.onViewHistoryPressed,
                    child: Text(
                      'View',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    color: Colors.grey,
                    onPressed: controller.onRefreshPressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
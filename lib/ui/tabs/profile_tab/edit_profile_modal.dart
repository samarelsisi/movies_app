import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_style.dart';
import '../../widgets/avatart_selector.dart';
import '../../widgets/cutom_button.dart';

// API Base URL
const String baseUrl = "https://route-movie-apis.vercel.app/";

// Function to show the Edit Profile Modal
void showEditProfileModal(BuildContext context, {
  required String currentName,
  required int selectedAvatarIndex,
  required List<String> avatarImages,
  required String email, // Required to update the user profile
  required String authToken, // Authorization token
  required Function(String, int) onSave, // Callback to update data locally
}) {
  TextEditingController nameController = TextEditingController(text: currentName);
  int newAvatarIndex = selectedAvatarIndex;

  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.greyColor,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20, // Adjust for keyboard
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              "Edit Profile",
              style: AppStyle.bold20WhiteRoboto,
            ),
            SizedBox(height: 20),

            // Avatar Selector
            AvatarSelector(
              avatarImages: avatarImages,
              selectedAvatarIndex: selectedAvatarIndex,
              onAvatarSelected: (index) {
                newAvatarIndex = index; // Store new selection
              },
            ),
            SizedBox(height: 20),

            // Name Input Field
            TextField(
              controller: nameController,
              style: AppStyle.bold20WhiteRoboto,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(color: AppColors.whiteColor),
                filled: true,
                fillColor: AppColors.blackColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Save Button
            CustomButton(
              text: "Save",
              color: AppColors.yellowColor,
              onPressed: () async {
                String updatedName = nameController.text;
                await _updateUserProfile(
                  context,
                  email: email,
                  name: updatedName,
                  avatarId: newAvatarIndex,
                  authToken: authToken,
                  onSuccess: () {
                    onSave(updatedName, newAvatarIndex); // Update locally
                    Navigator.pop(context); // Close modal
                  },
                );
              },
            ),
            SizedBox(height: 10),

            // Delete Account Button
            CustomButton(
              text: "Delete Account",
              color: AppColors.redColor,
              textColor: AppColors.whiteColor,
              onPressed: () {
                _showDeleteAccountConfirmation(context, authToken);
              },
            ),
          ],
        ),
      );
    },
  );
}

// Function to send PATCH request for updating profile
Future<void> _updateUserProfile(
    BuildContext context, {
      required String email,
      required String name,
      required int avatarId,
      required String authToken,
      required VoidCallback onSuccess,
    }) async {
  final url = Uri.parse("$baseUrl/profile");

  final response = await http.patch(
    url,
    headers: {
      "Authorization": "Bearer $authToken",
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "email": email,
      "name": name,
      "avaterId": avatarId,
    }),
  );

  final responseData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    onSuccess(); // Notify UI of success
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(responseData["message"], style: TextStyle(color: Colors.white)), backgroundColor: Colors.green),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to update profile", style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
    );
  }
}

// Function to show Delete Account Confirmation Modal
void _showDeleteAccountConfirmation(BuildContext context, String authToken) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.greyColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Delete Account", style: AppStyle.bold24WhiteRoboto),
            SizedBox(height: 10),
            Text(
              "Are you sure you want to delete your account? This action cannot be undone.",
              textAlign: TextAlign.center,
              style: AppStyle.bold20WhiteRoboto,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Cancel",
                    color: AppColors.greyColor.withOpacity(0.7),
                    textColor: AppColors.whiteColor,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: "Delete",
                    color: AppColors.redColor,
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      _deleteAccount(context, authToken);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

// Function to Delete Account (Send DELETE Request)
Future<void> _deleteAccount(BuildContext context, String authToken) async {
  final url = Uri.parse("$baseUrl/profile");

  final response = await http.delete(
    url,
    headers: {
      "Authorization": "Bearer $authToken",
    },
  );

  final responseData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    Navigator.pop(context); // Close modal
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(responseData["message"], style: TextStyle(color: Colors.white)), backgroundColor: Colors.green),
    );
    // Navigate to Login Screen after deletion
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to delete account", style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_style.dart';
import '../../widgets/avatart_selector.dart';
import '../../widgets/cutom_button.dart';

void showEditProfileModal(BuildContext context, {
  required String currentName,
  required int selectedAvatarIndex,
  required List<String> avatarImages,
  required Function(String, int) onSave, // Callback to update data
  required Function() onDeleteAccount, // Callback for deleting account
}) {
  TextEditingController nameController = TextEditingController(text: currentName);
  int newAvatarIndex = selectedAvatarIndex;

  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.greyColor, // Background color changed to grey
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
              onPressed: () {
                onSave(nameController.text, newAvatarIndex); // Send updated data
                Navigator.pop(context); // Close modal
              },
            ),
            SizedBox(height: 10),

            // Delete Account Button
            TextButton(
              onPressed: () => _showDeleteAccountDialog(context, onDeleteAccount),
              child: Text("Delete Account", style: TextStyle(color: AppColors.redColor, fontSize: 16)),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}

void _showDeleteAccountDialog(BuildContext context, Function() onDeleteAccount) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.greyColor,
      title: Text("Delete Account", style: AppStyle.bold20WhiteRoboto),
      content: Text(
        "Are you sure you want to delete your account? This action cannot be undone.",
        style: AppStyle.bold20WhiteRoboto,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: TextStyle(color: AppColors.whiteColor)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close dialog
            onDeleteAccount(); // Execute deletion callback
          },
          child: Text("Delete", style: TextStyle(color: AppColors.redColor)),
        ),
      ],
    ),
  );
}

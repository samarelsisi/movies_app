import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_image.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/auth/login/login_screen.dart';
import 'package:movies/ui/tabs/profile_tab/reset_password.dart';
import 'package:movies/ui/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/cutom_button.dart';
import '../../widgets/confirm_modal.dart';

const String baseUrl = "https://route-movie-apis.vercel.app/";

class EditProfileScreen extends StatefulWidget {
  static const String routeName = 'edit profile';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controllers
  late TextEditingController nameController;
  late TextEditingController phoneController;

  // Avatars
  int selectedAvatarIndex = 0;
  late List<String> avatarImages;

  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();

    avatarImages = [
      AppImage.avatar1,
      AppImage.avatar2,
      AppImage.avatar3,
      AppImage.avatar4,
      AppImage.avatar5,
      AppImage.avatar6,
      AppImage.avatar7,
      AppImage.avatar8,
      AppImage.avatar9,
    ];

    _fetchUserProfile();
  }

  /// Fetch user profile from API to pre-fill name, phone, and avatar
  Future<void> _fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");

    if (token == null) {
      print("No auth token found. User might not be logged in.");
      return;
    }

    final url = Uri.parse("${baseUrl}profile");
    try {
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final data = jsonResponse['data'];

        setState(() {
          nameController.text = data['name'] ?? '';
          phoneController.text = data['phone'] ?? '';
          selectedAvatarIndex = data['avaterId'] ?? 0;
        });
      } else {
        print("Failed to fetch profile: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }

  void _showAvatarSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.greyColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: avatarImages.length,
            itemBuilder: (context, index) {
              bool isSelected = (index == selectedAvatarIndex);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatarIndex = index;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.yellowColor.withOpacity(0.2)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? AppColors.yellowColor : AppColors.yellowColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(avatarImages[index]),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                    ,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }


  Future<void> _updateProfile() async {
    setState(() {
      isUpdating = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not authenticated"), backgroundColor: AppColors.redColor),
      );
      setState(() {
        isUpdating = false;
      });
      return;
    }

    final url = Uri.parse("${baseUrl}profile");
    final body = json.encode({
      "name": nameController.text,
      "phone": phoneController.text,
      "avaterId": selectedAvatarIndex,
    });

    try {
      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile updated successfully"),
            backgroundColor: AppColors.greenColor,
          ),
        );
        Navigator.pop(context); // Return to the Profile tab so it can refresh.
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update profile"),
            backgroundColor: AppColors.redColor,
          ),
        );
      }
    } catch (e) {
      print("Error updating profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred"),
          backgroundColor: AppColors.redColor,
        ),
      );
    } finally {
      setState(() {
        isUpdating = false;
      });
    }
  }

  Future<void> _deleteAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No auth token found. Please log in."),
          backgroundColor: AppColors.redColor,
        ),
      );
      return;
    }

    final url = Uri.parse("${baseUrl}profile");
    try {
      final response = await http.delete(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account deleted successfully"),
            backgroundColor: AppColors.greenColor,
          ),

        );
        // Navigate to login screen
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to delete account"),
            backgroundColor: AppColors.redColor,
          ),
        );
      }
    } catch (e) {
      print("Error deleting account: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred"),
          backgroundColor: AppColors.redColor,
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        title: Text("Edit Profile", style: AppStyle.bold20WhiteRoboto),
        backgroundColor: AppColors.blackColor,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Avatar
                        GestureDetector(
                          onTap: _showAvatarSelection,
                          child:   Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:  AssetImage(avatarImages[selectedAvatarIndex]),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )

                        ),
                        const SizedBox(height: 20),

                        // Name
                        CustomTextField(
                          hintText: 'User Name',
                          icon: Icons.person,
                          controller: nameController,
                        ),
                        const SizedBox(height: 12),

                        // Phone
                        CustomTextField(
                          hintText: 'Phone',
                          icon: Icons.phone,
                          controller: phoneController,
                        ),
                        const SizedBox(height: 12),

                        // Reset Password button
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              // Navigate to Reset Password screen if available.
                              Navigator.pushNamed(context, ResetPasswordScreen.routeName);

                            },
                            child: Text(
                              "Reset Password",
                              style: AppStyle.bold20WhiteRoboto,
                            ),
                          ),
                        ),

                        // Extra spacing to push buttons to the bottom
                        Spacer(),

                        // Delete & Update Buttons
                        Column(
                          children: [
                            CustomButton(
                              text: "Delete Account",
                              color: AppColors.redColor,
                              textColor: AppColors.whiteColor,
                              onPressed: () => showConfirmModal(
                                context: context,
                                title: "Delete Account",
                                message:
                                "Are you sure you want to delete your account?",
                                icon: Icons.delete_forever,
                                iconColor: AppColors.redColor,
                                confirmButtonText: "Delete",
                                confirmButtonColor: AppColors.redColor,
                                onConfirm: (ctx) => _deleteAccount(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            isUpdating
                                ? Center(child: CircularProgressIndicator())
                                : CustomButton(
                              text: "Update Data",
                              color: AppColors.yellowColor,
                              onPressed: _updateProfile,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

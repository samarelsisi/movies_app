import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_image.dart';
import 'package:movies/theme/app_style.dart';
import '../../widgets/cutom_button.dart';

const String baseUrl = "https://route-movie-apis.vercel.app/";

class EditProfileScreen extends StatefulWidget {
  static const String routeName = 'edit profile';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late int selectedAvatarIndex;
  late List<String> avatarImages;
  String email = "";
  String authToken = "";

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(); // Initialize empty
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      nameController.text = args['currentName'] ?? '';
      selectedAvatarIndex = args['selectedAvatarIndex'] ?? 0;
      email = args['email'] ?? '';
      authToken = args['authToken'] ?? '';
    }
  }

  Future<void> _updateUserProfile() async {
    final url = Uri.parse("$baseUrl/profile");

    try {
      final response = await http.patch(
        url,
        headers: {
          "Authorization": "Bearer $authToken",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "name": nameController.text,
          "avaterId": selectedAvatarIndex,
        }),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData["message"])),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update profile")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again.")),
      );
    }
  }

  void _showAvatarSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.greyColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatarIndex = index;
                  });
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(avatarImages[index]),
                  radius: 40,
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile", style: AppStyle.bold20WhiteRoboto),
        backgroundColor: AppColors.blackColor,
      ),
      backgroundColor: AppColors.blackColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _showAvatarSelection,
              child: CircleAvatar(
                backgroundImage: AssetImage(avatarImages[selectedAvatarIndex]),
                radius: 50,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              style: AppStyle.bold20WhiteRoboto,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(color: AppColors.whiteColor),
                filled: true,
                fillColor: AppColors.greyColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Update Data",
              color: AppColors.yellowColor,
              onPressed: _updateUserProfile,
            ),


          ],
        ),
      ),
    );
  }
}

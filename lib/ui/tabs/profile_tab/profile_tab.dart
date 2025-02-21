import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/widgets/placeholder_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../auth/login/login_screen.dart';
import '../../widgets/cutom_button.dart';
import '../../../theme/app_image.dart';
import 'edit_profile_screen.dart';
import '../../widgets/confirm_modal.dart';

class ProfileTab extends StatefulWidget {
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String userName = "John Safwat";
  int userSelectedAvatarIndex = 0;
  bool isLoading = true;

  final List<String> avatarImages = [
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

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("auth_token");

      if (token == null) {
        print("No token found, user might not be logged in");
        return;
      }

      final url = Uri.parse("https://route-movie-apis.vercel.app/profile");
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final data = jsonResponse['data'];
        setState(() {
          userName = data['name'] ?? userName;
          userSelectedAvatarIndex = data['avaterId'] ?? userSelectedAvatarIndex;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  _buildProfileHeader(context),
                  _buildTabs(context),
                  Expanded(
                    child: TabBarView(
                      children: [
                        PlaceholderContent(),
                        PlaceholderContent(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      color: AppColors.greyColor,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(avatarImages[userSelectedAvatarIndex]),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  Text(userName, style: AppStyle.bold20WhiteRoboto),
                ],
              ),
              Row(
                children: [
                  _buildStatColumn('12', 'Wish List'),
                  SizedBox(width: 24),
                  _buildStatColumn('10', 'History'),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomButton(
                  text: 'Edit Profile',
                  color: AppColors.yellowColor,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      EditProfileScreen.routeName,
                      arguments: {
                        // Pass current data if needed.
                      },
                    ).then((_) {
                      // Refresh profile after editing.
                      fetchUserProfile();
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: CustomButton(
                  text: 'Exit',
                  color: AppColors.redColor,
                  icon: Icons.exit_to_app,
                  textColor: AppColors.whiteColor,
                  isLeading: false,
                  onPressed: () => showConfirmModal(
                    context: context,
                    title: 'Exit',
                    message: "Are you sure you want to log out?",
                    icon: Icons.exit_to_app,
                    iconColor: AppColors.redColor,
                    confirmButtonText: "Logout",
                    confirmButtonColor: AppColors.redColor,
                    onConfirm: _logout,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.greyColor,
      child: TabBar(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColors.yellowColor, width: 4),
          insets: EdgeInsets.symmetric(horizontal: width * 0.3),
        ),
        labelColor: AppColors.whiteColor,
        unselectedLabelColor: AppColors.whiteColor,
        tabs: [
          Tab(
              icon: Icon(Icons.list, color: AppColors.yellowColor),
              text: 'Watch List'),
          Tab(
              icon: Icon(Icons.folder, color: AppColors.yellowColor),
              text: 'History'),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(value, style: AppStyle.bold36WhiteRoboto),
        SizedBox(height: 20),
        Text(label, style: AppStyle.bold24WhiteRoboto),
      ],
    );
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("auth_token");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }
}

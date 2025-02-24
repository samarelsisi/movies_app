import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_image.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/auth/login/login_screen.dart';
import 'package:movies/ui/widgets/confirm_modal.dart';
import 'package:movies/ui/widgets/cutom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/ repository/profile_repository.dart';
import '../../data/logic/bloc/profile/profile_bloc.dart';
import '../../data/logic/bloc/profile/profile_event.dart';
import '../../data/logic/bloc/profile/profile_state.dart';
import '../../data/services/profile_service.dart';
import 'edit_profile_screen.dart';
import 'favorites_list.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
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

  int _watchListLength = 0;

  int _historyListLength = 0;

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("auth_token");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) =>
      ProfileBloc(ProfileRepository(ProfileService()))..add(LoadProfile()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.blackColor,
          body: Column(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.yellowColor,
                      ),
                    );
                  } else if (state is ProfileLoaded) {
                    final profileData = state.profileData;
                    final userName = profileData.name;
                    final userSelectedAvatarIndex = profileData.avatarId;

                    return _buildProfileHeader(
                      context,
                      userName,
                      userSelectedAvatarIndex,
                    );
                  } else if (state is ProfileError) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      color: AppColors.greyColor,
                      child: Center(
                        child: Text(
                          "Error: ${state.message}",
                          style: AppStyle.bold20WhiteRoboto,
                        ),
                      ),
                    );
                  }

                  // When state is ProfileInitial or any unhandled state
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.yellowColor,
                      ),
                    ),
                  );
                },
              ),
              _buildTabs(context),
              SizedBox(
                height: height * .02,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FavoritesList(
                      listType: "watch",
                      onListLengthChanged: (length) {
                        setState(() {
                          _watchListLength = length;
                        });
                      },
                    ),
                    FavoritesList(
                      listType: "history",
                      onListLengthChanged: (length) {
                        setState(() {
                          _historyListLength = length;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
      BuildContext context,
      String userName,
      int userSelectedAvatarIndex,
      ) {
    return Container(
      color: AppColors.greyColor,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                  const SizedBox(height: 16),
                  Text(userName, style: AppStyle.bold20WhiteRoboto),
                ],
              ),
              Row(
                children: [
                  _buildStatColumn('$_watchListLength', 'Wish List'),
                  const SizedBox(width: 24),
                  _buildStatColumn('$_historyListLength', 'History'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
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
                      // When returning from the EditProfileScreen, reload the profile.
                      context.read<ProfileBloc>().add(LoadProfile());
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
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
        tabs: const [
          Tab(icon: Icon(Icons.list, color: AppColors.yellowColor), text: 'Watch List'),
          Tab(icon: Icon(Icons.folder, color: AppColors.yellowColor), text: 'History'),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(value, style: AppStyle.bold36WhiteRoboto),
        const SizedBox(height: 20),
        Text(label, style: AppStyle.bold24WhiteRoboto),
      ],
    );
  }
}

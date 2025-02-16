import 'package:flutter/material.dart';
import 'package:movies/ui/home_screen.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_image.dart';
import '../../../theme/app_style.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/cutom_button.dart';
import '../../widgets/language_toggle_switch.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'regist_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int selectedAvatarIndex = 1;
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.yellowColor),
          onPressed: () {
            Navigator.pushNamed(
              context,
              LoginScreen.routeName,
            );
          },
        ),
        title: Text(
          "Register",
          style: AppStyle.medium16Yellow,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              SizedBox(
                height: 140,
                child: PageView.builder(
                  itemCount: avatarImages.length,
                  controller: PageController(
                      viewportFraction: 0.25, initialPage: selectedAvatarIndex),
                  onPageChanged: (index) {
                    setState(() {
                      selectedAvatarIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    bool isSelected = index == selectedAvatarIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatarIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Transform.scale(
                          scale: isSelected ? 2.0 : 1.0,
                          // Scale effect for selected avatar
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(
                                vertical: isSelected ? 0 : 10, horizontal: 8),
                            width: isSelected ? 120 : 60,
                            height: isSelected ? 120 : 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(avatarImages[index]),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),
              Text(
                "Avatar",
                style: AppStyle.medium16White,
              ),

              const SizedBox(height: 12),

              CustomTextField(icon: Icons.badge, hintText: "Name"),
              const SizedBox(height: 24),
              CustomTextField(icon: Icons.email, hintText: "Email"),
              const SizedBox(height: 24),
              CustomTextField(
                  icon: Icons.lock, hintText: "Password", isPassword: true),
              const SizedBox(height: 24),
              CustomTextField(
                  icon: Icons.lock,
                  hintText: "Confirm Password",
                  isPassword: true),
              const SizedBox(height: 24),
              CustomTextField(icon: Icons.phone, hintText: "Phone Number"),

              const SizedBox(height: 24),

              CustomButton(
                text: "Create Account",
                color: AppColors.yellowColor,
                onPressed: () {
                  // Handle Registration
                },
              ),

              const SizedBox(height: 16),

              InkWell(
                onTap: () {
                  // Navigator.pushReplacementNamed(
                  //   context,
                  //   LoginScreen.routeName,
                  // );
                  Navigator.pushNamed(context,HomeScreen.routeName);
                },
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Already Have Account ?",
                        style: AppStyle.regular14White,
                      ),
                      TextSpan(
                        text: " Login",
                        style: AppStyle.bold14Yellow,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Language Toggle
              LanguageToggleSwitch(
                onToggle: (isEnglish) {
                  print(isEnglish ? "English Selected" : "Arabic Selected");
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

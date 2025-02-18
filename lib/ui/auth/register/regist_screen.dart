import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_image.dart';
import '../../../theme/app_style.dart';

import '../../widgets/avatart_selector.dart';
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
          child: Form(
            key :formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                AvatarSelector(
                  avatarImages: avatarImages,
                  selectedAvatarIndex: selectedAvatarIndex,
                  onAvatarSelected: (index) {
                    setState(() {
                      selectedAvatarIndex = index;
                    });
                  },
                ),

                const SizedBox(height: 16),
                Text(
                  "Avatar",
                  style: AppStyle.medium16White,
                ),

                const SizedBox(height: 20),
                CustomTextField(icon: Icons.badge, hintText: "Name", controller: nameController),
                const SizedBox(height: 16),
                CustomTextField(icon: Icons.email, hintText: "Email", controller: emailController),
                const SizedBox(height: 16),
                CustomTextField(icon: Icons.lock, hintText: "Password", controller: passwordController, isPassword: true),
                const SizedBox(height: 16),
                CustomTextField(icon: Icons.lock, hintText: "Confirm Password", controller: confirmPasswordController, isPassword: true),
                const SizedBox(height: 16),
                CustomTextField(icon: Icons.phone, hintText: "Phone Number", controller: phoneController),
                const SizedBox(height: 24),

                isLoading
                    ? CircularProgressIndicator(color: AppColors.yellowColor)
                    : CustomButton(text: "Create Account", color: AppColors.yellowColor, onPressed: registerUser),

                const SizedBox(height: 16),

                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      LoginScreen.routeName,
                    );
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
      ),
    );
  }

  bool isLoading = false;

  void registerUser() async {
    final url = Uri.parse("https://route-movie-apis.vercel.app/auth/register");
    final data = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "confirmPassword": confirmPasswordController.text,
      "phone": phoneController.text,
      "avaterId": selectedAvatarIndex + 1, // Ensure it's not zero-based
    };

    try {
      setState(() {
        isLoading = true;
      });

      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Headers: ${response.headers}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        print("Parsed Response: $responseData");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData["message"], style: TextStyle(color: AppColors.whiteColor)), backgroundColor: AppColors.greyColor),
        );

        // Navigate to login screen
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      } else {
        print("Request failed with status: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed: ${response.statusCode}"), backgroundColor: AppColors.redColor),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again!"), backgroundColor: AppColors.greenColor),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


}
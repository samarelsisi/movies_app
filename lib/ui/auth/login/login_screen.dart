import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/ui/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_image.dart';
import '../../../theme/app_style.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/cutom_button.dart';
import '../../widgets/language_toggle_switch.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../register/regist_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;




  Future<void> loginUser(BuildContext context, String email, String password) async {
    final url = Uri.parse("https://route-movie-apis.vercel.app/auth/login"); // Corrected URL

    final data = {
      "email": email.trim(),
      "password": password.trim(),
    };

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      var responseData = jsonDecode(response.body);
      print("Login Response: $responseData");
      print("Response Body: ${response.body}");
      print("Response Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        String message = responseData["message"];
        String? token = responseData["data"]; // Assuming 'data' contains the token

        if (token != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("auth_token", token);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Successful: $message"), backgroundColor: AppColors.greenColor),
          );

          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login failed: No token received"), backgroundColor: AppColors.redColor),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData["message"] ?? "Login failed"), backgroundColor: AppColors.redColor),
        );
      }
    } catch (e) {
      print("Login Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again."), backgroundColor: AppColors.redColor),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(image: AssetImage(AppImage.logo)),
              CustomTextField(
                hintText: "Email",
                icon: Icons.email,
                controller: emailController,
              ),
              const SizedBox(height: 22),
              CustomTextField(
                hintText: "Password",
                icon: Icons.lock,
                isPassword: true,
                controller: passwordController,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                  },
                  child: Text("Forget Password?", style: AppStyle.regular14Yellow),
                ),
              ),
              const SizedBox(height: 32),
              isLoading
                  ? CircularProgressIndicator(color: AppColors.yellowColor)
                  : CustomButton(
                text: "Login",
                color: AppColors.yellowColor,
                  onPressed: () => loginUser(context, emailController.text, passwordController.text),

              ),
              const SizedBox(height: 22),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(text: "Don’t Have an Account?", style: AppStyle.regular14White),
                      TextSpan(text: " Create One", style: AppStyle.bold14Yellow),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      endIndent: 20,
                      indent: 20,
                      thickness: 2,
                      color: AppColors.yellowColor,
                    ),
                  ),
                  Text("OR", textAlign: TextAlign.center, style: AppStyle.regular14Yellow),
                  Expanded(
                    child: Divider(
                      endIndent: 20,
                      indent: 20,
                      thickness: 2,
                      color: AppColors.yellowColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: "Login With Google",
                color: AppColors.yellowColor,
                assetImage: AppImage.googleIcon,
                isLeading: true,
                onPressed: () {},
              ),
              const SizedBox(height: 24),
              LanguageToggleSwitch(
                onToggle: (isEnglish) {
                  print(isEnglish ? "English Selected" : "Arabic Selected");
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

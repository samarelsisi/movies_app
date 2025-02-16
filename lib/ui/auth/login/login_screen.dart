import 'package:flutter/material.dart';
import 'package:movies/ui/home_screen.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_image.dart';
import '../../../theme/app_style.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/cutom_button.dart';
import '../../widgets/language_toggle_switch.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../register/regist_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: AssetImage(AppImage.logo),
              ),
              CustomTextField(
                hintText: "Email",
                icon: Icons.email,
              ),
              const SizedBox(
                height: 22,
              ),
              CustomTextField(
                hintText: "Password",
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ForgotPasswordScreen.routeName,
                    );
                  },
                  child: Text(
                    "Forget Password?",
                    style: AppStyle.regular14Yellow,
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              CustomButton(
                text: "Login",
                color: AppColors.yellowColor,
                onPressed: () {
                  // Login action
                  Navigator.pushReplacementNamed(
                    context,
                    HomeScreen.routeName,
                  );

                },
              ),
              SizedBox(
                height: 22,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RegisterScreen.routeName,
                  );
                },
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Don’t Have Account?",
                        style: AppStyle.regular14White,
                      ),
                      TextSpan(
                        text: " Create One",
                        style: AppStyle.bold14Yellow,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
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
                  Text(
                    "OR",
                    textAlign: TextAlign.center,
                    style: AppStyle.regular14Yellow,

                  ),
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
              SizedBox(
                height: 24,
              ),
              CustomButton(
                text: "Login With Google",
                color: AppColors.yellowColor,
                assetImage: AppImage.googleIcon,
                isLeading: true,
                onPressed: () {},
              ),
              SizedBox(
                height: 24,
              ),
              LanguageToggleSwitch(
                onToggle: (isEnglish) {
                  print(isEnglish ? "English Selected" : "Arabic Selected");
                },
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_image.dart';
import '../../../theme/app_style.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/cutom_button.dart';
import '../login/login_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = 'forgot_password_screen';

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: AppColors.yellowColor),
          onPressed: (){
            Navigator.pushNamed(
              context,
              LoginScreen.routeName,
            );
          },
        ),
        title:  Text(
          "Forgot Password",
          style: AppStyle.medium16Yellow,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            SizedBox(
              height: 400,
              child: Image.asset(AppImage.forgotPassword, fit: BoxFit.contain),
            ),

            const SizedBox(height: 24),

            CustomTextField(icon: Icons.email, hintText: "Email"),

            const SizedBox(height: 24),

            CustomButton(
              text: "Verify Email",
              color: AppColors.yellowColor,
              onPressed: () {
                // Handle Email Verification Logic
              },
            ),
          ],
        ),
      ),
    );
  }
}

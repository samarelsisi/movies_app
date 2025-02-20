import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/ui/home_screen.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_image.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/widgets/custom_text_field.dart';
import 'package:movies/ui/widgets/language_toggle_switch.dart';

import '../../data/ repository/auth_repository.dart';
import '../../data/logic/bloc/auth_bloc.dart';
import '../../data/logic/bloc/auth_event.dart';
import '../../data/logic/bloc/auth_state.dart';
import '../../data/services/auth_service.dart';
import '../../widgets/cutom_button.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../register/regist_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login_screen';
  final authService = AuthService(); // Initialize AuthService

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: AuthRepository(authService: authService)),
      child: Scaffold(
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
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message), backgroundColor: AppColors.greenColor),
                      );
                      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                    } else if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error), backgroundColor: AppColors.redColor),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return CircularProgressIndicator(color: AppColors.yellowColor);
                    }
                    return CustomButton(
                      text: "Login",
                      color: AppColors.yellowColor,
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          LoginEvent(email :emailController.text,password:  passwordController.text),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 22),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, RegisterScreen.routeName),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Don’t Have an Account?", style: AppStyle.regular14White),
                        TextSpan(text: " Create One", style: AppStyle.bold14Yellow),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                LanguageToggleSwitch(onToggle: (isEnglish) {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_image.dart';
import '../../../theme/app_style.dart';
import '../../data/logic/bloc/auth_bloc.dart';
import '../../data/logic/bloc/auth_event.dart';
import '../../data/logic/bloc/auth_state.dart';
import '../../widgets/avatart_selector.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/cutom_button.dart';
import '../../widgets/language_toggle_switch.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

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
          onPressed: () => Navigator.pushNamed(context, LoginScreen.routeName),
        ),
        title: Text("Register", style: AppStyle.medium16Yellow),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Registration successful!"), backgroundColor: AppColors.greenColor),
            );
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: AppColors.redColor),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
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
                  Text("Avatar", style: AppStyle.medium16White),
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
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return CircularProgressIndicator(color: AppColors.yellowColor);
                      }
                      return CustomButton(
                        text: "Create Account",
                        color: AppColors.yellowColor,
                        onPressed: registerUser,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () => Navigator.pushReplacementNamed(context, LoginScreen.routeName),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(text: "Already Have Account ?", style: AppStyle.regular14White),
                          TextSpan(text: " Login", style: AppStyle.bold14Yellow),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
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
      ),
    );
  }

  void registerUser() {
    if (formKey.currentState!.validate()) {
      final authBloc = BlocProvider.of<AuthBloc>(context);
      authBloc.add(RegisterUser(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        phone: phoneController.text,
        avaterId: selectedAvatarIndex ,
      ));
    }
  }
}

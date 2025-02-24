import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/widgets/custom_text_field.dart';
import 'package:movies/ui/widgets/cutom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = "https://route-movie-apis.vercel.app/";

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = 'reset_password';
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmNewPasswordController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    if (newPasswordController.text != confirmNewPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("New passwords do not match."),
          backgroundColor: AppColors.redColor,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User not authenticated."),
          backgroundColor: AppColors.redColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    final url = Uri.parse("${baseUrl}auth/reset-password");
    final body = json.encode({
      "oldPassword": oldPasswordController.text,
      "newPassword": newPasswordController.text,
    });

    try {
      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      // Debug logs:
      print("Reset Password Response Status: ${response.statusCode}");
      print("Reset Password Response Body: ${response.body}");

      // Check for both 200 and 201 as successful responses.
      if (response.statusCode == 201 || response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password reset successfully."),
            backgroundColor: AppColors.greenColor,
          ),
        );
        // Delay a bit to let the user see the snack bar, then pop.
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      } else {
        String errorMsg = "Failed to reset password.";
        try {
          final errorResponse = json.decode(response.body);
          if (errorResponse["message"] != null) {
            errorMsg = errorResponse["message"];
          }
        } catch (_) {}

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: AppColors.redColor,
          ),
        );
      }
    } catch (e) {
      print("Error resetting password: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred."),
          backgroundColor: AppColors.redColor,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }



  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        title: Text("Reset Password", style: AppStyle.bold20WhiteRoboto),
        backgroundColor: AppColors.blackColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Old Password
                CustomTextField(
                  hintText: "Current Password",
                  icon: Icons.lock,
                  isPassword: true,
                  controller: oldPasswordController,
                  onChange: (val) {},
                ),
                SizedBox(height: 16),
                // New Password
                CustomTextField(
                  hintText: "New Password",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  controller: newPasswordController,
                  onChange: (val) {},
                ),
                SizedBox(height: 16),
                // Confirm New Password
                CustomTextField(
                  hintText: "Confirm New Password",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  controller: confirmNewPasswordController,
                  onChange: (val) {},
                ),
                SizedBox(height: 24),
                // Reset Password Button
                isLoading
                    ? Center(child: CircularProgressIndicator(color: AppColors.yellowColor))
                    : CustomButton(
                  text: "Reset Password",
                  color: AppColors.yellowColor,
                  onPressed: _resetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

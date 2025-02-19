import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

  Future<String> loginUser(String email, String password) async {
    final response = await authService.login(email, password);

    if (response.containsKey("data")) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("auth_token", response["data"]);
      return response["message"];
    } else {
      throw Exception("Login failed: No token received");
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    final response = await authService.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
      avaterId: avaterId,
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Registration failed: ${response.body}");
    }
  }


Future<Map<String, dynamic>> updateProfile({
    String? email,
    String? name,
    String? phone,
    int? avaterId,
  }) async {
    final response = await authService.updateProfile(
      email: email,
      name: name,
      phone: phone,
      avaterId: avaterId,
    );

    if (response.containsKey("message")) {
      return {
        "message": response["message"],

      };
    } else {
      throw Exception("Profile update failed");
    }
  }

  Future<Map<String, dynamic>> fetchUserData(String token) async {
    final response = await authService.getUserData(token);
    if (response.containsKey("data")) {
      return response["data"];
    } else {
      throw Exception("Invalid response format: missing 'data'");
    }
  }
}

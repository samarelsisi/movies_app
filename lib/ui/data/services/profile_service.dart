import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/ui/models/profile_data.dart';

class ProfileService {
  static const _baseUrl = "https://route-movie-apis.vercel.app";

  // Existing: fetchProfile
  Future<ProfileData> fetchProfile(String token) async {
    final url = Uri.parse("$_baseUrl/profile");
    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return ProfileData.fromJson(data);
    } else {
      throw Exception("Failed to fetch profile: ${response.statusCode}");
    }
  }

  // NEW: updateProfile
  Future<void> updateProfile({
    required String token,
    required String name,
    required String phone,
    required int avatarId,
  }) async {
    final url = Uri.parse("$_baseUrl/profile");
    final body = json.encode({
      "name": name,
      "phone": phone,
      "avaterId": avatarId,
    });

    final response = await http.patch(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update profile: ${response.statusCode}");
    }
  }

  // NEW: deleteAccount
  Future<void> deleteAccount(String token) async {
    final url = Uri.parse("$_baseUrl/profile");
    final response = await http.delete(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete account: ${response.statusCode}");
    }
  }
}

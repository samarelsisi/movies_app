import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'https://route-movie-apis.vercel.app/auth';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<http.Response> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "phone": phone,
        "avaterId": avaterId,
      }),
    );

    return response;
  }




  Future<Map<String, dynamic>> updateProfile({
    String? email,
    String? name,
    String? phone,
    int? avaterId,
  }) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/profile'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        if (email != null) "email": email,
        if (name != null) "name": name,
        if (phone != null) "phone": phone,
        if (avaterId != null) "avaterId": avaterId,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Profile update failed: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getUserData(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/profile"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to fetch user data");
    }
  }

}


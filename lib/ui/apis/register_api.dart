// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ApiManager {
//   final String baseUrl;
//
//   ApiManager({required this.baseUrl});
//
//   Future<Map<String, dynamic>> registerUser({
//     required String name,
//     required String email,
//     required String password,
//     required String phone,
//   }) async {
//     final url = Uri.parse('$baseUrl/register');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'name': name,
//         'email': email,
//         'password': password,
//         'phone': phone,
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to register user');
//     }
//   }
// }

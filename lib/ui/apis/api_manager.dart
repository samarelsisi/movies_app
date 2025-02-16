import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/MoviesDataResponse.dart';

class ApiManager {
  static Future<MoviesDataResponse> fetchMovies() async {
    final url = Uri.parse('https://yts.mx/api/v2/list_movies.json');
    final response = await http.get(url);

    // Check if the HTTP request was successful
    if (response.statusCode == 200) {
      try {
        // Parse the JSON response into the MoviesDataResponse model
        final data = json.decode(response.body);
        return MoviesDataResponse.fromJson(data);
      } catch (e) {
        // Handle JSON parsing errors
        throw Exception('Failed to parse JSON: $e');
      }
    } else {
      // Handle HTTP errors
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/ui/apis/api_constant.dart';
import 'package:movies/ui/apis/api_endpoints.dart';
import 'package:movies/ui/models/MoviesDetailsResponse.dart';
import 'package:movies/ui/models/movie_suggestion.dart';

import '../models/MoviesDataResponse.dart';

class ApiManager {
   Future<MoviesDataResponse> fetchMovies() async {
    Uri url = Uri.https(ApiConstant.baseUrl,ApiEndPoints.movieList);
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
  static const String _baseUrl = 'https://yts.mx/api/v2/movie_details.json';

   Future<Moviedetails> fetchMovieDetails(int movieId) async {
    final Uri url = Uri.parse('$_baseUrl?movie_id=$movieId&with_images=true&with_cast=true');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Moviedetails.fromJson(data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
     throw e;
    }
  }
  static const String _suggestionUrl = 'https://yts.mx/api/v2/movie_suggestions.json';

   Future<MovieSuggestion> fetchMovieSuggestion(int movieId) async {
    final Uri url = Uri.parse('$_suggestionUrl?movie_id=$movieId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MovieSuggestion.fromJson(data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw e;
    }
  }
}



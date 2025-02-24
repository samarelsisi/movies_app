import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/MoviesDetailsResponse.dart';

class FavoritesService {
  final String _baseUrl = "https://route-movie-apis.vercel.app";

  /// Remove a movie from favorites (both watch list and history)
  Future<bool> removeMovieFromFavorites(String token, String movieId) async {
    final url = Uri.parse("$_baseUrl/favorites/remove/$movieId");
    final response = await http.delete(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    return response.statusCode == 200;
  }

  /// Add a movie to favorites
  Future<bool> addMovieToFavorites(String token, Movie movie) async {
    final url = Uri.parse("$_baseUrl/favorites/add");
    final body = json.encode({
      "movieId": movie.id.toString(),
      "name": movie.title,
      "rating": movie.rating,
      "imageURL": movie.largeCoverImage,
      "year": movie.year.toString(),
    });
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }
}

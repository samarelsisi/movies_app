import 'package:movies/ui/models/movie_suggestion.dart';

abstract class MovieSuggestionRepository{
  Future<MovieSuggestion> fetchMovieSuggestion(int movieId);
}
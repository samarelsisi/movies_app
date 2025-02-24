import 'package:movies/ui/models/movie_suggestion.dart';

abstract class MovieSuggestionDataSource{
  Future<MovieSuggestion> fetchMovieSuggestion(int movieId);

}
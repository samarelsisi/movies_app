import 'package:movies/repository/movie_suggestion/data_source/movie_suggstion_data_source.dart';
import 'package:movies/repository/movie_suggestion/repository/movie_suggestion_repository.dart';
import 'package:movies/ui/models/movie_suggestion.dart';

class MovieSuggestionRepositoryImpl implements MovieSuggestionRepository{
  MovieSuggestionDataSource movieSuggestionDataSource;
  MovieSuggestionRepositoryImpl({required this.movieSuggestionDataSource});
  @override
  Future<MovieSuggestion> fetchMovieSuggestion(int movieId) {
     return movieSuggestionDataSource.fetchMovieSuggestion(movieId);
  }

}
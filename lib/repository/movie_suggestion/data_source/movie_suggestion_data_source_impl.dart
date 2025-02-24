import 'package:movies/repository/movie_suggestion/data_source/movie_suggstion_data_source.dart';
import 'package:movies/ui/apis/api_manager.dart';
import 'package:movies/ui/models/movie_suggestion.dart';

class MovieSuggestionDataSourceImpl implements MovieSuggestionDataSource{
  ApiManager apiManager;
  MovieSuggestionDataSourceImpl({required this.apiManager});
  @override
  Future<MovieSuggestion> fetchMovieSuggestion(int movieId) {
    var response=apiManager.fetchMovieSuggestion(movieId);
    return response;
  }

}
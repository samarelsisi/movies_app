import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/repository/movie_suggestion/data_source/movie_suggestion_data_source_impl.dart';
import 'package:movies/repository/movie_suggestion/data_source/movie_suggstion_data_source.dart';
import 'package:movies/repository/movie_suggestion/repository/movie_suggestion_repository.dart';
import 'package:movies/repository/movie_suggestion/repository/movie_suggestion_repository_impl.dart';
import 'package:movies/ui/apis/api_manager.dart';
import 'package:movies/ui/movieDetails/cubit/movies_details_state.dart';
import 'package:movies/ui/movieDetails/movie_suggestion/cubit/movie_suggestion_state.dart';

class MovieSuggestionCubit extends Cubit<MovieSuggestionState> {
  late ApiManager apiManager;
  late MovieSuggestionDataSource movieSuggestionDataSource;
  late MovieSuggestionRepository movieSuggestionRepository;

  MovieSuggestionCubit() : super(MovieSuggestionLoadingState()){
    apiManager=ApiManager();
    movieSuggestionDataSource=MovieSuggestionDataSourceImpl(apiManager: apiManager);
    movieSuggestionRepository=MovieSuggestionRepositoryImpl(movieSuggestionDataSource: movieSuggestionDataSource);
  }

  Future<void> fetchMovieSuggestion(int movieId) async {
    emit(MovieSuggestionLoadingState());
    try {
      final movieSuggestion = await movieSuggestionRepository.fetchMovieSuggestion(movieId);
      if (movieSuggestion.status == "ok") {
        if (movieSuggestion != null ){
          emit(MovieSuggestionLoadedState(movieSuggestion: movieSuggestion));
        } else {
          emit(MovieSuggestionErrorState(errorMessage:  'Movie not found or no movie data available.'));
        }
      } else {
        emit(MovieSuggestionErrorState(errorMessage: movieSuggestion.statusMessage?? "Unknown error occurred."));
      }
    } catch (e) {
      emit(MovieSuggestionErrorState(errorMessage: 'Failed to load movie details'));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/ui/apis/api_manager.dart';
import 'package:movies/ui/movieDetails/cubit/movies_details_state.dart';
import 'package:movies/ui/movieDetails/movie_suggestion/cubit/movie_suggestion_state.dart';

class MovieSuggestionCubit extends Cubit<MovieSuggestionState> {
  MovieSuggestionCubit() : super(MovieSuggestionLoadingState());

  Future<void> fetchMovieSuggestion(int movieId) async {
    emit(MovieSuggestionLoadingState());
    try {
      final movieSuggestion = await ApiManager.fetchMovieSuggestion(movieId);
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
      emit(MovieSuggestionErrorState(errorMessage: 'Failed to load movie details: ${e.toString()}'));
    }
  }
}

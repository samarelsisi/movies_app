import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/ui/apis/api_manager.dart';
import 'package:movies/ui/movieDetails/cubit/movies_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
  MovieDetailsCubit() : super(MovieLoadingState());

  Future<void> fetchMovieDetails(int movieId) async {
    emit(MovieLoadingState());
    try {
      final movieDetails = await ApiManager.fetchMovieDetails(movieId);
      if (movieDetails.status == "ok") {
        final movie = movieDetails.data?.movie;
        if (movie != null && movie.id == movieId) {
          emit(MovieLoadedState(movieDetails: movie));
        } else {
          emit(MovieErrorState(errorMessage: 'Movie not found or no movie data available.'));
        }
      } else {
        emit(MovieErrorState(errorMessage: movieDetails.statusMessage ?? "Unknown error occurred."));
      }
    } catch (e) {
      emit(MovieErrorState(errorMessage: 'Failed to load movie details: ${e.toString()}'));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/repository/movie_details/dataSource/movie_details_data_source.dart';
import 'package:movies/repository/movie_details/dataSource/movie_details_data_source_impl.dart';
import 'package:movies/repository/movie_details/repository/movie_details_repository.dart';
import 'package:movies/repository/movie_details/repository/movie_details_repository_impl.dart';
import 'package:movies/ui/apis/api_manager.dart';
import 'package:movies/ui/movieDetails/cubit/movies_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
  late ApiManager apiManager;
  late MovieDetailsDataSource movieDetailsDataSource;
  late MovieDetailsRepository movieDetailsRepository;
  MovieDetailsCubit() : super(MovieLoadingState()){
     apiManager=ApiManager();
     movieDetailsDataSource=MovieDetailsDataSourceImpl(apiManager: apiManager);
     movieDetailsRepository=MovieDetailsRepositoryImpl(movieRemoteDataSource: movieDetailsDataSource);
  }

  Future<void> fetchMovieDetails(int movieId) async {
    emit(MovieLoadingState());
    try {
      final movieDetails = await movieDetailsRepository.fetchMovieDetails(movieId);
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
      emit(MovieErrorState(errorMessage: 'Failed to load movie details'));
    }
  }
}

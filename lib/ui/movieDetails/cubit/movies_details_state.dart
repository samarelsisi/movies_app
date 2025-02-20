import 'package:movies/ui/models/MoviesDetailsResponse.dart';

abstract class MovieDetailsStates {}


class MovieLoadingState extends MovieDetailsStates {}


class MovieLoadedState extends MovieDetailsStates {
  final Movie movieDetails;

  MovieLoadedState({required this.movieDetails});
}


class MovieErrorState extends MovieDetailsStates {
  final String errorMessage;

  MovieErrorState({required this.errorMessage});
}

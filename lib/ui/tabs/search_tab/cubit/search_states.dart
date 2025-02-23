import 'package:movies/ui/models/MoviesDataResponse.dart';

abstract class SearchState {}
class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Movies> movies;
  final List<Movies> filteredMovies;

  SearchLoaded({required this.movies, required this.filteredMovies});
}

class SearchError extends SearchState {
   String errorMessage;

  SearchError({required this.errorMessage});
}
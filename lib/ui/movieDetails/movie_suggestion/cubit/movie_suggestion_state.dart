

import 'package:movies/ui/models/movie_suggestion.dart';

abstract class MovieSuggestionState {}


class MovieSuggestionLoadingState extends MovieSuggestionState {}


class MovieSuggestionLoadedState extends MovieSuggestionState {
  final MovieSuggestion  movieSuggestion;

  MovieSuggestionLoadedState({required this.movieSuggestion});
}


class MovieSuggestionErrorState extends MovieSuggestionState {
  final String errorMessage;

  MovieSuggestionErrorState({required this.errorMessage});
}

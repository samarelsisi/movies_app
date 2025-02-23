import 'package:movies/ui/models/MoviesDataResponse.dart';

abstract class MoviesListRepository{
  Future<MoviesDataResponse> fetchMovies();
}
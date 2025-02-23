import 'package:movies/ui/models/MoviesDataResponse.dart';

abstract class MoviesListRemoteDataSource{
  Future<MoviesDataResponse> fetchMovies();

}
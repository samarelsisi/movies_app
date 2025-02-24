import 'package:movies/ui/models/MoviesDetailsResponse.dart';

abstract class MovieDetailsDataSource{
  Future<Moviedetails> fetchMovieDetails(int movieId);
}
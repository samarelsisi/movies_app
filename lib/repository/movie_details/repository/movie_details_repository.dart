import 'package:movies/ui/models/MoviesDetailsResponse.dart';

abstract class MovieDetailsRepository{
  Future<Moviedetails> fetchMovieDetails(int movieId);
}
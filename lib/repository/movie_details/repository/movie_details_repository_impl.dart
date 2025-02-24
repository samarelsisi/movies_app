import 'package:flutter/cupertino.dart';
import 'package:movies/repository/movie_details/dataSource/movie_details_data_source.dart';
import 'package:movies/repository/movie_details/repository/movie_details_repository.dart';
import 'package:movies/ui/models/MoviesDetailsResponse.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository
{
  MovieDetailsDataSource movieRemoteDataSource;
  MovieDetailsRepositoryImpl({required this.movieRemoteDataSource});
  @override
  Future<Moviedetails> fetchMovieDetails(int movieId) {
   return movieRemoteDataSource.fetchMovieDetails(movieId);
  }}
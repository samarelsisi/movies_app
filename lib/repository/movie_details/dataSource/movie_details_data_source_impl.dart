import 'package:flutter/cupertino.dart';
import 'package:movies/repository/movie_details/dataSource/movie_details_data_source.dart';
import 'package:movies/ui/apis/api_manager.dart';
import 'package:movies/ui/models/MoviesDetailsResponse.dart';

class MovieDetailsDataSourceImpl implements MovieDetailsDataSource{
  ApiManager apiManager;
  MovieDetailsDataSourceImpl({required this.apiManager});
  @override
  Future<Moviedetails> fetchMovieDetails(int movieId) async {
    var response=await apiManager.fetchMovieDetails(movieId);
    return response;
  }

}
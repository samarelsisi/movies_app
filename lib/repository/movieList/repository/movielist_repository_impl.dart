import 'package:movies/repository/movieList/dataSource/movielist_remote_datasource.dart';
import 'package:movies/repository/movieList/repository/movielist_repository.dart';
import 'package:movies/ui/models/MoviesDataResponse.dart';

class MoviesListRepositoryImpl implements MoviesListRepository{
  late MoviesListRemoteDataSource remoteDataSource;
  MoviesListRepositoryImpl({required  this.remoteDataSource});
  @override
  Future<MoviesDataResponse> fetchMovies(){
   return remoteDataSource.fetchMovies();
  }

}
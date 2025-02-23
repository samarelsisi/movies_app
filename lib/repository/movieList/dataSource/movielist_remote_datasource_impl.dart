import 'package:movies/repository/movieList/dataSource/movielist_remote_datasource.dart';
import 'package:movies/ui/apis/api_manager.dart';
import 'package:movies/ui/models/MoviesDataResponse.dart';

class MoviesListRemoteDataSourceImpl implements MoviesListRemoteDataSource {
  ApiManager apiManager;
  MoviesListRemoteDataSourceImpl({required this.apiManager});
  @override
  Future<MoviesDataResponse> fetchMovies() async{
   var response=await  apiManager.fetchMovies();
   return response;
  }

}
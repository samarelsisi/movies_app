import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/repository/movieList/dataSource/movielist_remote_datasource.dart';
import 'package:movies/repository/movieList/dataSource/movielist_remote_datasource_impl.dart';
import 'package:movies/repository/movieList/repository/movielist_repository.dart';
import 'package:movies/repository/movieList/repository/movielist_repository_impl.dart';
import 'package:movies/ui/apis/api_manager.dart';
import 'package:movies/ui/tabs/home_tab/cubit/movies_state.dart';
//hold data =>handel errors
class MoviesViewModel extends Cubit<MoviesStates>{
  late MoviesListRepository moviesListRepository;
  late MoviesListRemoteDataSource moviesListRemoteDataSource;
  late ApiManager apiManager;
  MoviesViewModel():super(MoviesLoadingState()){
    apiManager=ApiManager();
    moviesListRemoteDataSource=MoviesListRemoteDataSourceImpl(apiManager: apiManager);
    moviesListRepository=MoviesListRepositoryImpl(remoteDataSource:moviesListRemoteDataSource );
  }// loading init state
  void getMovies()async{
    try{
      emit(MoviesLoadingState());
      var response=await moviesListRepository.fetchMovies();
      if(response?.status=='error'){
        
      emit(MoviesErrorState(errorMessage: response!.statusMessage!));

      }
      if(response?.status=='ok'){}
        emit(MoviesLoadedState(moviesList: response!.data!.movies!));
    }

  catch(e){
      
  emit(MoviesErrorState(errorMessage: e.toString()));
  }
}
}
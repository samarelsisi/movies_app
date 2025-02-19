import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/ui/apis/api_manager.dart';
import 'package:movies/ui/tabs/home_tab/cubit/movies_state.dart';
//hold data =>handel errors
class MoviesViewModel extends Cubit<MoviesStates>{
  MoviesViewModel():super(MoviesLoadingState());// loading init state
  void getMovies()async{
    try{
      emit(MoviesLoadingState());
      var response=await ApiManager.fetchMovies();
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
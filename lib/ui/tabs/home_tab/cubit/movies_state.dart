import '../../../models/MoviesDataResponse.dart';

abstract class MoviesStates{

}//parent class
class MoviesLoadingState extends MoviesStates{}
class MoviesLoadedState extends MoviesStates{
  List<Movies>moviesList;
  MoviesLoadedState({required this.moviesList});
}
class MoviesErrorState extends MoviesStates{
  String errorMessage;
  MoviesErrorState({required this.errorMessage});

}
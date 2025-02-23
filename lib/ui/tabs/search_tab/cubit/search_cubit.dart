import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/repository/movieList/dataSource/movielist_remote_datasource.dart';
import 'package:movies/repository/movieList/dataSource/movielist_remote_datasource_impl.dart';
import 'package:movies/repository/movieList/repository/movielist_repository.dart';
import 'package:movies/repository/movieList/repository/movielist_repository_impl.dart';
import 'package:movies/ui/apis/api_manager.dart';
import 'package:movies/ui/models/MoviesDataResponse.dart';
import 'package:movies/ui/tabs/search_tab/cubit/search_states.dart';

class SearchCubit extends Cubit<SearchState> {
  late MoviesListRepository moviesListRepository;
  late MoviesListRemoteDataSource moviesListRemoteDataSource;
  late ApiManager apiManager;
  SearchCubit() : super(SearchLoading()){
    apiManager=ApiManager();
    moviesListRemoteDataSource=MoviesListRemoteDataSourceImpl(apiManager: apiManager);
    moviesListRepository=MoviesListRepositoryImpl(remoteDataSource:moviesListRemoteDataSource);
  }

  List<Movies> movies = [];
  List<Movies> filteredMovies = [];

  void fetchMovies() async {
    emit(SearchLoading());
    try {
      var response=await moviesListRepository.fetchMovies();
      movies = response.data!.movies!;
      filteredMovies = movies; // Initialize filteredMovies with all movies
      emit(SearchLoaded(movies: movies, filteredMovies: filteredMovies));
    } catch (e) {
      emit(SearchError(errorMessage: e.toString()));
    }
  }

  void searchMovies(String query) {
    if (query.isEmpty) {
      // If the query is empty, show all movies
      emit(SearchLoaded(movies: movies, filteredMovies: movies));
    } else {
      // Filter movies based on the search query
      final filtered = movies.where((movie) {
        final title = movie.title?.toLowerCase() ?? '';
        return title.contains(query.toLowerCase());
      }).toList();
      emit(SearchLoaded(movies: movies, filteredMovies: filtered));
    }
  }
}
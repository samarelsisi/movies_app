import 'package:bloc/bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/services/favorites_service.dart';
import '../../../models/MoviesDetailsResponse.dart';
import '../../profile_tab/favorites_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesService favoritesService;
  final FavoritesRepository favoritesRepository;

  FavoritesCubit({
    required this.favoritesService,
    required this.favoritesRepository,
  }) : super(FavoritesState.initial());

  /// Initializes local status based on local storage.
  Future<void> initializeStatus(int movieId) async {
    final movieIdStr = movieId.toString();
    List<String> watchList = await favoritesRepository.getWatchList();
    List<String> historyList = await favoritesRepository.getHistoryList();
    emit(state.copyWith(
      isInWatchList: watchList.contains(movieIdStr),
      isInHistory: historyList.contains(movieIdStr),
    ));
  }

  /// Toggles the watch list status for a movie.
  Future<void> toggleWatchList(Movie movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");
    if (token == null) return;
    final movieIdStr = movie.id.toString();

    if (state.isInWatchList) {
      // Remove from watch list
      bool success = await favoritesService.removeMovieFromFavorites(token, movieIdStr);
      if (success) {
        await favoritesRepository.removeMovieFromLocal(movieIdStr, "watch");
        // If the movie is also in history, re-add it (to keep it on the server)
        List<String> historyList = await favoritesRepository.getHistoryList();
        if (historyList.contains(movieIdStr)) {
          await favoritesService.addMovieToFavorites(token, movie);
        }
        emit(state.copyWith(isInWatchList: false));
      }
    } else {
      // Add to watch list
      bool success = await favoritesService.addMovieToFavorites(token, movie);
      if (success) {
        await favoritesRepository.saveMovieToLocal(movieIdStr, "watch");
        emit(state.copyWith(isInWatchList: true));
      }
    }
  }

  /// Toggles the history status for a movie.
  Future<void> toggleHistory(Movie movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");
    if (token == null) return;
    final movieIdStr = movie.id.toString();

    if (state.isInHistory) {
      bool success = await favoritesService.removeMovieFromFavorites(token, movieIdStr);
      if (success) {
        await favoritesRepository.removeMovieFromLocal(movieIdStr, "history");
        // If the movie is still in watch list, re-add it.
        List<String> watchList = await favoritesRepository.getWatchList();
        if (watchList.contains(movieIdStr)) {
          await favoritesService.addMovieToFavorites(token, movie);
        }
        emit(state.copyWith(isInHistory: false));
      }
    } else {
      bool success = await favoritesService.addMovieToFavorites(token, movie);
      if (success) {
        await favoritesRepository.saveMovieToLocal(movieIdStr, "history");
        emit(state.copyWith(isInHistory: true));
      }
    }
  }
}

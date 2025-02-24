import 'package:shared_preferences/shared_preferences.dart';

class FavoritesRepository {
  Future<void> saveMovieToLocal(String movieId, String listType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> watchList = prefs.getStringList('watchList') ?? [];
    List<String> historyList = prefs.getStringList('historyList') ?? [];

    if (listType == "watch") {
      if (!watchList.contains(movieId)) {
        watchList.add(movieId);
        await prefs.setStringList('watchList', watchList);
      }
    } else if (listType == "history") {
      if (!historyList.contains(movieId)) {
        historyList.add(movieId);
        await prefs.setStringList('historyList', historyList);
      }
    }
  }

  Future<void> removeMovieFromLocal(String movieId, String listType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (listType == "watch") {
      List<String> watchList = prefs.getStringList('watchList') ?? [];
      watchList.remove(movieId);
      await prefs.setStringList('watchList', watchList);
    } else if (listType == "history") {
      List<String> historyList = prefs.getStringList('historyList') ?? [];
      historyList.remove(movieId);
      await prefs.setStringList('historyList', historyList);
    }
  }

  Future<List<String>> getWatchList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('watchList') ?? [];
  }

  Future<List<String>> getHistoryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('historyList') ?? [];
  }
}

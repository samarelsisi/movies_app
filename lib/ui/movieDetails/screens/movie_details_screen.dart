import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/movieDetails/cubit/movie_details_view_model.dart';
import 'package:movies/ui/movieDetails/cubit/movies_details_state.dart';
import 'package:movies/ui/movieDetails/screens/genres_item.dart';
import 'package:movies/ui/movieDetails/screens/movie_cast_information.dart';
import 'package:movies/ui/movieDetails/screens/movie_head.dart';
import 'package:movies/ui/movieDetails/movie_suggestion/movies_suggestion_screen.dart';
import 'package:movies/ui/movieDetails/screens/screenshot.dart';
import 'package:movies/ui/widgets/cutom_button.dart';
import 'package:movies/ui/widgets/movie_informatiom_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/MoviesDetailsResponse.dart';
import '../../tabs/profile_tab/favorites_repository.dart';
import 'package:http/http.dart' as http;


class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  MovieDetailsScreen({required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsCubit viewModel = MovieDetailsCubit();
  bool isInHistory = false;
  bool isInWatchList = false;

  @override
  void initState() {
    super.initState();

    viewModel.fetchMovieDetails(widget.movieId);
    // Optionally, check local storage to initialize isInWatchList/isInHistory.
    _initializeLocalStatus();
  }

  Future<void> _initializeLocalStatus() async {
    final repo = FavoritesRepository();
    List<String> watchList = await repo.getWatchList();
    List<String> historyList = await repo.getHistoryList();
    // Assuming movie.id is a String
    final movieId = widget.movieId.toString();
    setState(() {
      isInWatchList = watchList.contains(movieId);
      isInHistory = historyList.contains(movieId);
    });
  }
  Future<void> toggleWatchList(Movie movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");
    if (token == null) return;
    final repo = FavoritesRepository();
    final movieId = movie.id.toString();

    if (isInWatchList) {
      // Remove from watch list:
      final url = Uri.parse("https://route-movie-apis.vercel.app/favorites/remove/$movieId");
      final response = await http.delete(url, headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        await repo.removeMovieFromLocal(movieId, "watch");
        // If the movie is also in history, re-add it (so that it remains on the server).
        List<String> historyList = await repo.getHistoryList();
        if (historyList.contains(movieId)) {
          await _addMovieToFavorites(movie); // re-add to server
        }
        setState(() {
          isInWatchList = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Removed from Watch List"), backgroundColor: AppColors.greenColor),
        );
      }
    } else {
      // Add to watch list:
      final success = await _addMovieToFavorites(movie);
      if (success) {
        await repo.saveMovieToLocal(movieId, "watch");
        setState(() {
          isInWatchList = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Added to Watch List"), backgroundColor: AppColors.greenColor),
        );
      }
    }
  }

  Future<void> toggleHistory(Movie movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");
    if (token == null) return;
    final repo = FavoritesRepository();
    final movieId = movie.id.toString();

    if (isInHistory) {
      // Remove from history:
      final url = Uri.parse("https://route-movie-apis.vercel.app/favorites/remove/$movieId");
      final response = await http.delete(url, headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        await repo.removeMovieFromLocal(movieId, "history");
        // If the movie is still in watch list, re-add it.
        List<String> watchList = await repo.getWatchList();
        if (watchList.contains(movieId)) {
          await _addMovieToFavorites(movie);
        }
        setState(() {
          isInHistory = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Removed from History"), backgroundColor: AppColors.greenColor),
        );
      }
    } else {
      // Add to history:
      final success = await _addMovieToFavorites(movie);
      if (success) {
        await repo.saveMovieToLocal(movieId, "history");
        setState(() {
          isInHistory = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Added to History"), backgroundColor: AppColors.greenColor),
        );
      }
    }
  }

  /// Helper function to call the API to add a movie to favorites.
  Future<bool> _addMovieToFavorites(Movie movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");
    if (token == null) return false;

    final url = Uri.parse("https://route-movie-apis.vercel.app/favorites/add");
    final body = json.encode({
      "movieId": movie.id.toString(),
      "name": movie.title,
      "rating": movie.rating,
      "imageURL": movie.largeCoverImage,
      "year": movie.year.toString(),
    });
    final response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<MovieDetailsCubit, MovieDetailsStates>(
        builder: (context, state) {
          if (state is MovieErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage, style: AppStyle.semi20Yellow),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        viewModel.fetchMovieDetails(widget.movieId);
                      }); // Refresh the FutureBuilder
                    },
                    child: const Text("Try again"),
                  ),
                ],
              ),
            );
          } else if (state is MovieLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.yellowColor),
            );
          } else if (state is MovieLoadedState) {
            final movie = state.movieDetails;
            final List<dynamic> screenShots = [
              movie.mediumScreenshotImage1,
              movie.mediumScreenshotImage2,
              movie.mediumScreenshotImage3
            ];
            final genres = movie.genres;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MovieHead(
                    image: movie.largeCoverImage!,
                    title: movie.title!,
                    year: movie.year.toString(),
                    isInHistory: isInHistory,
                    onHistoryToggle: () => toggleHistory(movie),
                  ),
                  Container(
                      padding: EdgeInsets.all(16),
                      child: CustomButton(
                          color: AppColors.redColor,
                        text: isInWatchList ? "Remove from Watch List" : "Watch",
                        textColor: AppColors.whiteColor,
                        onPressed: () => toggleWatchList(movie),)),
                  Row(
                    children: [
                      MovieInformatiomItem(
                          icon: Icons.favorite,
                          text: movie.likeCount.toString()),
                      MovieInformatiomItem(
                          icon: Icons.access_time_filled_outlined,
                          text: movie.runtime.toString()),
                      MovieInformatiomItem(
                          icon: Icons.star_rate_rounded,
                          text: movie.rating.toString())
                    ],
                  ),
                  Text(
                    "Screen Shots",
                    style: AppStyle.bold24White,
                  ),
                  Screenshot(screenShots: screenShots, index: 0),
                  SizedBox(
                    height: 8,
                  ),
                  Screenshot(screenShots: screenShots, index: 1),
                  SizedBox(
                    height: 8,
                  ),
                  Screenshot(screenShots: screenShots, index: 2),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Similar",
                    style: AppStyle.bold24White,
                  ),
                  MoviesSuggestionScreen(movieId: widget.movieId),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Summary",
                    style: AppStyle.bold24WhiteRoboto,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    movie.descriptionFull!.isEmpty
                        ? "This movie not have summary"
                        : movie.descriptionFull!,
                    style: AppStyle.regular20White,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Cast",
                    style: AppStyle.bold24WhiteRoboto,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MovieCastInformation(cast: movie.cast ?? []),
                  Text(
                    "Genres",
                    style: AppStyle.bold24WhiteRoboto,
                  ),
                  GenresItem(genres: genres ?? []),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    ));
  }
}

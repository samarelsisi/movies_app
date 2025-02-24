// lib/ui/movieDetails/screens/movie_details_screen.dart
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

import '../../tabs/home_tab/cubit/favorites_cubit.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({required this.movieId, Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsCubit movieDetailsCubit = MovieDetailsCubit();

  @override
  void initState() {
    super.initState();
    movieDetailsCubit.fetchMovieDetails(widget.movieId);
    // Initialize favorites status via the cubit.
    context.read<FavoritesCubit>().initializeStatus(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailsCubit>.value(value: movieDetailsCubit),
          // FavoritesCubit is provided higher in the widget tree (e.g., via a route wrapper)
        ],
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
                        movieDetailsCubit.fetchMovieDetails(widget.movieId);
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
                movie.mediumScreenshotImage3,
              ];
              final genres = movie.genres;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Movie head with history toggle.
                    MovieHead(
                      image: movie.largeCoverImage!,
                      title: movie.title!,
                      year: movie.year.toString(),
                      isInHistory: context.select<FavoritesCubit, bool>(
                            (cubit) => cubit.state.isInHistory,
                      ),
                      onHistoryToggle: () =>
                          context.read<FavoritesCubit>().toggleHistory(movie),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: CustomButton(
                        color: AppColors.redColor,
                        text: context.select<FavoritesCubit, bool>(
                                (cubit) => cubit.state.isInWatchList)
                            ? "Remove from Watch List"
                            : "Watch",
                        textColor: AppColors.whiteColor,
                        onPressed: () =>
                            context.read<FavoritesCubit>().toggleWatchList(movie),
                      ),
                    ),
                    Row(
                      children: [
                        MovieInformatiomItem(
                          icon: Icons.favorite,
                          text: movie.likeCount.toString(),
                        ),
                        MovieInformatiomItem(
                          icon: Icons.access_time_filled_outlined,
                          text: movie.runtime.toString(),
                        ),
                        MovieInformatiomItem(
                          icon: Icons.star_rate_rounded,
                          text: movie.rating.toString(),
                        )
                      ],
                    ),
                    Text("Screen Shots", style: AppStyle.bold24White),
                    Screenshot(screenShots: screenShots, index: 0),
                    const SizedBox(height: 8),
                    Screenshot(screenShots: screenShots, index: 1),
                    const SizedBox(height: 8),
                    Screenshot(screenShots: screenShots, index: 2),
                    const SizedBox(height: 8),
                    Text("Similar", style: AppStyle.bold24White),
                    MoviesSuggestionScreen(movieId: widget.movieId),
                    const SizedBox(height: 8),
                    Text("Summary", style: AppStyle.bold24WhiteRoboto),
                    const SizedBox(height: 8),
                    Text(
                      movie.descriptionFull?.isEmpty ?? true
                          ? "This movie not have summary"
                          : movie.descriptionFull!,
                      style: AppStyle.regular20White,
                    ),
                    const SizedBox(height: 8),
                    Text("Cast", style: AppStyle.bold24WhiteRoboto),
                    const SizedBox(height: 20),
                    MovieCastInformation(cast: movie.cast ?? []),
                    Text("Genres", style: AppStyle.bold24WhiteRoboto),
                    const SizedBox(height: 20),
                    GenresItem(genres: genres ?? []),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

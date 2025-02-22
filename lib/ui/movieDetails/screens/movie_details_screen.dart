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
import 'package:movies/ui/movieDetails/screens/movie_web.dart';
import 'package:movies/ui/movieDetails/screens/screenshot.dart';
import 'package:movies/ui/widgets/cutom_button.dart';
import 'package:movies/ui/widgets/movie_informatiom_item.dart';
class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
   MovieDetailsScreen({required this.movieId}) ;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsCubit viewModel=MovieDetailsCubit();

  @override
  void initState() {
    super.initState();

    viewModel.fetchMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => viewModel,
        child: BlocBuilder<MovieDetailsCubit,MovieDetailsStates>(builder:
            (context, state) {
              if(state is MovieErrorState){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.errorMessage,style: AppStyle.semi20Yellow),
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
              }
              else if(state is MovieLoadingState){
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.yellowColor),
                );
              }
              else if(state is MovieLoadedState){
                final movie=state.movieDetails;
                 final List <dynamic> screenShots=[movie.mediumScreenshotImage1,movie.mediumScreenshotImage2,movie.mediumScreenshotImage3];
                 final genres=movie.genres;
                return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                                 MovieHead(image: movie.largeCoverImage!, title: movie.title!, year: movie.year.toString(),url: movie.url!,)
                          ,
                              Container(
                                  padding: EdgeInsets.all(16),
                                  child: CustomButton(
                                      color: AppColors.redColor,text: "Watch",
                                      textColor: AppColors.whiteColor,
                                      onPressed: (){
                                        // if (movie!.url != null && movie!.url!.isNotEmpty) {
                                        //   Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) => MovieWebViewScreen(url: movie.url!),
                                        //     ),
                                        //   );
                                        // } else {
                                        //   ScaffoldMessenger.of(context).showSnackBar(
                                        //     const SnackBar(content: Text("Watch link not available")),
                                        //   );
                                        // }
                                      }))
                                 , Row(
                                    children: [
                                      MovieInformatiomItem(icon: Icons.favorite, text: movie.likeCount.toString())
                                     , MovieInformatiomItem(icon: Icons.access_time_filled_outlined, text: movie.runtime.toString())
                                     , MovieInformatiomItem(icon: Icons.star_rate_rounded, text: movie.rating.toString())
                                    ],
                                  )
,                           Text("Screen Shots",style: AppStyle.bold24White,),
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
                          Text("Similar",style: AppStyle.bold24White,),
                            MoviesSuggestionScreen(movieId: widget.movieId),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Summary",style: AppStyle.bold24WhiteRoboto,),
                              SizedBox(
                                height: 8,
                              ),
                              Text(movie.descriptionFull!.isEmpty?"This movie not have summary":movie.descriptionFull!,style: AppStyle.regular20White,)
                               ,   SizedBox(
                                height: 8,
                                )
                              ,Text("Cast",style: AppStyle.bold24WhiteRoboto,),
                              SizedBox(
                                height: 20,
                              ),
                              MovieCastInformation(cast: movie.cast ??[]),
                             Text("Genres",style: AppStyle.bold24WhiteRoboto,),
                             GenresItem(genres: genres??[]),
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
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/apis/api_manager.dart';
import 'package:movies/ui/movieDetails/cubit/movie_details_view_model.dart';
import 'package:movies/ui/movieDetails/cubit/movies_details_state.dart';
import 'package:movies/ui/movieDetails/movie_head.dart';
import 'package:movies/ui/tabs/home_tab/cubit/movies_state.dart';
import 'package:movies/ui/widgets/cutom_button.dart';
import 'package:movies/ui/widgets/movie_informatiom_item.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

   MovieDetailsScreen({required this.movieId}) ;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<Map<String, dynamic>?> _movieDetailsFuture;
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
                return SingleChildScrollView(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                 MovieHead(image: movie.largeCoverImage!, title: movie.title!, year: movie.year.toString())
                          ,
                              Container(
                                  padding: EdgeInsets.all(16),
                                  child: CustomButton( color: AppColors.redColor,text: "Watch",textColor: AppColors.whiteColor,onPressed: (){}))
                                 , Row(
                                    children: [
                                      MovieInformatiomItem(icon: Icons.favorite, text: movie.likeCount.toString())
                                     , MovieInformatiomItem(icon: Icons.access_time_filled_outlined, text: movie.runtime.toString())
                                     , MovieInformatiomItem(icon: Icons.star_rate_rounded, text: movie.rating.toString())
                                    ],
                                  )
,                            Text("Screen Shots",style: AppStyle.bold24White,),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        screenShots[0],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),),
                              SizedBox(
                                height: 8,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(
                                  screenShots[1],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(
                                  screenShots[2],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        );
              }
              return Container();
            },
        ),
      )

      // FutureBuilder<Map<String, dynamic>?>(
      //   future: _movieDetailsFuture,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     } else if (!snapshot.hasData) {
      //       return const Center(child: Text('No data found.'));
      //     }
      //
      //     final movie = snapshot.data!;
      //     return
      //     SingleChildScrollView(
      //       padding: const EdgeInsets.all(16),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           if (movie['large_cover_image'] != null)
      //             ClipRRect(
      //               borderRadius: BorderRadius.circular(16),
      //               child: Image.network(movie['large_cover_image']),
      //             ),
      //           const SizedBox(height: 16),
      //           Text(
      //             movie['title_long'] ?? 'No Title',
      //             style: AppStyle.bold14Yellow,
      //           ),
      //           const SizedBox(height: 8),
      //           Text(
      //             'Rating: ${movie['rating'] ?? 'N/A'} ⭐ | Runtime: ${movie['runtime']} mins',
      //             style: AppStyle.regular16WhiteRoboto
      //           ),
      //           const SizedBox(height: 16),
      //           Text(
      //             movie['description_full'] ?? 'No description available.',
      //             style:  AppStyle.regular16WhiteRoboto,
      //           ),
      //           const SizedBox(height: 20),
      //           if (movie['cast'] != null) ...[
      //             Text(
      //               'Cast:',
      //               style:  AppStyle.regular16WhiteRoboto,
      //             ),
      //             const SizedBox(height: 10),
      //             SizedBox(
      //               height: 120,
      //               child: ListView.builder(
      //                 scrollDirection: Axis.horizontal,
      //                 itemCount: movie['cast'].length,
      //                 itemBuilder: (context, index) {
      //                   final cast = movie['cast'][index];
      //                   return Container(
      //                     width: 100,
      //                     margin: const EdgeInsets.only(right: 12),
      //                     child: Column(
      //                       children: [
      //                         CircleAvatar(
      //                           radius: 40,
      //                           backgroundImage: cast['url_small_image'] != null
      //                               ? NetworkImage(cast['url_small_image'])
      //                               : null,
      //                           child: cast['url_small_image'] == null
      //                               ? const Icon(Icons.person, size: 40)
      //                               : null,
      //                         ),
      //                         const SizedBox(height: 8),
      //                         Text(
      //                           cast['name'] ?? '',
      //                           textAlign: TextAlign.center,
      //                           overflow: TextOverflow.ellipsis,
      //                         ),
      //                       ],
      //                     ),
      //                   );
      //                 },
      //               ),
      //             ),
      //           ],
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

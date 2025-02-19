import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/tabs/home_tab/cubit/movies_state.dart';
import 'package:movies/ui/tabs/home_tab/cubit/movies_view_model.dart';
import 'package:movies/ui/tabs/home_tab/movies_list.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_image.dart';
import '../../apis/api_manager.dart';
import '../../models/MoviesDataResponse.dart';
import '../explore_tab/movies_carousel.dart';

class HomeTab extends StatefulWidget {

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<HomeTab> {
  late Future<MoviesDataResponse> futureMovies;
  MoviesViewModel viewModel=MoviesViewModel();

  @override
  void initState() {
    super.initState();
    // futureMovies = ApiManager.fetchMovies();
    viewModel.getMovies();
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<MoviesViewModel,MoviesStates>
        (builder:(context, state){
          if(state is MoviesLoadingState){
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.yellowColor),
                );
          }
          else if(state is MoviesLoadedState){
              if (state.moviesList.isEmpty) {
                return const Center(
                  child: Text("No Movies found for this source."),
                );
              }
              return MoviesList(movies: state.moviesList);
          }
          else if(state is MoviesErrorState){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(state.errorMessage,style: AppStyle.semi20Yellow),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            viewModel.getMovies();
                          }); // Refresh the FutureBuilder
                        },
                        child: const Text("Try again"),
                      ),
                    ],
                  ),
                );
          }
          return Container();
        }, ),
    );
          
      
      //  FutureBuilder(
          //    future: ApiManager.fetchMovies(),
          // builder: (context, snapshot){
          //   if(snapshot.connectionState==ConnectionState.waiting){
          //     return const Center(
          //       child: CircularProgressIndicator(color: AppColors.yellowColor),
          //     );
          //   }
          //   else if(snapshot.hasError){
          //     return Center(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //            Text("Something went wrong!",style: AppStyle.semi20Yellow),
          //           ElevatedButton(
          //             onPressed: () {
          //               setState(() {}); // Refresh the FutureBuilder
          //             },
          //             child: const Text("Try again"),
          //           ),
          //         ],
          //       ),
          //     );
          //   }
          // else if (!snapshot.hasData || snapshot.data!.status != 'ok') {
          //
          //     return Center(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(snapshot.data?.statusMessage?? "No data available",style: AppStyle.semi20Yellow),
          //           ElevatedButton(
          //             onPressed: () {
          //               setState(() {}); // Refresh the FutureBuilder
          //             },
          //             child: const Text("Try again"),
          //           ),
          //         ],
          //       ),
          //     );
          //   }
          //   var moviesList = snapshot.data!.data!.movies ?? [];
          //   if (moviesList.isEmpty) {
          //     return const Center(
          //       child: Text("No Movies found for this source."),
          //     );
          //   }
          //   return MoviesList(movies: moviesList);
          //
          // },)

  }
}

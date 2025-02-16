import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/tabs/home_tab/movies_list.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_image.dart';
import '../../apis/api_manager.dart';
import '../../models/MoviesDataResponse.dart';
import 'movies_carousel.dart';



class HomeTab extends StatefulWidget {

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<HomeTab> {
  List movies = [];
  late Future<MoviesDataResponse> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = ApiManager.fetchMovies();
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body:
           FutureBuilder(
             future: ApiManager.fetchMovies(),
          builder: (context, snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(color: AppColors.yellowColor),
              );
            }
            else if(snapshot.hasError){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text("Something went wrong!",style: AppStyle.semi20Yellow),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {}); // Refresh the FutureBuilder
                      },
                      child: const Text("Try again"),
                    ),
                  ],
                ),
              );
            }
          else if (!snapshot.hasData || snapshot.data!.status != 'ok') {

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data?.statusMessage?? "No data available",style: AppStyle.semi20Yellow),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {}); // Refresh the FutureBuilder
                      },
                      child: const Text("Try again"),
                    ),
                  ],
                ),
              );
            }
            var moviesList = snapshot.data!.data!.movies ?? [];
            if (moviesList.isEmpty) {
              return const Center(
                child: Text("No Movies found for this source."),
              );
            }
            return MoviesList(movies: moviesList);

          },)
      ,
      

    );
  }
}

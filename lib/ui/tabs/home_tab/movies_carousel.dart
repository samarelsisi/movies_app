import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies/ui/movieDetails/screens/movie_details_screen.dart';

import '../../models/MoviesDataResponse.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_style.dart';


class MovieCarousel extends StatelessWidget {
  final List<Movies> movies;

  MovieCarousel({required this.movies});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return CarouselSlider(
      options: CarouselOptions(
        height: height*.4, // Height of the carousel
        autoPlay: true, // Auto-play the carousel
        enlargeCenterPage: true, // Enlarge the center image
        aspectRatio: 2, // Aspect ratio of the images
        autoPlayCurve: Curves.fastOutSlowIn, // Animation curve
        enableInfiniteScroll: true, // Infinite scrolling
        autoPlayAnimationDuration: Duration(milliseconds: 800), // Animation duration
        viewportFraction: 0.6, // Fraction of the viewport to show
      ),
      items: movies.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(

              children:[
                ClipRRect(borderRadius: BorderRadius.all(Radius.circular(20)),
                    child:
                    Image.network(
                      movie.mediumCoverImage ?? '', // Use medium-sized cover image
                      fit: BoxFit.cover, // Cover the entire container
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(Icons.error, color: AppColors.redColor),
                        ); // Show an error icon if the image fails to load
                      },
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin:EdgeInsets.all(5) ,
                    width: width*.2,
                    height:height*.04 ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color:  Color(0x14121312).withOpacity(0.9),
                    )
                    ,
                    padding: EdgeInsets.only(left: width*.03,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("${movie.rating.toString()}"??" ",style: AppStyle.regular16WhiteRoboto,),
                        Icon(Icons.star_rate_rounded,color: AppColors.yellowColor,)
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
    );
  }
}
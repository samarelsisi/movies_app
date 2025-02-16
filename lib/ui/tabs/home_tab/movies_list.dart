

import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_image.dart';
import '../../../theme/app_style.dart';
import '../../models/MoviesDataResponse.dart';
import 'movies_carousel.dart';

class MoviesList extends StatelessWidget {
  final List<Movies> movies;
  MoviesList({required this.movies ,super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return  SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: height*.68,
            child: Stack(
              children: [
                Image.asset(AppImage.homeBg,fit: BoxFit.cover,width: double.infinity,),
                Align(
                    child: MovieCarousel(movies: movies)),
                SizedBox(
                  height: .1,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Action",style: AppStyle.regular20WhiteRoboto,),
                Row(
                  children: [
                    Text("See More",style: AppStyle.bold14Yellow,),
                    SizedBox(
                      width: width*.02,
                    ),
                    Icon(Icons.arrow_forward,color: AppColors.yellowColor,)
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: height*.3,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: width*.04,
                );
              },
              itemCount:movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Stack(
                      children:[
                        ClipRRect(borderRadius: BorderRadius.all(Radius.circular(20)),
                            child:
                            Image.network(
                              movies[index].mediumCoverImage ?? '', // Use medium-sized cover image
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
                                Text("${movies[index].rating.toString()}"??" ",style: AppStyle.regular16WhiteRoboto,),
                                Icon(Icons.star_rate_rounded,color: AppColors.yellowColor,)
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },),
          )
        ],
      ),
    );;
  }
}

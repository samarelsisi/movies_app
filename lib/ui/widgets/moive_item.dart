import 'package:flutter/material.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/models/MoviesDataResponse.dart';

import '../../theme/app_colors.dart';

class MoiveItem extends StatelessWidget {
  final List<Movies> movies;
  final int index;
  final double? imageWidth;
   MoiveItem({required this.movies,required this.index, this.imageWidth,super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Stack(
      children: [
        ClipRRect(
            borderRadius:
            BorderRadius.all(Radius.circular(20)),
            child: Image.network(
              movies[index].mediumCoverImage! ?? '',
              // Use medium-sized cover image
              fit: BoxFit.cover,
              width:imageWidth ,
              // Cover the entire container
              errorBuilder:
                  (context, error, stackTrace) {
                return Center(
                  child: Icon(Icons.error,
                      color: AppColors.redColor),
                ); // Show an error icon if the image fails to load
              },
            )),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.all(5),
            width: width * .2,
            height: height * .04,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0x14121312).withOpacity(0.9),
            ),
            padding: EdgeInsets.only(
              left: width * .03,
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${movies[index].rating.toString()}" ??
                      " ",
                  style: AppStyle.regular16WhiteRoboto,
                ),
                Icon(
                  Icons.star_rate_rounded,
                  color: AppColors.yellowColor,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

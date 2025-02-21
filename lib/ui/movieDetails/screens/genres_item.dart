import 'package:flutter/material.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_style.dart';

class GenresItem extends StatelessWidget {
  List<dynamic>genres;
   GenresItem({required this.genres,super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          // Number of columns in the grid
          crossAxisSpacing: 20,
          // Horizontal space between items
          mainAxisSpacing: 8,
          // Vertical space between items
          childAspectRatio:
          3, // Aspect ratio of each item (width / height)
        ),
        itemCount: genres!.length?? 0,
        itemBuilder: (context, index) {
          return Container(
            height: 30,
            padding: EdgeInsets.symmetric(
                vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.circular(16)

            ),
            child: Text(genres[index], style: AppStyle
                .regular16WhiteRoboto,textAlign: TextAlign.center,),
          );
        }
    );
  }
}

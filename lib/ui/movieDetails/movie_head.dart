import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_image.dart';
import 'package:movies/theme/app_style.dart';

class MovieHead extends StatelessWidget {
  final String image;
  final String title;
  final String year;

  const MovieHead({
    required this.image,
    required this.title,
    required this.year,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.68,
      child: Stack(
        children: [
      Image.network(
      image ?? '',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(Icons.error, color: AppColors.redColor),
          ); // Show an error icon if the image fails to load
        },
      ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 16),
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.bookmark,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: AppStyle.bold24WhiteRoboto,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    year,
                    style: AppStyle.bold20WhiteRoboto,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

          ),
          InkWell(
            onTap: (){},
            child: Align(
              child: Image.asset(AppImage.play),
              alignment: Alignment.center,
            ),
          )
        ],
      ),
    );
  }
}

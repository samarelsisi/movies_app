import 'package:flutter/material.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_image.dart';
import 'package:movies/theme/app_style.dart';
import 'package:movies/ui/home_screen.dart';

class MovieHead extends StatefulWidget {
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
  State<MovieHead> createState() => _MovieHeadState();
}

class _MovieHeadState extends State<MovieHead> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SizedBox(
        height: height * 0.68,
        child: Stack(
          children: [
            // Background Image
            Image.network(
              widget.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(Icons.error, color: AppColors.redColor),
                );
              },
            ),

            // Back Button
            Positioned(
              left: 16,
              top: 16,
              child: IconButton(
                onPressed: () {
                  debugPrint("Back button pressed");
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
            ),

            // Save Button
            Positioned(
              right: 16,
              top: 16,
              child: IconButton(
                onPressed: () {
                  debugPrint("Save button pressed");
                },
                icon: Icon(
                  Icons.bookmark,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
            ),

            // Movie Title and Year
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: AppStyle.bold24WhiteRoboto,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.year,
                      style: AppStyle.bold20WhiteRoboto,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Play Button
            Align(
              child: InkWell(
                  onTap: (){
                    print("button play");
                  },
                  child:
              const Image(image: AssetImage(AppImage.play)
              )

              ),
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
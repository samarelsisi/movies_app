import 'package:flutter/material.dart';



import '../theme/app_colors.dart';
import '../theme/app_image.dart';
import '../theme/app_style.dart';
import 'onboarding_screen.dart';

class IntroScreen extends StatelessWidget {
  static const String routeName = 'introScreen';

  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImage.onBoarding1,
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF121312).withOpacity(0.0),
                    const Color(0xFF121312).withOpacity(0.5),
                    const Color(0xFF1E1E1E).withOpacity(0.91),
                    const Color(0xFF1E1E1E).withOpacity(1.0),
                  ],
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:  EdgeInsets.only(bottom: height*.05, right: width*.03, left:width*.03,),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'Find Your Next\nFavorite Movie Here',
                      textAlign: TextAlign.center,
                      style: AppStyle.medium36White
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Get access to a huge library of movies \nto suit all tastes. You will surely like it.',
                      textAlign: TextAlign.center,
                      style: AppStyle.regular20Whitetrans
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          OnboardingScreen.routeName,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: AppColors.yellowColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),),
                      child: Text(
                          'Explore Now',
                          style: AppStyle.bold20Black
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

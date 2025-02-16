import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:movies/ui/auth/login/login_screen.dart';
import 'package:movies/ui/home_screen.dart';

import '../theme/app_colors.dart';
import '../theme/app_image.dart';
import '../theme/app_style.dart';



class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'onboarding';

  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": AppImage.onBoarding2,
      "title": "Discover Movies",
      "description":
      "Explore a vast collection of movies in all qualities and genres."
          " Find your next favorite film with ease."
      ,
    },
    {
      "image":AppImage.onBoarding3 ,
      "title": "Explore All Genres",
      "description":
      "Discover movies from every genre, in all available qualities."
          " Find something new and exciting to watch every day"
      ,
    },
    {
      "image": AppImage.onBoarding4,
      "title": "Create Watchlist",
      "description":
      "Save movies to your watchlist to keep track of what you want to watch next. "
          "enjoy films in various qualities and genres. "
      ,
    },
    {
      "image": AppImage.onBoarding5,
      "title": "Rate, Review, and Learn",
      "description":
      "Share your thoughts on the movies you’ve watched. Dive deep into film details and help others discover great movies with your reviews.",
    },
    {
      "image": AppImage.onBoarding6,
      "title": "Start Watching Now",
      "description":""

    },
  ];

  void _nextPage() {
    if (_currentIndex < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingData.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  onboardingData[index]["image"]!,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent, // Transparent at the top
                        Colors.black.withOpacity(0.7), // Darker at the bottom
                      ],
                      stops: [0.5, 1.0], // Adjust stops for the gradient effect
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding:  EdgeInsets.all(height*.02),
                  decoration: BoxDecoration(
                    color: AppColors.blackColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        onboardingData[index]["title"]!,
                        textAlign: TextAlign.center,
                        style:AppStyle.bold20White,

                      ),
                      SizedBox(height: height*.01),
                      Text(
                        onboardingData[index]["description"]!,
                        textAlign: TextAlign.center,
                        style: AppStyle.regular20White,
                      ),
                      SizedBox(height: height*.01),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _currentIndex == onboardingData.length - 1
                                  ? () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  LoginScreen.routeName,
                                );
                              }
                                  : _nextPage,
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  backgroundColor: AppColors.yellowColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  )),
                              child: Text(
                                _currentIndex == onboardingData.length - 1 ? "Finish" : "Next",style: AppStyle.semi20Black,),
                            ),
                          ),
                          if (_currentIndex > 0) SizedBox(height: 10),

                          if (_currentIndex > 0)
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: _previousPage,
                                style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 20),

                                    foregroundColor:AppColors.yellowColor,
                                    side: BorderSide(color:AppColors.yellowColor),
                                    shape:  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    )
                                ),
                                child: Text("Back",style: AppStyle.semi20Yellow,),
                              ),
                            ),
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

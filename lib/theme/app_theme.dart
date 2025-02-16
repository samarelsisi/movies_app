import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemes{


  static final ThemeData lightTheme=ThemeData(
      primaryColor: AppColors.blackColor,
      primaryColorLight:AppColors.whiteColor ,
      scaffoldBackgroundColor: AppColors.whiteColor,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.blackColor,
          iconTheme: IconThemeData(
              color: AppColors.yellowColor
          )
      )

  );
  static final ThemeData darkTheme=ThemeData(
      primaryColor: AppColors.whiteColor,
      primaryColorLight:AppColors.blackColor ,

      scaffoldBackgroundColor: AppColors.blackColor,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.blackColor
      ),
      iconTheme: IconThemeData(
          color: AppColors.whiteColor
      )
  );
}
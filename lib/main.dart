import 'package:flutter/material.dart';
import 'package:movies/theme/app_theme.dart';
import 'package:movies/ui/auth/forgot_password/forgot_password_screen.dart';
import 'package:movies/ui/auth/login/login_screen.dart';
import 'package:movies/ui/auth/register/regist_screen.dart';
import 'package:movies/ui/home_screen.dart';
import 'package:movies/ui/intro_screen.dart';
import 'package:movies/ui/models/MoviesDataResponse.dart';
import 'package:movies/ui/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
      routes: {
        IntroScreen.routeName: (context) => IntroScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        LoginScreen.routeName:(context)=>LoginScreen(),
        RegisterScreen.routeName:(context)=>RegisterScreen(),
        ForgotPasswordScreen.routeName:(context)=>ForgotPasswordScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),

      },
      initialRoute: IntroScreen.routeName,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.light,
    );

  }
}



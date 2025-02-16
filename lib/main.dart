import 'package:flutter/material.dart';
import 'package:movies/ui/home_screen.dart';
import 'package:movies/ui/intro_screen.dart';
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
        // LoginScreen.routeName:(context)=>LoginScreen(),
        // RegisterScreen.routeName:(context)=>RegisterScreen(),
        // ForgotPasswordScreen.routeName:(context)=>ForgotPasswordScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),

      },
      initialRoute: IntroScreen.routeName,
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/boc_observer/myboc_observer.dart';
import 'package:movies/theme/app_theme.dart';
import 'package:movies/ui/auth/forgot_password/forgot_password_screen.dart';
import 'package:movies/ui/auth/login/login_screen.dart';
import 'package:movies/ui/auth/register/regist_screen.dart';
import 'package:movies/ui/data/%20repository/auth_repository.dart';
import 'package:movies/ui/data/logic/bloc/auth_bloc.dart';
import 'package:movies/ui/data/services/auth_service.dart';
import 'package:movies/ui/home_screen.dart';
import 'package:movies/ui/intro_screen.dart';
import 'package:movies/ui/onboarding_screen.dart';
import 'package:movies/ui/tabs/profile_tab/edit_profile_screen.dart';
import 'package:movies/ui/tabs/profile_tab/reset_password.dart';

void main() {
  final authService = AuthService(); // Initialize AuthService

  final authRepository = AuthRepository(authService: authService);
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({Key? key, required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: authRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          IntroScreen.routeName: (context) => IntroScreen(),
          OnboardingScreen.routeName: (context) => OnboardingScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          EditProfileScreen.routeName: (context) => EditProfileScreen(),
          ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),

        },
        initialRoute: HomeScreen.routeName,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}

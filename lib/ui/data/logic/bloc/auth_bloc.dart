import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    // Handling login event
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final String message = await authRepository.loginUser(event.email, event.password);

        emit(AuthSuccess(message: message));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });


    // Handling registration event
    on<RegisterUser>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.register(
          name: event.name,
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword,
          phone: event.phone,
          avaterId: event.avaterId,
        );
        emit(AuthSuccess(message: "Registration successful!"));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // Handling update profile event
    on<UpdateProfile>((event, emit) async {
      emit(ProfileUpdateLoading());
      try {
        final Map<String, dynamic> response = await authRepository.updateProfile(
          email: event.email,
          name: event.name,
          phone: event.phone,
          avaterId: event.avaterId,
        );

        final String message = response["message"];


        emit(ProfileUpdateSuccess(message: message));

        // Fetch updated user data after profile update
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? token = prefs.getString("auth_token");
        if (token != null) {
          add(AuthCheck(token)); // Now passing token correctly
        }
      } catch (e) {
        emit(ProfileUpdateFailure(e.toString()));
      }
    });

    // Handling user authentication check
    on<AuthCheck>((event, emit) async {
      emit(AuthLoading());
      try {
        final Map<String, dynamic> userData = await authRepository.fetchUserData(event.token);

        final String message = "User data fetched successfully.";


        emit(AuthSuccess(message: message));
      } catch (e) {
        emit(AuthFailure("Failed to fetch user data: ${e.toString()}"));
      }
    });
  }
}

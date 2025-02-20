import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;


  AuthSuccess({
    required this.message
  });

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ProfileUpdateLoading extends AuthState {}

class ProfileUpdateSuccess extends AuthState {
  final String message;


  ProfileUpdateSuccess({
    required this.message
  });

  @override
  List<Object?> get props => [message];
}

class ProfileUpdateFailure extends AuthState {
  final String error;
  ProfileUpdateFailure(this.error);

  @override
  List<Object?> get props => [error];
}

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterUser extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final int avaterId;

  RegisterUser({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.avaterId,
  });

  @override
  List<Object?> get props => [name, email, password, confirmPassword, phone, avaterId];
}

class UpdateProfile extends AuthEvent {
  final String? email;
  final String? name;
  final String? phone;
  final int? avaterId;

  UpdateProfile({this.email, this.name, this.phone, this.avaterId});

  @override
  List<Object?> get props => [email, name, phone, avaterId];
}

class AuthCheck extends AuthEvent {
  final String token;
  AuthCheck(this.token);

  @override
  List<Object?> get props => [token];
}

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

// NEW: UpdateProfile
class UpdateProfile extends ProfileEvent {
  final String name;
  final String phone;
  final int avatarId;

  const UpdateProfile({
    required this.name,
    required this.phone,
    required this.avatarId,
  });

  @override
  List<Object?> get props => [name, phone, avatarId];
}

// NEW: DeleteAccount
class DeleteAccount extends ProfileEvent {}

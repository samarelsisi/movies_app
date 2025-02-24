import 'package:equatable/equatable.dart';
import 'package:movies/ui/models/profile_data.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileData profileData;
  const ProfileLoaded(this.profileData);

  @override
  List<Object?> get props => [profileData];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

// NEW: Updating states
class ProfileUpdating extends ProfileState {}
class ProfileUpdated extends ProfileState {}

// NEW: Deleting states
class ProfileDeleting extends ProfileState {}
class ProfileDeleted extends ProfileState {}

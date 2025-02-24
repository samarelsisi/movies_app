import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ repository/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc(this.profileRepository) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<DeleteAccount>(_onDeleteAccount);
  }

  Future<void> _onLoadProfile(
      LoadProfile event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("auth_token");

      if (token == null) {
        emit(ProfileError("No token found, user might not be logged in."));
        return;
      }

      final profileData = await profileRepository.getProfile(token);
      emit(ProfileLoaded(profileData));
    } catch (e) {
      emit(ProfileError("Error fetching profile: $e"));
    }
  }

  Future<void> _onUpdateProfile(
      UpdateProfile event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileUpdating());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("auth_token");

      if (token == null) {
        emit(ProfileError("No token found, user might not be logged in."));
        return;
      }

      await profileRepository.updateProfile(
        token: token,
        name: event.name,
        phone: event.phone,
        avatarId: event.avatarId,
      );
      emit(ProfileUpdated());
    } catch (e) {
      emit(ProfileError("Error updating profile: $e"));
    }
  }

  Future<void> _onDeleteAccount(
      DeleteAccount event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileDeleting());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("auth_token");

      if (token == null) {
        emit(ProfileError("No token found, user might not be logged in."));
        return;
      }

      await profileRepository.deleteAccount(token);
      emit(ProfileDeleted());
    } catch (e) {
      emit(ProfileError("Error deleting account: $e"));
    }
  }
}

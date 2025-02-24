import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../ repository/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc(this.profileRepository) : super(const ProfileState()) {
    on<LoadProfile>(_onLoadProfile);
    on<LogoutProfile>(_onLogoutProfile);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    final userData = await profileRepository.getUserProfile();

    if (userData != null) {
      emit(state.copyWith(
        userName: userData['name'] ?? state.userName,
        userSelectedAvatarIndex: userData['avaterId'] ?? state.userSelectedAvatarIndex,
        isLoading: false,
      ));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onLogoutProfile(LogoutProfile event, Emitter<ProfileState> emit) async {
    await profileRepository.logout();
  }
}

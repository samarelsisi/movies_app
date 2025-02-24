import '../services/profile_service.dart';

class ProfileRepository {
  final ProfileService profileService;

  ProfileRepository(this.profileService);

  Future<Map<String, dynamic>?> getUserProfile() async {
    return await profileService.fetchUserProfile();
  }

  Future<void> logout() async {
    await profileService.logout();
  }
}

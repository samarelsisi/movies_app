import 'package:movies/ui/models/profile_data.dart';
import '../services/profile_service.dart';

class ProfileRepository {
  final ProfileService profileService;

  ProfileRepository(this.profileService);

  // Existing: fetch profile
  Future<ProfileData> getProfile(String token) async {
    return await profileService.fetchProfile(token);
  }

  // NEW: update profile
  Future<void> updateProfile({
    required String token,
    required String name,
    required String phone,
    required int avatarId,
  }) async {
    await profileService.updateProfile(
      token: token,
      name: name,
      phone: phone,
      avatarId: avatarId,
    );
  }

  // NEW: delete account
  Future<void> deleteAccount(String token) async {
    await profileService.deleteAccount(token);
  }
}

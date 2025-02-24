
class ProfileData {
  final String name;
  final int avatarId;

  ProfileData({
    required this.name,
    required this.avatarId,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      name: json['name'] ?? '',
      avatarId: json['avaterId'] ?? 0,
    );
  }
}

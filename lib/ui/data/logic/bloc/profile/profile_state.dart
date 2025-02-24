
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String userName;
  final int userSelectedAvatarIndex;
  final bool isLoading;

  const ProfileState({
    this.userName = "John Safwat",
    this.userSelectedAvatarIndex = 0,
    this.isLoading = true,
  });

  ProfileState copyWith({
    String? userName,
    int? userSelectedAvatarIndex,
    bool? isLoading,
  }) {
    return ProfileState(
      userName: userName ?? this.userName,
      userSelectedAvatarIndex: userSelectedAvatarIndex ?? this.userSelectedAvatarIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [userName, userSelectedAvatarIndex, isLoading];
}

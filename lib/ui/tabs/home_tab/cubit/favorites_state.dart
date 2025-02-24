import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final bool isInWatchList;
  final bool isInHistory;

  const FavoritesState({
    required this.isInWatchList,
    required this.isInHistory,
  });

  factory FavoritesState.initial() {
    return const FavoritesState(isInWatchList: false, isInHistory: false);
  }

  FavoritesState copyWith({
    bool? isInWatchList,
    bool? isInHistory,
  }) {
    return FavoritesState(
      isInWatchList: isInWatchList ?? this.isInWatchList,
      isInHistory: isInHistory ?? this.isInHistory,
    );
  }

  @override
  List<Object> get props => [isInWatchList, isInHistory];
}

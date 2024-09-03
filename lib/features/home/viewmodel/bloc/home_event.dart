part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeSyncCompleted extends HomeEvent {
  final String lastSyncTime;

  HomeSyncCompleted({required this.lastSyncTime});
}

part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeFetchUserData extends HomeState {
  final String name;
  final String empId;
  final List<Locations> loactions;
  final String lastSyncTime;

  HomeFetchUserData(
      {required this.name,
      required this.empId,
      required this.loactions,
      required this.lastSyncTime});
}

class HomeSyncTimeUpdated extends HomeState {
  final String lastSyncTime;

  HomeSyncTimeUpdated({required this.lastSyncTime});
}

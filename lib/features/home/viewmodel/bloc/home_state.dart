part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeFetchUserData extends HomeState {
  final String name;
  final String empId;
  final List<Locations> loactions;

  HomeFetchUserData(
      {required this.name, required this.empId, required this.loactions});
}

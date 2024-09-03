part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationPermissionGranted extends LocationState {}

final class LocationServiceChanged extends LocationState {
  final bool status;

  LocationServiceChanged({required this.status});
}

final class OnLocationChanged extends LocationState {
  final Position location;

  OnLocationChanged({required this.location});
}

part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}

class FetchLocationPermissionEvent extends LocationEvent {}

class FetchLocationServiceEvent extends LocationEvent {}

class OnLocationServiceChangedEvent extends LocationEvent {
  final bool status;

  OnLocationServiceChangedEvent({required this.status});
}

class FetchLocationEvent extends LocationEvent {}

class OnLocationChangedEvent extends LocationEvent {
  final Position location;

  OnLocationChangedEvent({required this.location});
}

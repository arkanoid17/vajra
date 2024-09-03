// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:vajra_test/cores/features/location/app_locations.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  late StreamSubscription<Position> locationStream;

  final BuildContext context;

  LocationBloc({
    required this.context,
  }) : super(LocationInitial()) {
    on<FetchLocationPermissionEvent>(_handleLocationPermission);
    on<FetchLocationServiceEvent>(_handleLocationService);
    on<OnLocationServiceChangedEvent>(_handleLocationServiceChanged);
    on<FetchLocationEvent>(_handleFetchingLocation);
    on<OnLocationChangedEvent>(_hanedleLocationChanged);
  }

  FutureOr<void> _handleLocationPermission(
      FetchLocationPermissionEvent event, Emitter<LocationState> emit) async {
    final granted = await AppLocations.checkLocationPermission();

    if (granted) {
      emit(LocationPermissionGranted());
    } else {
      AppLocations.showLocationPermissionDialog();
    }
  }

  FutureOr<void> _handleLocationService(
      FetchLocationServiceEvent event, Emitter<LocationState> emit) {
    AppLocations.checkLocationService();
  }

  FutureOr<void> _handleLocationServiceChanged(
      OnLocationServiceChangedEvent event, Emitter<LocationState> emit) {
    emit(LocationServiceChanged(status: event.status));
  }

  FutureOr<void> _handleFetchingLocation(
      FetchLocationEvent event, Emitter<LocationState> emit) {
    locationStream = Geolocator.getPositionStream(
            locationSettings: AppLocations.locationSettings)
        .listen(
      (location) => add(OnLocationChangedEvent(location: location)),
    );
  }

  @override
  Future<void> close() {
    locationStream.cancel();
    return super.close();
  }

  FutureOr<void> _hanedleLocationChanged(
      OnLocationChangedEvent event, Emitter<LocationState> emit) {
    emit(OnLocationChanged(location: event.location));
  }
}

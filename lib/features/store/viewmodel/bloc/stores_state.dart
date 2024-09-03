part of 'stores_bloc.dart';

sealed class StoresState {}

class StoreListState extends StoresState {}

final class StoresInitial extends StoresState {}

class BeatsFetchedState extends StoresState {
  final List<UserHierarchyBeats> beats;

  BeatsFetchedState({required this.beats});
}

class StoresLoadingState extends StoreListState {}

class StoresFetchedState extends StoreListState {
  final List<Store> stores;

  StoresFetchedState({required this.stores});
}

class OnLocationChangedState extends StoresState {
  final Position location;

  OnLocationChangedState({required this.location});
}
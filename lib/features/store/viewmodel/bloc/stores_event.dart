part of 'stores_bloc.dart';

sealed class StoresEvent {}

class FetchBeatsEvent extends StoresEvent {
  final int id;
  final String date;

  FetchBeatsEvent({required this.id, required this.date});
}

class FetchStoresEvent extends StoresEvent {
  final List<UserHierarchyBeats> selectedBeats;
  final int salesmanId;

  FetchStoresEvent({required this.selectedBeats, required this.salesmanId});
}

class OnFetchLocationEvent extends StoresEvent {}

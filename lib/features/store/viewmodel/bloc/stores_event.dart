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

class StoreFiltersChangedEvent extends StoresEvent {
  final int salesmanId;
  final String selectedDate;
  final List<UserHierarchyBeats> selectedBeats;

  StoreFiltersChangedEvent(
      {required this.salesmanId,
      required this.selectedDate,
      required this.selectedBeats});
}

//from store filters after new salesman is selected
class FetchUpdatedSalesmanStores extends StoresEvent {
  final int salesmanId;

  FetchUpdatedSalesmanStores({required this.salesmanId});
}

class AddStoresToDbEvent extends StoresEvent {
  final int salesmanId;
  final List<Store> stores;

  AddStoresToDbEvent({required this.salesmanId, required this.stores});
}

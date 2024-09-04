import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vajra_test/cores/features/location/bloc/location_bloc.dart';
import 'package:vajra_test/features/store/model/models/store.dart';
import 'package:vajra_test/features/store/model/repository/stores_local_repository.dart';
import 'package:vajra_test/features/store/model/repository/stores_remote_repository.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_beats.dart';
import 'package:vajra_test/features/sync/model/repositories/userhierarchy/user_hierarchy_local_repository.dart';

part 'stores_event.dart';
part 'stores_state.dart';

class StoresBloc extends Bloc<StoresEvent, StoresState> {
  final LocationBloc locationBloc;
  late StreamSubscription locationStream;
  final storesRemoteRepo = StoresRemoteRepository();
  final storesLocalRepo = StoresLocalRepository();

  StoresBloc({required this.locationBloc}) : super(StoresInitial()) {
    locationStream = locationBloc.stream.listen((state) {
      if (state is OnLocationChanged) {
        _handleLocationChanges(state.location);
      }
    });

    on<FetchBeatsEvent>(_handleFetchBeats);
    on<FetchStoresEvent>(_handleFetchStores);
    on<StoreFiltersChangedEvent>(_handleFiltersChange);
    on<FetchUpdatedSalesmanStores>(_handleUpdatedStoresFetch);
    on<AddStoresToDbEvent>(_saveStoresToDb);
  }

  FutureOr<void> _handleFetchBeats(
      FetchBeatsEvent event, Emitter<StoresState> emit) {
    List<UserHierarchyBeats> beats = UserHierarchyLocalRepository()
        .filterBeatsByDateAndUser(event.date, event.id);
    emit(BeatsFetchedState(beats: beats));
  }

  FutureOr<void> _handleFetchStores(
      FetchStoresEvent event, Emitter<StoresState> emit) async {
    emit(StoresLoadingState());
    final stores = await storesLocalRepo.fetchAllStoresBySalesmanAndBeats(
      event.salesmanId,
      event.selectedBeats,
    );
    emit(StoresFetchedState(stores: stores));
  }

  FutureOr<void> _handleLocationChanges(Position location) {
    emit(OnLocationChangedState(location: location));
  }

  @override
  Future<void> close() {
    locationStream.cancel();
    return super.close();
  }

  FutureOr<void> _handleFiltersChange(
      StoreFiltersChangedEvent event, Emitter<StoresState> emit) {
    emit(
      StoresFilterChangedState(
        salesmanId: event.salesmanId,
        selectedDate: event.selectedDate,
        selectedBeats: event.selectedBeats,
      ),
    );
  }

  FutureOr<void> _handleUpdatedStoresFetch(
      FetchUpdatedSalesmanStores event, Emitter<StoresState> emit) async {
    emit(UpdatedSalesmanStoresFetchLoader());

    var stores = await storesLocalRepo.getAllStoresBySalesman(event.salesmanId);
    if (stores.isNotEmpty) {
      emit(UpdatedSalesmanStoresFetchSuccess());
    } else {
      final res = await storesRemoteRepo.getStores(event.salesmanId);
      res.fold(
        (e) => emit(UpdatedSalesmanStoresFetchError()),
        (storeResp) => add(
          AddStoresToDbEvent(
            salesmanId: event.salesmanId,
            stores: storeResp.data ?? [],
          ),
        ),
      );
    }
  }

  FutureOr<void> _saveStoresToDb(
      AddStoresToDbEvent event, Emitter<StoresState> emit) async {
    bool isInserted =
        await storesLocalRepo.adAllStores(event.salesmanId, event.stores);
    if (isInserted) {
      emit(UpdatedSalesmanStoresFetchSuccess());
    } else {
      emit(UpdatedSalesmanStoresFetchError());
    }
  }
}

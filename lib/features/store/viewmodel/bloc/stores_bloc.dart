import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vajra_test/cores/features/location/bloc/location_bloc.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/cores/utils/date_utils.dart' as dateUtils;
import 'package:vajra_test/features/store/model/models/store.dart';
import 'package:vajra_test/features/store/model/repository/stores_local_repository.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_beats.dart';
import 'package:vajra_test/features/sync/model/repositories/userhierarchy/user_hierarchy_local_repository.dart';
import 'package:vajra_test/main.dart';

part 'stores_event.dart';
part 'stores_state.dart';

class StoresBloc extends Bloc<StoresEvent, StoresState> {
  final LocationBloc locationBloc;
  late StreamSubscription locationStream;

  StoresBloc({required this.locationBloc}) : super(StoresInitial()) {
    locationStream = locationBloc.stream.listen((state) {
      if (state is OnLocationChanged) {
        _handleLocationChanges(state.location);
      }
    });

    on<FetchBeatsEvent>(_handleFetchBeats);
    on<FetchStoresEvent>(_handleFetchStores);
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
    final repo = StoresLocalRepository();
    final stores = await repo.fetchAllStoresBySalesmanAndBeats(
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
}

import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:vajra_test/features/store/model/models/store.dart';
import 'package:vajra_test/features/store/model/models/store_beats.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_beats.dart';
import 'package:vajra_test/init_dependencies.dart';

class StoresLocalRepository {
  Box<Store> box = serviceLocator();

  Future<bool> adAllStores(int salesmanId, List<Store> stores) async {
    Map<String, Store> map = {};

    box.clear();

    Position? location = await Geolocator.getLastKnownPosition();

    for (int i = 0; i < stores.length; i++) {
      if (location != null) {
        stores[i].distance = Geolocator.distanceBetween(
          location.latitude,
          location.longitude,
          double.parse(stores[i].storeLatitude ?? '0.0'),
          double.parse(stores[i].storeLongitude ?? '0.0'),
        );
      }

      stores[i].salesmanId = salesmanId;
      map[i.toString()] = stores[i];
    }

    await box.putAll(map);

    return true;
  }

  void updateStoreDistances(Position location, List<Store> stores) async {
    final val = await box.clear();

    Map<String, Store> map = {};

    for (int i = 0; i < stores.length; i++) {
      stores[i].distance = Geolocator.distanceBetween(
        location.latitude,
        location.longitude,
        double.parse(stores[i].storeLatitude ?? '0.0'),
        double.parse(stores[i].storeLongitude ?? '0.0'),
      );

      map[i.toString()] = stores[i];
    }

    box.putAll(map);
  }

  Future<List<Store>> getAllStoresBySalesman(int salesmanId) async {
    List<Store> stores = [];
    for (int i = 0; i < box.length; i++) {
      stores.add(box.get(i.toString())!);
    }

    return stores;
  }

  Future<List<Store>> fetchAllStoresBySalesmanAndBeats(
    int salesmanId,
    List<UserHierarchyBeats> beats,
  ) async {
    List<Store> stores = [];

    List<int> allBeatIds = beats.map((e) => e.id!).toList();
    List<Store> allStores = await getAllStoresBySalesman(salesmanId);

    stores = allStores
        .where((store) => _filterStoreBeat(allBeatIds, store.beats!))
        .toList();

    return stores;
  }

  _filterStoreBeat(List<int> allBeatIds, List<StoreBeats> beats) {
    return beats
        .where((beat) => allBeatIds.contains(beat.id))
        .toList()
        .isNotEmpty;
  }
}

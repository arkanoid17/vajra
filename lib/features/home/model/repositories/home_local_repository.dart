import 'package:hive/hive.dart';
import 'package:vajra_test/cores/model/user/locations.dart';
import 'package:vajra_test/init_dependencies.dart';

class HomeLocalRepository {
  Box box = serviceLocator();

  Box<Locations> locationBox = serviceLocator();

  String getUserName() {
    return box.get('name');
  }

  String getEmpId() {
    return box.get('user_id');
  }

  List<Locations> getPlaces() {
    return locationBox.values.toList();
  }

  String getLastSyncTime() {
    return box.get('last_sync_time') ?? '';
  }
}

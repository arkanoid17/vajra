import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vajra_test/cores/model/user/locations.dart';
import 'package:vajra_test/features/sync/model/repositories/userdata/user_data_local_repository.dart';
import 'package:vajra_test/features/sync/model/repositories/userdata/user_data_remote_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  var path = (await getApplicationDocumentsDirectory()).path;

  Hive
    ..init(path)
    ..registerAdapter(PlacesAdapter());

  Box box = await Hive.openBox('vajra');
  Box<Locations> locationBox = await Hive.openBox('locations');

  serviceLocator.registerLazySingleton<Box>(() => box);
  serviceLocator.registerLazySingleton<Box<Locations>>(() => locationBox);

  _initSync();
}

void _initSync() {
  serviceLocator.registerFactory<UserDataRemoteRepository>(
    () => UserDataRemoteRepository(),
  );
  serviceLocator.registerFactory<UserDataLocalRepository>(
    () => UserDataLocalRepository(),
  );
}

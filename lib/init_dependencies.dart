import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vajra_test/cores/model/user/locations.dart';
import 'package:vajra_test/features/store/model/models/stores_meta_data.dart';
import 'package:vajra_test/features/sync/model/models/products/brand.dart';
import 'package:vajra_test/features/sync/model/models/products/packs.dart';
import 'package:vajra_test/features/sync/model/models/products/product_distributor_types.dart';
import 'package:vajra_test/features/sync/model/models/products/products.dart';
import 'package:vajra_test/features/sync/model/models/schemes/scheme_product_details.dart';
import 'package:vajra_test/features/sync/model/models/schemes/scheme_products.dart';
import 'package:vajra_test/features/sync/model/models/schemes/scheme_type.dart';
import 'package:vajra_test/features/sync/model/models/schemes/schemes.dart';
import 'package:vajra_test/features/store/model/models/store_beats.dart';
import 'package:vajra_test/features/store/model/models/store_colours.dart';
import 'package:vajra_test/features/store/model/models/store_distributor_relation.dart';
import 'package:vajra_test/features/store/model/models/store_pricings.dart';
import 'package:vajra_test/features/store/model/models/store_schemes.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_beats.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_beats_calendar.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_distributor_types.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_locations.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_salesman_distributors.dart';
import 'package:vajra_test/features/sync/model/repositories/userdata/user_data_local_repository.dart';
import 'package:vajra_test/features/sync/model/repositories/userdata/user_data_remote_repository.dart';
import 'package:vajra_test/features/store/model/models/store.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  var path = (await getApplicationDocumentsDirectory()).path;

  Hive
    ..init(path)
    //places
    ..registerAdapter(PlacesAdapter())

    //hierarchy
    ..registerAdapter(UserHierarchyAdapter())
    ..registerAdapter(UserHierarchyBeatCalendarAdapter())
    ..registerAdapter(UserHierarchyBeatsAdapter())
    ..registerAdapter(UserHierarchySalesmanDistributorsAdapter())
    ..registerAdapter(UserHierarchyLocationsAdapter())
    ..registerAdapter(UserHierarchyDistributorTypesAdapter())

    //products
    ..registerAdapter(ProductsAdapter())
    ..registerAdapter(PacksAdpater())
    ..registerAdapter(BrandAdapter())
    ..registerAdapter(ProductDistributorTypesAdapter())

    //schemes
    ..registerAdapter(SchemesAdapter())
    ..registerAdapter(SchemeProductDetailsAdapter())
    ..registerAdapter(SchemeProductsAdapter())
    ..registerAdapter(SchemeTypeAdapter())

    //store
    ..registerAdapter(StoreAdapter())
    ..registerAdapter(StoreSchemesAdapter())
    ..registerAdapter(StorePricingsAdapter())
    ..registerAdapter(StoreColoursAdapter())
    ..registerAdapter(StoreDistributorRelationAdapter())
    ..registerAdapter(StoreBeatsAdapter())
    ..registerAdapter(StoreMetaDataAdapter());

  Box box = await Hive.openBox('vajra');
  Box<Locations> locationBox = await Hive.openBox('locations');
  Box<UserHierarchy> userHierarchyBox = await Hive.openBox('user_hierarchy');
  Box<Products> productsBox = await Hive.openBox('products');
  Box<Schemes> schemesBox = await Hive.openBox('schemes');
  Box<Store> storeBox = await Hive.openBox('stores');

  serviceLocator.registerLazySingleton<Box>(() => box);
  serviceLocator.registerLazySingleton<Box<Locations>>(() => locationBox);
  serviceLocator
      .registerLazySingleton<Box<UserHierarchy>>(() => userHierarchyBox);
  serviceLocator.registerLazySingleton<Box<Products>>(() => productsBox);
  serviceLocator.registerLazySingleton<Box<Schemes>>(() => schemesBox);
  serviceLocator.registerLazySingleton<Box<Store>>(() => storeBox);

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

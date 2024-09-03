import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/features/sync/model/models/products/products.dart';
import 'package:vajra_test/features/sync/model/models/schemes/schemes.dart';
import 'package:vajra_test/features/store/model/models/store.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy.dart';
import 'package:vajra_test/features/sync/model/repositories/products/products_local_repository.dart';
import 'package:vajra_test/features/sync/model/repositories/products/products_remote_repository.dart';
import 'package:vajra_test/features/sync/model/repositories/schemes/schemes_local_repository.dart';
import 'package:vajra_test/features/sync/model/repositories/schemes/schemes_remote_repository.dart';
import 'package:vajra_test/features/store/model/repository/stores_local_repository.dart';
import 'package:vajra_test/features/store/model/repository/stores_remote_repository.dart';
import 'package:vajra_test/features/sync/model/repositories/userdata/user_data_local_repository.dart';
import 'package:vajra_test/features/sync/model/repositories/userdata/user_data_remote_repository.dart';
import 'package:vajra_test/features/sync/model/repositories/userhierarchy/user_hierarchy_local_repository.dart';
import 'package:vajra_test/features/sync/model/repositories/userhierarchy/user_hierarchy_remote_repository.dart';

part 'sync_event.dart';
part 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  SyncBloc() : super(SyncInitial()) {
    on<SyncStartEvent>(_handleSync);
  }

  FutureOr<void> _handleSync(
      SyncStartEvent event, Emitter<SyncState> emit) async {
    if (event.isForced || isSyncTime()) {
      AppUtils.isSyncing = true;

      emit(SyncLoadingState());

      bool userData = await handleUserData();
      bool userHierarchy = await handleUserHierarchy();

      if (userHierarchy && userData) {
        AppUtils.isSyncing = false;
        saveLastSyncTime();
        emit(SyncSuccessState());
      } else {
        emit(SyncErrorState());
      }
    } else {
      emit(NoSyncState());
    }
  }

  Future<bool> handleUserData() async {
    final userDataRemoteRepository = UserDataRemoteRepository();
    final res = await userDataRemoteRepository.getUserData();
    return res.fold((e) => false, (user) {
      final userDataLocalRepository = UserDataLocalRepository();
      userDataLocalRepository.addUser(user);
      return true;
    });
  }

  Future<bool> handleUserHierarchy() async {
    final userHierarchyRemoteRepository = UserHierarchyRemoteRepository();
    final res = await userHierarchyRemoteRepository.getUserHierarchy(false);

    bool hierarchyData = await res.fold((e) => false, (users) async {
      final userHierarchyLocalRepository = UserHierarchyLocalRepository();
      userHierarchyLocalRepository.addAllUsers(users);
      bool salesmanData = false;
      for (UserHierarchy user in users) {
        if (user.id == getSalesmanId() && isSalesman()) {
          salesmanData = await fetchSalesmanData(user.id);
        }
      }
      return salesmanData;
    });

    return hierarchyData;
  }

  Future<bool> fetchSalesmanData(int? id) async {
    bool products = await getProducts(id);
    bool schemes = await getSchemes(id);
    bool stores = await getStores(id);

    return products && schemes && stores;
  }

  Future<bool> getProducts(int? id) async {
    final productsRemoteRepo = ProductsRemoteRepository();
    final res = await productsRemoteRepo.getProducts(id!);
    res.fold((e) => print(e), (productResp) {
      if (productResp.data != null && productResp.data!.isNotEmpty) {
        saveProductsToLocal(productResp.data!, id);
      }
    });

    return true;
  }

  void saveProductsToLocal(List<Products> products, int salesmanId) {
    ProductsLocalRepository repo = ProductsLocalRepository();
    repo.addProducts(products, salesmanId);
  }

  Future<bool> getSchemes(int? id) async {
    final schemesRemoteRepo = SchemesRemoteRepository();
    final res = await schemesRemoteRepo.getAllSchemes(false);
    res.fold((e) => print(e), (schemes) {
      if (schemes.isNotEmpty) {
        saveSchemesToLocal(schemes, id);
      }
    });

    return true;
  }

  void saveSchemesToLocal(List<Schemes> schemes, int? salesmanId) {
    SchemesLocalRepository repo = SchemesLocalRepository();
    repo.addAllSchemes(schemes, salesmanId!);
  }

  Future<bool> getStores(int? id) async {
    final res = await StoresRemoteRepository().getStores(id!);
    res.fold((e) => print(e), (storeResp) {
      if (storeResp.data != null && storeResp.data!.isNotEmpty) {
        saveStoresDataToLocal(storeResp.data!, id);
      }
    });

    return true;
  }

  void saveStoresDataToLocal(List<Store> stores, int? salesmanId) {
    final repo = StoresLocalRepository();
    repo.adAllStores(salesmanId!, stores);
  }
}

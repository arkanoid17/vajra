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
    SyncStartEvent event,
    Emitter<SyncState> emit,
  ) async {
    if (event.isForced || isSyncTime()) {
      AppUtils.isSyncing = true;

      emit(SyncLoadingState());

      final val = await Future.wait([handleUserData(), handleUserHierarchy()]);

      bool success = val.every((element) => element);

      if (success) {
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
    final success =
        await Future.wait([getStores(id), getProducts(id), getSchemes(id)]);
    return success.every((e) => e);
  }

  Future<bool> getProducts(int? id) async {
    final productsRemoteRepo = ProductsRemoteRepository();
    final res = await productsRemoteRepo.getProducts(id!);
    return await res.fold((e) => false, (productResp) async {
      if (productResp.data != null && productResp.data!.isNotEmpty) {
        bool isInserted = await saveProductsToLocal(productResp.data!, id);
        return isInserted;
      } else {
        return false;
      }
    });
  }

  Future<bool> saveProductsToLocal(
      List<Products> products, int salesmanId) async {
    ProductsLocalRepository repo = ProductsLocalRepository();
    bool isInserted = await repo.addProducts(products, salesmanId);
    return isInserted;
  }

  Future<bool> getSchemes(int? id) async {
    final schemesRemoteRepo = SchemesRemoteRepository();
    final res = await schemesRemoteRepo.getAllSchemes(false);
    return await res.fold((e) => false, (schemes) async {
      if (schemes.isNotEmpty) {
        bool isInserted = await saveSchemesToLocal(schemes, id);
        return isInserted;
      } else {
        return false;
      }
    });
  }

  Future<bool> saveSchemesToLocal(
      List<Schemes> schemes, int? salesmanId) async {
    SchemesLocalRepository repo = SchemesLocalRepository();
    bool isInserted = await repo.addAllSchemes(schemes, salesmanId!);
    return isInserted;
  }

  Future<bool> getStores(int? id) async {
    final res = await StoresRemoteRepository().getStores(id!);
    return await res.fold((e) => false, (storeResp) async {
      if (storeResp.data != null && storeResp.data!.isNotEmpty) {
        bool isInserted = await saveStoresDataToLocal(storeResp.data!, id);
        return isInserted;
      } else {
        return false;
      }
    });
  }

  Future<bool> saveStoresDataToLocal(
      List<Store> stores, int? salesmanId) async {
    final repo = StoresLocalRepository();
    final isInserted = await repo.adAllStores(salesmanId!, stores);
    return isInserted;
  }
}

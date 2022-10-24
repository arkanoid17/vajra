import 'dart:convert';
import 'dart:io';

import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vajra/db/activity_data_detail/activity_data_detail.dart';
import 'package:vajra/db/channel_data_detail/channel_data_detail.dart';
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/form_actions_data_detail/form_action_data_details.dart';
import 'package:vajra/db/pending_task_data_detail/pending_task_data_detail.dart';
import 'package:vajra/db/places_data_detail/places_data_detail.dart';
import 'package:vajra/db/pricing_data_detail/pricing_data_detail.dart';
import 'package:vajra/db/product_data_detail/product_data_detail.dart';
import 'package:vajra/db/reasons_data_detail/reasons_data_detail.dart';
import 'package:vajra/db/schemes_data_detail/schemes_data_detail.dart';
import 'package:vajra/db/store_beat_mapping_data_detail/store_beat_mapping_data_detail.dart';
import 'package:vajra/db/store_color_data_detail/store_color_data_detail.dart';
import 'package:vajra/db/store_price_mapping_data_detail/store_price_mapping_data_detail.dart';
import 'package:vajra/db/store_types_data_detail/store_types_data_detail.dart';
import 'package:vajra/db/stores_data_detail/stores_data_detail.dart';
import 'package:vajra/db/user_hierarchy_data_detail/user_hierarchy_data_detail.dart';
import 'package:vajra/db/user_stats_data_detail/user_stats_data_detail.dart';
import 'package:vajra/models/activity_data/activity_data.dart';
import 'package:vajra/models/channel_data/channel_response.dart';
import 'package:vajra/models/common_schemes/common_schemes.dart';
import 'package:vajra/models/form_actions/form_actions_data.dart';
import 'package:vajra/models/pending_tasks_data/form.dart';
import 'package:vajra/models/pending_tasks_data/pending_task.dart';
import 'package:vajra/models/pending_tasks_data/pending_task_response.dart';
import 'package:vajra/models/place_data/places.dart';
import 'package:vajra/models/pricing_data/pricing_response.dart';
import 'package:vajra/models/pricing_data/product_pricing_obj.dart';
import 'package:vajra/models/product/product_response.dart';
import 'package:vajra/models/reasons_data/reasons.dart';
import 'package:vajra/models/reasons_data/reasons_response.dart';
import 'package:vajra/models/store_types_data/store_types_data.dart';
import 'package:vajra/models/store_types_data/store_types_response.dart';
import 'package:vajra/models/stores_data/colours.dart';
import 'package:vajra/models/stores_data/pricing.dart';
import 'package:vajra/models/stores_data/store_beat.dart';
import 'package:vajra/models/stores_data/store_data.dart';
import 'package:vajra/models/stores_data/store_response.dart';
import 'package:vajra/models/user_data/user_data.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy.dart';
import 'package:vajra/models/user_stats_data/user_stats_data.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/services/APIServices.dart';
import 'package:vajra/utils/app_utils.dart';
import 'package:vajra/utils/network_connectivity.dart';

import '../models/channel_data/channel_obj.dart';
import '../models/place_data/place_response.dart';
import '../models/place_data/places.dart';


class SyncHandler {

  BuildContext context;
  SharedPreferences prefs;
  DatabaseHelper instance;

  SyncHandler(this.context, this.prefs, this.instance);

  // bool isConnected = false;
  Map<String,String> headers = {};

  Map<String,bool> servicesToBeCalled = {};
  Map<String,bool> servicesFinished = {};

  List<String> serviceNames = [
    'userHierarchy',
    'userData',
    'channelsService',
    'placeService',
    'taskService',
    'userStatsService',
    'storeTypeService',
    'dynamicUserActions',
    'dynamicUserActionList',
    'reasonService',
    'storesService'
  ];


  void startSync() {

    fetchHeaders();

    if (!AppUtils.isSyncGoingOn){
      sendBroadcastToDashboard("Start");
      checkServerData();
    }
  }

  void fetchHeaders(){
    headers = AppUtils.headers(
        prefs.getString('tenant_id')!=null?prefs.getString('tenant_id')!:'',
        prefs.getString('token')!=null?prefs.getString('token')!:''
    );
  }

  void checkServerData() {
    bool isPull = true;

    bool isTime = getIsTime();

    if (prefs.containsKey('if_pull')) {
      isPull = prefs.getBool('if_pull')!;
    }

    if (isPull) {
      isTime = true;
    }


    if (isTime && isPull) {
      AppUtils.isSyncGoingOn = true;
      loadServerData();
    } else {
      AppUtils.isSyncGoingOn = false;
    }
  }

  bool getIsTime() {
    var formatter = DateFormat('dd/MM/yyyy hh:mm a');

    if(prefs.containsKey(AppStrings.fetchTime)){
      String syncTime = prefs.getString(AppStrings.fetchTime) != null
          ? prefs.getString(AppStrings.fetchTime)!
          : '';
      var dateNow = DateTime.now();

      if(syncTime.isNotEmpty) {
        var dateSync = formatter.parse(syncTime);
        return dateNow.difference(dateSync).inHours >= AppUtils.syncInterval;
      }

    }
    return true;
  }

  void getServiceCounts(){


    serviceNames.forEach((element) {
      servicesToBeCalled.putIfAbsent(element, () => false);
    });


  }

  void loadServerData() {
      getServiceCounts();
      fetchUserData();
  }

  Future<void> fetchUserData() async {
    var userHierarchy = await AppUtils.requestBuilder(
        AppUtils.baseUrl + APIServices.userHierarchy, headers);
    try {
      if (userHierarchy.statusCode == 200) {
        handleHierarchyResponse(userHierarchy.body);
        servicesFinished.putIfAbsent('userHierarchy', () => true);
        handleSyncCompletion();
        var userData = await AppUtils.requestBuilder(
            AppUtils.baseUrl + APIServices.userData, headers);
        try {
          if (userData.statusCode == 200) {
            handleUserDataResponse(userData.body);
            servicesFinished.putIfAbsent('userData', () => true);
            handleSyncCompletion();
            if (AppUtils.getUserData(prefs)!=null) {
              callOtherServices();
            } else {
              AppUtils.isSyncGoingOn = false;
              sendBroadcastToDashboard(AppStrings.key_initiali_fail);
            }

          } else {
            servicesFinished.putIfAbsent('userData', () => false);
            handleSyncCompletion();
            sendBroadcastToDashboard(AppStrings.key_initiali_fail);
          }
        } catch (e) {
          servicesFinished.putIfAbsent('userData', () => false);
          handleSyncCompletion();
          sendBroadcastToDashboard(AppStrings.key_initiali_fail);
        }
      } else {
        servicesFinished.putIfAbsent('userHierarchy', () => false);
        handleSyncCompletion();
        sendBroadcastToDashboard(AppStrings.key_initiali_fail);
      }
    } catch (e) {
      servicesFinished.putIfAbsent('userHierarchy', () => false);
      handleSyncCompletion();
      sendBroadcastToDashboard(AppStrings.key_initiali_fail);
    }
  }

  void handleHierarchyResponse(String body) {

    List<dynamic> parsedListJson = jsonDecode(body);
    List<UserHierarchy> itemsList = List<UserHierarchy>.from(parsedListJson.map<UserHierarchy>((dynamic i) => UserHierarchy.fromJson(i)));

    if(itemsList.isNotEmpty){

      instance.deleteAllData(instance.tableUserHierarchyDataDetail);

      for (var element in itemsList) {
        UserHierarchyDataDetail detail = UserHierarchyDataDetail(
            element.id,
            element.employName,
            element.employId,
            jsonEncode(element.locations?.map((e) => e.toJson()).toList()),
            jsonEncode(element.salesmanDistributors?.map((e) => e.toJson()).toList()),
            jsonEncode(element.beats?.map((e) => e.toJson()).toList()),
            element.lastLogin,
            element.tenantId,
            element.userId,
            element.name,
            element.mobileNumber,
            element.email,
            element.isExternal,
            element.isActive,
            element.dateJoined,
            element.fcmToken,
            element.createdAt,
            element.updatedAt,
            element.isSalesman,
            element.isGeoRestricted,
            element.place,
            element.role,
            element.manager,
            element.createdBy,
            element.updatedBy
        );

        Map<String,dynamic> mapHierarchy = detail.toJson();

        instance.insert(instance.tableUserHierarchyDataDetail, mapHierarchy);
        
        if(element.employId==prefs.getString("user_id")){
          if(element.isSalesman!){
            // getProducts(element.id!);
            // getDiscounts(element.id);
          }else{
            //clear products, discounts
            instance.deleteAllData(instance.productDataDetail);
            instance.deleteAllData(instance.schemesDataDetail);

          }
        }
        
      }
    }

  }

  void getProducts(int id) async{
    String url = '${AppUtils.baseUrl}${APIServices.products}?salesman_id=$id';
    var products = await AppUtils.requestBuilder(url, headers);
    try {
      if (products.statusCode == 200) {
        handleProductResponse(products.body,id);
      }
    } catch (e) {
        AppUtils.showMessage( e.toString());
    }
  }

  void handleProductResponse(String body,int id){
   if(body.isNotEmpty){
     ProductResponse productResponse = ProductResponse.fromJson(jsonDecode(body));
     if(productResponse.data != null){
       instance.deleteAllData(instance.productDataDetail);
       ProductDataDetail product;
        productResponse.data?.map((prd) => {
          product = ProductDataDetail(
              prd.productName,
              prd.productId,
              prd.barcodeNumber,
              prd.hsnNumber,
              prd.description,
              prd.manufacturer,
              prd.productCategory,
              prd.scope,
              prd.mrp,
              prd.nrv,
              prd.ptr,
              prd.taxType,
              prd.isQps,
              prd.discountValue,
              prd.productStatus,
              prd.quantityLimit,
              prd.taxValue,
              prd.pts,
              prd.netPrice,
              prd.isFeatureProduct,
              jsonEncode(prd.packs?.map((e) => e.toJson()).toList()),
              prd.pricingId,
              prd.pricingNodeId,
              prd.queryNodeId,
              prd.channel,
              0,
              0,
              prd.image,
              id,
              jsonEncode(prd.brand),
              0
          ),
          instance.insert(instance.productDataDetail, product.toJson()),
        });
     }
   }
  }

  void getDiscounts(int? id) async{
    bool noPage = true;
    String url = '${AppUtils.baseUrl}${APIServices.schemeServices}?no_page=$noPage';

    var schemes = await AppUtils.requestBuilder(url, headers);
    try {
      if (schemes.statusCode == 200) {
        handleSchemeResponse(schemes.body,id!);
      }
    } catch (e) {
      AppUtils.showMessage(e.toString());
    }
  }

  void handleSchemeResponse(String body, int id){
    if(body.isNotEmpty){

      instance.deleteAllData(instance.schemesDataDetail);

      List<dynamic> parsedListJson = jsonDecode(body);
      List<CommonSchemes> schemes = List<CommonSchemes>.from(parsedListJson.map<CommonSchemes>((dynamic i) => CommonSchemes.fromJson(i)));
      if(schemes.isNotEmpty){
        SchemesDataDetail detail;
        schemes.map((scheme) => {
           if(scheme.products !=null){
             scheme.products?.map((schemeProduct) => {
               detail = SchemesDataDetail(scheme.id, schemeProduct.product!.id , scheme.name, schemeProduct.product!.name, schemeProduct.minQty, scheme.tenure, double.parse(scheme.schemeValue!), scheme.schemeType!.name, scheme.startDate, scheme.endDate, schemeProduct.isFree, scheme.description, scheme.schemeType!.id, scheme.schemeType!.name, id),
               instance.insert(instance.schemesDataDetail, detail.toJson()),
             }),
           }
        });
      }
    }
  }

  void callOtherServices() async{
    if(prefs.containsKey('last_store_update')){
      prefs.remove('last_store_update');
    }

    //channel service
    var channelsService = await AppUtils.requestBuilder(AppUtils.baseUrl + APIServices.getChannelServices(null, null, null, null), headers);
    try {
      if (channelsService.statusCode == 200) {
        handleChannelResponse(channelsService.body);
        servicesFinished.putIfAbsent('channelsService', () => true);
        handleSyncCompletion();
      }
    } catch (e) {
      AppUtils.showMessage('channel error - ${e.toString()}');
      servicesFinished.putIfAbsent('channelsService', () => false);
      handleSyncCompletion();
    }

    //place service
    var placeService = await AppUtils.requestBuilder(AppUtils.baseUrl + APIServices.placeServices, headers);
    try {
      if (placeService.statusCode == 200) {
        handlePlaceService(placeService.body);
        servicesFinished.putIfAbsent('placeService', () => true);
        handleSyncCompletion();
      }
    } catch (e) {
      servicesFinished.putIfAbsent('placeService', () => false);
      handleSyncCompletion();
      AppUtils.showMessage('place error - ${e.toString()}');
    }
    
    //task service
    var taskService = await AppUtils.requestBuilder(AppUtils.baseUrl + APIServices.getTaskService(null, 1, null, true), headers);
    try {
      if (taskService.statusCode == 200) {
        handleTaskService(taskService.body);
        servicesFinished.putIfAbsent('taskService', () => true);
        handleSyncCompletion();
      }
    } catch (e) {
      servicesFinished.putIfAbsent('taskService', () => false);
      handleSyncCompletion();
      AppUtils.showMessage('task error - ${e.toString()}');
    }

    //activity service
    var activityService = await AppUtils.requestBuilder(AppUtils.baseUrl + APIServices.activityService, headers);
    try {
      if (activityService.statusCode == 200) {
        handleActivities(activityService.body);
        servicesFinished.putIfAbsent('activityService', () => true);
        handleSyncCompletion();
      }
    } catch (e) {
      servicesFinished.putIfAbsent('activityService', () => false);
      handleSyncCompletion();
      AppUtils.showMessage('activities error - ${e.toString()}');
    }

    //user stats service
    var userStatsService = await AppUtils.requestBuilder(AppUtils.baseUrl + APIServices.userStatsService, headers);
    try {
      if (userStatsService.statusCode == 200) {
        handleUserStats(userStatsService.body);
        servicesFinished.putIfAbsent('userStatsService', () => true);
        handleSyncCompletion();
      }
    } catch (e) {
      servicesFinished.putIfAbsent('userStatsService', () => false);
      handleSyncCompletion();
      AppUtils.showMessage('user stats error - ${e.toString()}');
    }

    //store type service
    var storeTypeService = await AppUtils.requestBuilder(AppUtils.baseUrl + APIServices.storeTypesService, headers);
    try {
      if (storeTypeService.statusCode == 200) {
        handleStoreTypes(storeTypeService.body);
        servicesFinished.putIfAbsent('storeTypeService', () => true);
        handleSyncCompletion();
      }
    } catch (e) {
      servicesFinished.putIfAbsent('storeTypeService', () => false);
      handleSyncCompletion();
      AppUtils.showMessage('store types error - ${e.toString()}');
    }

    //dynamic user actions service
    var dynamicUserActions = await AppUtils.requestBuilder(AppUtils.baseUrl + APIServices.dynamicUserActionsService, headers);
    try {
      if (dynamicUserActions.statusCode == 200) {
        handleDynamicUserActions(dynamicUserActions.body);
        servicesFinished.putIfAbsent('dynamicUserActions', () => true);
        handleSyncCompletion();
      }
    } catch (e) {
      servicesFinished.putIfAbsent('dynamicUserActions', () => false);
      handleSyncCompletion();
      AppUtils.showMessage('dynamicUserActions error - ${e.toString()}');
    }

    //dynamic user action list service
    var dynamicUserActionList = await AppUtils.requestBuilder(AppUtils.baseUrl + APIServices.dynamicActionListService, headers);
    try {
      if (dynamicUserActionList.statusCode == 200) {
        handleDynamicUserActionList(dynamicUserActionList.body);
        servicesFinished.putIfAbsent('dynamicUserActionList', () => true);
        handleSyncCompletion();
      }
    } catch (e) {
      servicesFinished.putIfAbsent('dynamicUserActionList', () => false);
      handleSyncCompletion();
      AppUtils.showMessage('dynamicUserActionList error - ${e.toString()}');
    }

    //reasons service
    var reasonService = await AppUtils.requestBuilder(AppUtils.baseUrl + APIServices.getReasonsService(null), headers);
    try {
      if (reasonService.statusCode == 200) {
        handleReasonsData(reasonService.body);
        servicesFinished.putIfAbsent('reasonService', () => true);
        handleSyncCompletion();
      }
    } catch (e) {
      servicesFinished.putIfAbsent('reasonService', () => false);
      handleSyncCompletion();
      AppUtils.showMessage('reasons service error - ${e.toString()}');
    }

    //stores service
    var storesService = await AppUtils.requestBuilder(AppUtils.baseUrl + APIServices.getStoreService(AppUtils.getSalesman(prefs)), headers);
    try {
      if (storesService.statusCode == 200) {
        handleStoresData(storesService.body);
        servicesFinished.putIfAbsent('storesService', () => true);
        handleSyncCompletion();
      }
    } catch (e) {
      servicesFinished.putIfAbsent('storesService', () => false);
      handleSyncCompletion();
      AppUtils.showMessage('stores error - ${e.toString()}');
    }

  }

  void handleStoresData(String? body){
    if(body!=null && body.isNotEmpty){
      StoreResponse storeResponse = StoreResponse.fromJson(jsonDecode(body));
      if(storeResponse.data != null && storeResponse.data!.isNotEmpty){
        saveLastStoreUpdate(storeResponse.lastUpdate);
        insertStoresData(storeResponse.data);
      }
    }
  }

  void insertStoresData(List<StoreData>? stores){
    instance.deleteAllData(instance.storeDataDetail);
    instance.deleteAllData(instance.storeBeatMappingDataDetail);
    instance.deleteAllData(instance.storeColorDataDetail);
    instance.deleteAllData(instance.storePriceMappingDataDetail);

    List<int> pricingIds = [];

    for(StoreData store in stores!){

      StoresDataDetail detail = StoresDataDetail(store.outletId, store.storeId, store.storeName, store.storeLatitude, store.storeLongitude, jsonEncode(store.beats?.map((e) => e.toJson()).toList()), jsonEncode(store.distributorRelation?.map((e) => e.toJson()).toList()), store.tenantId, store.name, store.ownerName, store.managerName, store.contactNo, store.alternateNo, store.division, store.outletLatitude, store.outletLongitude, store.outletAccuracy, store.storeStatus, store.description, store.surveyStatus, store.colorStatus, store.otpSent, store.otpVerified, store.otpSentAlternate, store.otpVerifiedAlternate, store.sms, store.tele, store.email, store.createdAt, store.updatedAt, store.source!=null?store.source.toString():'', store.companyOutletCode!=null?store.companyOutletCode.toString():'', jsonEncode(store.metaData), store.taxType!=null?store.taxType.toString():'', store.taxId!=null?store.taxId.toString():'', store.outletType, store.channel, store.territory, store.beat, store.createdBy, store.updatedBy, '', AppUtils.getSalesman(prefs), jsonEncode(store.schemes?.map((e) => e.toJson()).toList()), store.metaData!=null?store.metaData!.gstn:'', store.metaData!=null?store.metaData!.license:'', store.metaData!=null?store.metaData!.address:'', store.metaData!=null?store.metaData!.remarks:'');
      instance.insert(instance.storeDataDetail, detail.toJson());

      //store beat mapping
      if(store.beats!=null && store.beats!.isNotEmpty){
        for(StoreBeat beat in store.beats!){
          StoreBeatMappingDataDetail beatMappingDataDetail  = StoreBeatMappingDataDetail(store.storeId, beat.id, beat.name, AppUtils.getSalesman(prefs));
          instance.insert(instance.storeBeatMappingDataDetail, beatMappingDataDetail.toJson());
        }
      }

      //store color mapping
      if(store.colours!=null && store.colours!.isNotEmpty){
        for(Colours color in store.colours!){
          StoreColorDataDetail detail = StoreColorDataDetail(store.storeId, color.colour, color.beat, color.salesTerritory, color.visitDate, color.bill, color.noBill);
          instance.insert(instance.storeColorDataDetail, detail.toJson());
        }
      }

      //store price mapping
      if(store.pricings!=null && store.pricings!.isNotEmpty){
        for(Pricing pricing in store.pricings!){
          pricingIds.add(pricing.pricingList!);
          StorePriceMappingDataDetail detail = StorePriceMappingDataDetail(store.storeId, pricing.scope, pricing.pricingList, pricing.status, AppUtils.getSalesman(prefs));
          instance.insert(instance.storePriceMappingDataDetail, detail.toJson());
        }
      }
    }

    fetchPricingList(pricingIds);

  }

  void fetchPricingList(List<int> pricingIds) async{
    var pricingService = await AppUtils.requestBuilder(AppUtils.baseUrl + APIServices.getPricingListService(true,true,pricingIds), headers);
    try {
      if (pricingService.statusCode == 200) {
        handlePricingData(pricingService.body);
      }
    } catch (e) {
      AppUtils.showMessage('pricingService error - ${e.toString()}');
    }
  }

  void handlePricingData(String? body){
    if(body!=null && body.isNotEmpty){
      List<dynamic> parsedListJson = jsonDecode(body);
      List<PricingResponse> pricingList = List<PricingResponse>.from(parsedListJson.map<PricingResponse>((dynamic i) => PricingResponse.fromJson(i)));
      if(pricingList.isNotEmpty){
        instance.deleteAllData(instance.pricingDataDetail);
        for(PricingResponse pricing in pricingList){
          if(pricing.pricings!=null && pricing.pricings!.isNotEmpty){
            for(ProductPricingObj ppObj in pricing.pricings!){
              PricingDataDetail detail = PricingDataDetail(pricing.id, pricing.name, pricing.code, pricing.description, pricing.createdAt, pricing.updatedAt, pricing.status, ppObj.product!.id, ppObj.mrp, ppObj.ptr, ppObj.pts, ppObj.nrv, ppObj.isFeatureProduct, ppObj.status, AppUtils.getSalesman(prefs));
              instance.insert(instance.pricingDataDetail, detail.toJson());
            }
          }
        }
      }
    }
  }

  void saveLastStoreUpdate(String? lastUpdate){
    if(lastUpdate!=null && lastUpdate.isNotEmpty){
      prefs.setString('last_store_update', lastUpdate);
    }
  }

  void handleReasonsData(String? body){
    if(body!=null && body.isNotEmpty){
      ReasonsResponse reasonsResponse = ReasonsResponse.fromJson(jsonDecode(body));
      if(reasonsResponse.results!=null && reasonsResponse.results!.isNotEmpty){
        instance.deleteAllData(instance.reasonsDataDetail);
        for(Reasons reason in reasonsResponse.results!){
          ReasonDataDetails detail = ReasonDataDetails(reason.id, reason.tenantId, reason.value, reason.groupName, reason.label, reason.status, reason.createdAt, reason.updatedAt);
          instance.insert(instance.reasonsDataDetail, detail.toJson());
        }
      }
    }
  }

  void handleDynamicUserActionList(String? body){
    if(body!=null && body.isNotEmpty){
      AppUtils.writeResponseToDisk(body,AppUtils.webFiles,'action_list','html');
    }
  }


  void handleDynamicUserActions(String? body){
    if(body!=null && body.isNotEmpty){
      List<dynamic> parsedListJson = jsonDecode(body);
      List<FormActions> forms = List<FormActions>.from(parsedListJson.map<FormActions>((dynamic i) => FormActions.fromJson(i)));
      instance.deleteAllData(instance.formActionsDataDetail);
      for(FormActions form in forms){
        FormActionsDataDetails details = FormActionsDataDetails(form.id, form.tenantId, form.name, form.description, form.status, form.createdAt, form.updatedAt, form.actor, form.group, form.process, form.category, form.formContent, form.documentType, form.permissionId);
        instance.insert(instance.formActionsDataDetail, details.toJson());
      }
    }
  }

  void handleStoreTypes(String? body){
    if(body!=null && body.isNotEmpty){
      StoreTypeResponse storeTypeResponse = StoreTypeResponse.fromJson(jsonDecode(body));
      if(storeTypeResponse.data!=null && storeTypeResponse.data!.isNotEmpty){
        instance.deleteAllData(instance.storeTypesDataDetail);
        for(StoreTypesData type in storeTypeResponse.data!){
          StoreTypesDataDetail detail = StoreTypesDataDetail(type.id, type.name);
          instance.insert(instance.storeTypesDataDetail, detail.toJson());
        }
      }
    }
  }

  void handleUserStats(String? body){
    if(body!=null && body.isNotEmpty){
      UserStatsData userStats = UserStatsData.fromJson(jsonDecode(body));
      instance.deleteAllData(instance.userStatsDataDetail);
      UserStatsDataDetail detail = UserStatsDataDetail(userStats.status, userStats.monthNrv, userStats.todayNrv, userStats.monthBilled, userStats.monthUnbilled, userStats.todayBilled, userStats.todayUnbilled);
      instance.insert(instance.userStatsDataDetail, detail.toJson());
    }
  }

  void handleActivities(String? body){
    if(body!=null && body.isNotEmpty) {
      List<dynamic> parsedListJson = jsonDecode(body);
      List<ActivityData> activities = List<ActivityData>.from(parsedListJson.map<ActivityData>((dynamic i) => ActivityData.fromJson(i)));
      if(activities.isNotEmpty){
        instance.deleteAllData(instance.activitiesDataDetail);
        for(ActivityData activityData in activities){
          ActivityDataDetail detail = ActivityDataDetail(activityData.id, activityData.name, activityData.startDate, activityData.endDate, activityData.isActive);
          instance.insert(instance.activitiesDataDetail, detail.toJson());
        }
      }
    }
  }

  void handleTaskService(String? body){
    if(body!=null && body.isNotEmpty) {
      PendingTaskResponse pendingTaskResponse = PendingTaskResponse.fromJson(jsonDecode(body));
      if(pendingTaskResponse.results!=null && pendingTaskResponse.results!.isNotEmpty){
        instance.deleteAllData(instance.pendingTaskDataDetail);
        for(PendingTask task in pendingTaskResponse.results!){
          PendingTaskDataDetail detail = PendingTaskDataDetail(
            task.id,
            jsonEncode(task.form),
            jsonEncode(task.instance),
            jsonEncode(task.submittedBy),
            task.taskName,
            task.status,
            task.createdAt,
            task.updatedAt,
            task.startDate,
            task.expireDate,
            task.submittedAt,
            task.checksum,
            jsonEncode(task.data),
            task.actor,
            task.group,
            task.step,
            task.instance!.data!.storeId
          );
          instance.insert(instance.pendingTaskDataDetail, detail.toJson());
        }
      }
    }
  }

  void handlePlaceService(String? body){
    if(body!=null && body.isNotEmpty) {
      PlaceResponse placeResponse = PlaceResponse.fromJson(jsonDecode(body));
      if(placeResponse.places!=null && placeResponse.places!.isNotEmpty){
        instance.deleteAllData(instance.placeDataDetail);
        for(Places place in placeResponse.places!){
          PlacesDataDetail detail = PlacesDataDetail(place.id, place.tenantId, place.name, place.createdAt, place.updatedAt, place.isTerritory, place.type, place.parent);
          instance.insert(instance.placeDataDetail, detail.toJson());
        }
      }
    }
  }

  void handleChannelResponse(String? body){
    if(body!=null && body.isNotEmpty) {
      ChannelResponse channelResponse = ChannelResponse.fromJson(jsonDecode(body));
      if(channelResponse.results!=null && channelResponse.results!.isNotEmpty){
        instance.deleteAllData(instance.channelDataDetail);
        for(ChannelObj channel in channelResponse.results!){
          ChannelDataDetail detail = ChannelDataDetail(channel.id, channel.tenantId, channel.name, channel.status, channel.description, channel.createdAt, channel.updatedAt);
          instance.insert(instance.channelDataDetail, detail.toJson());
        }
      }
    }
  }



  void handleUserDataResponse(String? body) {
    if(body!=null && body.isNotEmpty) {
      prefs.setString("user_data", body);
      sendBroadcastToDashboard(AppStrings.key_set_places);
    }
  }

  void handleSyncCompletion(){
    var calledLength = servicesToBeCalled.length;
    var finishedLength = servicesFinished.length;
    var percentage = (finishedLength*100)/calledLength;
    FBroadcast.instance().broadcast(AppStrings.key_sync_progress,value: percentage);
    bool success = true;
    if(calledLength==finishedLength){
      try{
        serviceNames.forEach((element) {
          if(servicesFinished[element]!=null && !servicesFinished[element]!){
            success = false;
          }
        });
      }catch(e){
        print('error - ${e.toString()}');
      }

      if(success){
        sendBroadcastToDashboard(AppStrings.key_success);
      }else{
        sendBroadcastToDashboard(AppStrings.key_failure);
      }

      servicesToBeCalled.clear();
      servicesFinished.clear();

      AppUtils.isSyncGoingOn = false;

    }



  }

  void sendBroadcastToDashboard(String key) {
    FBroadcast.instance().broadcast(key);
  }
}


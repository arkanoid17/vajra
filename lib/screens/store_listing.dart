import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/components/map_stores_component.dart';
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/pricing_data_detail/pricing_data_detail.dart';
import 'package:vajra/db/store_beat_mapping_data_detail/store_beat_mapping_data_detail.dart';
import 'package:vajra/db/store_color_data_detail/store_color_data_detail.dart';
import 'package:vajra/db/store_price_mapping_data_detail/store_price_mapping_data_detail.dart';
import 'package:vajra/db/store_types_data_detail/store_types_data_detail.dart';
import 'package:vajra/db/stores_data_detail/stores_data_detail.dart';
import 'package:vajra/db/user_hierarchy_data_detail/user_hierarchy_data_detail.dart';
import 'package:vajra/dialogs/store_options.dailog.dart';
import 'package:vajra/dialogs/user_selection_diaalog.dart';
import 'package:vajra/models/pricing_data/pricing_response.dart';
import 'package:vajra/models/pricing_data/product_pricing_obj.dart';
import 'package:vajra/models/stores_data/colours.dart';
import 'package:vajra/models/stores_data/pricing.dart';
import 'package:vajra/models/stores_data/store_beat.dart';
import 'package:vajra/models/stores_data/store_data.dart';
import 'package:vajra/models/stores_data/store_response.dart';
import 'package:vajra/models/user_data/user_data.dart';
import 'package:vajra/models/user_hierarchy/hierarchy_beat_calendar.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy_beat.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy_location.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy_salesman_distributors.dart';
import 'package:vajra/models/user_selector/user_selector.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/services/APIServices.dart';
import 'package:vajra/utils/app_utils.dart';
import 'package:vajra/utils/network_connectivity.dart';

class StoreListing extends StatefulWidget {
  const StoreListing({super.key});

  @override
  State<StatefulWidget> createState() => _StoreListing();
}

class _StoreListing extends State<StoreListing> {
  List<String> todayBeatNames = [];

  List<UserHierarchyDataDetail> allUsers = [];
  List<UserSelector> listUser = [];
  List<UserHierarchyBeat> availableBeats = [];
  List<UserHierarchyBeat> selectedBeats = [];

  Position? location;
  StreamSubscription<Position>? positionStream;

  List<StoreTypesDataDetail> listStoreTypes = [];

  SharedPreferences? prefs;

  String todayDate = '';
  int selectedUser = 0;

  bool fetchingLocation = true;

  late DatabaseHelper instance;

  List<StoresDataDetail> stores = [];
  List<StoresDataDetail> sortedList = [];
  List<StoresDataDetail> filteredList = [];

  List<String> visitTypes = [
    AppStrings.billed,
    AppStrings.unbilled,
    AppStrings.notVisited
  ];
  List<Color> visitColors = [
    ColorConstants.billedColor,
    ColorConstants.unBilledColor,
    ColorConstants.notVisitedColor
  ];

  String viewType = 'list';

  bool isSearching = false;

  Map<String, String> headers = {};

  void getLocation() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: AppUtils.getDistanceLocationUpdate(prefs!),
      timeLimit: Duration(seconds: AppUtils.getTimeLocationUpdate(prefs!)),
    );
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null) {
        setState(() {
          fetchingLocation = false;
          location = position;
        });
        updateLocationChange();
      }
    });
  }

  void updateLocationChange() {
    if (stores.isEmpty) {
      getStores();
    } else {
      updateDistance();
    }
  }

  void setTodayDate() {
    setState(() {
      todayDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    });
  }

  void getStoreTypes() async {
    List<StoreTypesDataDetail> details = [];

    var result = await instance
        .execQuery('SELECT * FROM ${instance.storeTypesDataDetail}');
    for (var element in result) {
      details.add(StoreTypesDataDetail(element[StoreTypesDataDetailFields.id],
          element[StoreTypesDataDetailFields.name]));
    }
    setState(() {
      listStoreTypes = details.isNotEmpty ? details : [];
    });
    getAllUsers();
  }

  void getAllUsers() async {
    List<UserHierarchyDataDetail> details = [];

    var cnt = await instance.execQuery(
        'SELECT COUNT(*) AS cnt FROM ${instance.tableUserHierarchyDataDetail}');

    var result = await instance.execQuery(
        'SELECT * FROM ${instance.tableUserHierarchyDataDetail} WHERE ${UserHierarchyDataDetailFields.isActive}=1');

    for (var element in result) {
      details.add(UserHierarchyDataDetail(
          element[UserHierarchyDataDetailFields.serverId],
          element[UserHierarchyDataDetailFields.employName],
          element[UserHierarchyDataDetailFields.employId],
          element[UserHierarchyDataDetailFields.locations],
          element[UserHierarchyDataDetailFields.salesmanDistributors],
          element[UserHierarchyDataDetailFields.beats],
          element[UserHierarchyDataDetailFields.lastLogin],
          element[UserHierarchyDataDetailFields.tenantId],
          element[UserHierarchyDataDetailFields.userId],
          element[UserHierarchyDataDetailFields.name],
          element[UserHierarchyDataDetailFields.mobileNumber],
          element[UserHierarchyDataDetailFields.email],
          element[UserHierarchyDataDetailFields.isExternal] == 1,
          element[UserHierarchyDataDetailFields.isActive] == 1,
          element[UserHierarchyDataDetailFields.dateJoined],
          element[UserHierarchyDataDetailFields.fcmToken],
          element[UserHierarchyDataDetailFields.createdAt],
          element[UserHierarchyDataDetailFields.updatedAt],
          element[UserHierarchyDataDetailFields.isSalesman] == 1,
          element[UserHierarchyDataDetailFields.isGeoRestricted] == 1,
          element[UserHierarchyDataDetailFields.place],
          element[UserHierarchyDataDetailFields.role],
          element[UserHierarchyDataDetailFields.manager],
          element[UserHierarchyDataDetailFields.createdBy],
          element[UserHierarchyDataDetailFields.updatedBy]));
    }
    setState(() {
      allUsers = details.isNotEmpty ? details : [];
    });
    fetchUsersInSelector();
  }

  void fetchUsersInSelector() {
    List<UserSelector> selectors = [];
    if (allUsers.isNotEmpty) {
      for (UserHierarchyDataDetail detail in allUsers) {
        UserSelector selector = UserSelector(
            detail.serverId,
            detail.employName,
            detail.employId,
            parseLocations(detail.locations),
            parseDistributors(detail.salesmanDistributors),
            parseBeats(detail.beats),
            detail.lastLogin,
            detail.tenantId,
            detail.userId,
            detail.name,
            detail.mobileNumber,
            detail.email,
            detail.isExternal,
            detail.isActive,
            detail.dateJoined,
            detail.fcmToken,
            detail.createdAt,
            detail.updatedAt,
            detail.isSalesman,
            detail.place,
            detail.role,
            detail.manager,
            detail.createdBy,
            detail.updatedBy,
            null,
            false);
        selectors.add(selector);
      }

      setState(() {
        listUser = selectors.isNotEmpty ? selectors : [];
      });
    }
  }

  void selectUserTodayBeat() {

    if(selectedBeats.isEmpty){
      List<UserHierarchyBeat> beats = [];
      for (UserSelector user in listUser) {
        if (user.id == selectedUser) {
          beats.addAll(user.beats != null ? user.beats! : []);
        }
      }
      if (beats.isNotEmpty) {
        int wk =
        AppUtils.weekOfTheMonth(DateFormat('dd/MM/yyyy').parse(todayDate));
        String dayOfWeek =
        AppUtils.dayOfTheWeek(DateFormat('dd/MM/yyyy').parse(todayDate));

        List<UserHierarchyBeat> todayBeats = [];
        for (UserHierarchyBeat beat in beats) {
          if (beat.calendar != null && beat.calendar!.isNotEmpty) {
            for (HierarchyBeatCalendar calendar in beat.calendar!) {
              if (calendar.dayName == dayOfWeek && calendar.weekNo == wk) {
                todayBeats.add(beat);
                break;
              }
            }
          }
        }

        if (todayBeats.isNotEmpty) {
          setState(() {
            selectedBeats = todayBeats;
          });
          filterStores();
        }
      }
    }else{
      filterStores();
    }


  }

  void filterStores() async {
    List<StoresDataDetail> beatStores = [];

    List<int> beats = selectedBeats.map((e) => e.id!).toList();
    String ids = beats.join(', ');

    var result = await instance.execQuery(
        'SELECT ${StoreBeatMappingDataDetailFields.storeId} FROM ${instance.storeBeatMappingDataDetail} WHERE ${StoreBeatMappingDataDetailFields.beatId} in ($ids) and ${StoreBeatMappingDataDetailFields.salesmanId} = $selectedUser');

    List<String> storeIds = [];
    storeIds.addAll(result
        .map((e) => e[StoreBeatMappingDataDetailFields.storeId].toString())
        .toList());

    for (StoresDataDetail store in stores) {
      if (storeIds.contains(store.storeId)) {
        beatStores.add(store);
      }
    }

    beatStores.sort((a, b) => a.distance!.compareTo(b.distance!));

    setState(() {
      sortedList = beatStores;
      filteredList = beatStores;
    });
  }

  void getStores() async {
    List<StoresDataDetail> storeList = [];

    var result = await instance.execQuery(
        'SELECT * FROM ${instance.storeDataDetail} WHERE ${StoresDataDetailFields.salesmanId} = $selectedUser');

    for (var element in result) {
      storeList.add(StoresDataDetail(
          element[StoresDataDetailFields.outletId],
          element[StoresDataDetailFields.storeId],
          element[StoresDataDetailFields.storeName],
          element[StoresDataDetailFields.storeLatitude],
          element[StoresDataDetailFields.storeLongitude],
          element[StoresDataDetailFields.beats],
          element[StoresDataDetailFields.distributorRelation],
          element[StoresDataDetailFields.tenantId],
          element[StoresDataDetailFields.name],
          element[StoresDataDetailFields.ownerName],
          element[StoresDataDetailFields.managerName],
          element[StoresDataDetailFields.contactNo],
          element[StoresDataDetailFields.alternateNo],
          element[StoresDataDetailFields.division],
          element[StoresDataDetailFields.outletLatitude],
          element[StoresDataDetailFields.outletLongitude],
          element[StoresDataDetailFields.outletAccuracy],
          element[StoresDataDetailFields.storeStatus] == 1,
          element[StoresDataDetailFields.description],
          element[StoresDataDetailFields.surveyStatus] == 1,
          element[StoresDataDetailFields.colorStatus],
          element[StoresDataDetailFields.otpSent] == 1,
          element[StoresDataDetailFields.otpVerified] == 1,
          element[StoresDataDetailFields.otpSentAlternate] == 1,
          element[StoresDataDetailFields.otpVerifiedAlternate] == 1,
          element[StoresDataDetailFields.sms] == 1,
          element[StoresDataDetailFields.tele] == 1,
          element[StoresDataDetailFields.email] == 1,
          element[StoresDataDetailFields.createdAt],
          element[StoresDataDetailFields.updatedAt],
          element[StoresDataDetailFields.source],
          element[StoresDataDetailFields.companyOutletCode],
          element[StoresDataDetailFields.metaData],
          element[StoresDataDetailFields.taxType],
          element[StoresDataDetailFields.taxId],
          element[StoresDataDetailFields.outletType],
          element[StoresDataDetailFields.channel],
          element[StoresDataDetailFields.territory],
          element[StoresDataDetailFields.beat],
          element[StoresDataDetailFields.createdBy],
          element[StoresDataDetailFields.updatedBy],
          element[StoresDataDetailFields.distance],
          element[StoresDataDetailFields.salesmanId],
          element[StoresDataDetailFields.schemes],
          element[StoresDataDetailFields.gstNumber],
          element[StoresDataDetailFields.licenceNumber],
          element[StoresDataDetailFields.address],
          element[StoresDataDetailFields.remarks]));
    }

    setState(() {
      stores = storeList;
    });
    updateDistance();
  }

  void updateDistance() {
    List<StoresDataDetail> storeList = stores;
    int pos = -1;

    for (StoresDataDetail store in stores) {
      ++pos;
      var distance = AppUtils.getDistance(
        double.parse(
            store.storeLatitude != null ? store.storeLatitude! : '0.0'),
        double.parse(
            store.storeLongitude != null ? store.storeLongitude! : '0.0'),
        location!.latitude,
        location!.longitude,
      );

      instance.execQuery(
          'UPDATE ${instance.storeDataDetail} SET distance = $distance');

      storeList[pos].distance = distance;
    }

    setState(() {
      stores = storeList;
    });
    selectUserTodayBeat();
  }

  @override
  void initState() {
    setTodayDate();

    setState(() {
      instance = DatabaseHelper.instance;
    });

    if (prefs == null) {
      AppUtils.getPrefs().then((value) => {
            setState(() {
              prefs = value;
              selectedUser = AppUtils.getSalesman(value);
              headers = AppUtils.headers(
                  value.getString('tenant_id') != null
                      ? value.getString('tenant_id')!
                      : '',
                  value.getString('token') != null
                      ? value.getString('token')!
                      : '');
            }),
            getStoreTypes(),
            getLocation(),
          });
    }

    super.initState();
  }

  String getBeatNames() {
    var names = selectedBeats.map((e) => e.name).toList().join(', ');
    return names;
  }

  String getDistanceValue(String val) {
    double dist = double.parse(val);
    if (dist > 1000) {
      dist = dist / 1000;
      return '${(dist.toStringAsFixed(2))} KM';
    }

    return '$dist M';
  }

  Future<int> getVisitDetails(String storeId) async {
    var result = await instance.execQuery(
        'SELECT ${StoreColorDataDetailFields.colour} from ${instance.storeColorDataDetail} where ${StoreColorDataDetailFields.storeId} = "$storeId" AND ${StoreColorDataDetailFields.salesTerritory} = ${getSalesTerritory()}');
    for (var element in result) {
      if (element != null &&
          element[StoreColorDataDetailFields.colour] != null) {
        int pos = element[StoreColorDataDetailFields.colour];
        return pos;
      } else {
        return 2;
      }
    }
    return 2;
  }

  int getSalesTerritory() {
    for (UserHierarchyDataDetail detail in allUsers) {
      if (detail.serverId == selectedUser) {
        var locationsString = detail.locations;
        if (locationsString != null && locationsString.isNotEmpty) {
          List<dynamic> parsedList = jsonDecode(locationsString);
          var locationList = List<UserHierarchyLocation>.from(
              parsedList.map<UserHierarchyLocation>(
                  (dynamic i) => UserHierarchyLocation.fromJson(i)));
          if (locationList != null && locationList.isNotEmpty) {
            return locationList[0].id!;
          }
        }
      }
    }

    return 0;
  }

  void setRefreshClick() async {
    prefs!.remove('last_store_update');
    if (isSalesMan()) {
      if (await storesAvailable()) {
        getStores();
      } else {
        fetchStores();
      }
    } else {
      getStores();
    }
  }

  bool isSalesMan() {
    return allUsers
        .where((element) => element.serverId == selectedUser)
        .first
        .isSalesman!;
  }

  void fetchStores() async {
    // var isConnected = await NetworkConnectivity.isConnected();
    setState(() {
      sortedList = [];
      filteredList = [];
    });

    var storesService = await AppUtils.requestBuilder(
        AppUtils.baseUrl + APIServices.getStoreService(selectedUser), headers);
    try {
      if (storesService.statusCode == 200) {
        handleStoresData(storesService.body);
      }
    } catch (e) {
      getStores();
      AppUtils.showMessage('stores error - ${e.toString()}');
    }
  }

  void handleStoresData(String? body) {
    try {
      if (body != null && body.isNotEmpty) {
        StoreResponse storeResponse = StoreResponse.fromJson(jsonDecode(body));
        if (storeResponse.data != null && storeResponse.data!.isNotEmpty) {
          saveLastStoreUpdate(storeResponse.lastUpdate);
          insertStoresData(storeResponse.data);
        }
      }
    } catch (e) {
      AppUtils.showMessage('store error- ${e.toString()}');
    }
  }

  void saveLastStoreUpdate(String? lastUpdate) {
    if (lastUpdate != null && lastUpdate.isNotEmpty) {
      prefs!.setString('last_store_update', lastUpdate);
    }
  }

  void insertStoresData(List<StoreData>? stores) {
    instance.execQuery(
        'DELETE FROM ${instance.storeDataDetail} WHERE ${StoresDataDetailFields.salesmanId} = $selectedUser');
    instance.execQuery(
        'DELETE FROM ${instance.storeBeatMappingDataDetail} WHERE ${StoreBeatMappingDataDetailFields.salesmanId} = $selectedUser');
    instance.deleteAllData(instance.storeColorDataDetail);
    instance.execQuery(
        'DELETE FROM ${instance.storePriceMappingDataDetail} WHERE ${StorePriceMappingDataDetailFields.userId} = $selectedUser');

    List<int> pricingIds = [];

    for (StoreData store in stores!) {
      StoresDataDetail detail = StoresDataDetail(
          store.outletId,
          store.storeId,
          store.storeName,
          store.storeLatitude,
          store.storeLongitude,
          jsonEncode(store.beats?.map((e) => e.toJson()).toList()),
          jsonEncode(
              store.distributorRelation?.map((e) => e.toJson()).toList()),
          store.tenantId,
          store.name,
          store.ownerName,
          store.managerName,
          store.contactNo,
          store.alternateNo,
          store.division,
          store.outletLatitude,
          store.outletLongitude,
          store.outletAccuracy,
          store.storeStatus,
          store.description,
          store.surveyStatus,
          store.colorStatus,
          store.otpSent,
          store.otpVerified,
          store.otpSentAlternate,
          store.otpVerifiedAlternate,
          store.sms,
          store.tele,
          store.email,
          store.createdAt,
          store.updatedAt,
          store.source != null ? store.source.toString() : '',
          store.companyOutletCode != null
              ? store.companyOutletCode.toString()
              : '',
          jsonEncode(store.metaData),
          store.taxType != null ? store.taxType.toString() : '',
          store.taxId != null ? store.taxId.toString() : '',
          store.outletType,
          store.channel,
          store.territory,
          store.beat,
          store.createdBy,
          store.updatedBy,
          '',
          selectedUser,
          jsonEncode(store.schemes?.map((e) => e.toJson()).toList()),
          store.metaData != null ? store.metaData!.gstn : '',
          store.metaData != null ? store.metaData!.license : '',
          store.metaData != null ? store.metaData!.address : '',
          store.metaData != null ? store.metaData!.remarks : '');

      instance.insert(instance.storeDataDetail, detail.toJson());

      //store beat mapping
      if (store.beats != null && store.beats!.isNotEmpty) {
        for (StoreBeat beat in store.beats!) {
          StoreBeatMappingDataDetail beatMappingDataDetail =
              StoreBeatMappingDataDetail(
                  store.storeId, beat.id, beat.name, selectedUser);
          instance.insert(instance.storeBeatMappingDataDetail,
              beatMappingDataDetail.toJson());
        }
      }

      //store color mapping
      if (store.colours != null && store.colours!.isNotEmpty) {
        for (Colours color in store.colours!) {
          StoreColorDataDetail detail = StoreColorDataDetail(
              store.storeId,
              color.colour,
              color.beat,
              color.salesTerritory,
              color.visitDate,
              color.bill,
              color.noBill);
          instance.insert(instance.storeColorDataDetail, detail.toJson());
        }
      }

      //store price mapping
      if (store.pricings != null && store.pricings!.isNotEmpty) {
        for (Pricing pricing in store.pricings!) {
          pricingIds.add(pricing.pricingList!);
          StorePriceMappingDataDetail detail = StorePriceMappingDataDetail(
              store.storeId,
              pricing.scope,
              pricing.pricingList,
              pricing.status,
              selectedUser);
          instance.insert(
              instance.storePriceMappingDataDetail, detail.toJson());
        }
      }
    }

    fetchPricingList(pricingIds);
  }

  void fetchPricingList(List<int> pricingIds) async {
    var pricingService = await AppUtils.requestBuilder(
        AppUtils.baseUrl +
            APIServices.getPricingListService(true, true, pricingIds),
        headers);
    try {
      if (pricingService.statusCode == 200) {
        handlePricingData(pricingService.body);
      } else {
        getStores();
      }
    } catch (e) {
      getStores();
      AppUtils.showMessage('pricingService error - ${e.toString()}');
    }
  }

  void handlePricingData(String? body) {
    if (body != null && body.isNotEmpty) {
      List<dynamic> parsedListJson = jsonDecode(body);
      List<PricingResponse> pricingList = List<PricingResponse>.from(
          parsedListJson.map<PricingResponse>(
              (dynamic i) => PricingResponse.fromJson(i)));
      if (pricingList.isNotEmpty) {
        // instance.deleteAllData(instance.pricingDataDetail);

        instance.execQuery(
            'DELETE FROM ${instance.pricingDataDetail} WHERE ${PricingDataDetailFields.userId} = $selectedUser');

        for (PricingResponse pricing in pricingList) {
          if (pricing.pricings != null && pricing.pricings!.isNotEmpty) {
            for (ProductPricingObj ppObj in pricing.pricings!) {
              PricingDataDetail detail = PricingDataDetail(
                  pricing.id,
                  pricing.name,
                  pricing.code,
                  pricing.description,
                  pricing.createdAt,
                  pricing.updatedAt,
                  pricing.status,
                  ppObj.product!.id,
                  ppObj.mrp,
                  ppObj.ptr,
                  ppObj.pts,
                  ppObj.nrv,
                  ppObj.isFeatureProduct,
                  ppObj.status,
                  selectedUser);
              instance.insert(instance.pricingDataDetail, detail.toJson());
            }
          }
        }
      }
    }

    getStores();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: isSearching
            ? TextField(
                style: TextStyle(color: Colors.white, fontSize: 16),
                onChanged: (text) {
                  setState(() {
                    filteredList = text.isNotEmpty
                        ? sortedList
                            .where((element) => element.name!
                                .toLowerCase()
                                .contains(text.trim().toLowerCase()))
                            .toList()
                        : sortedList;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppStrings.search,
                  hintStyle: TextStyle(
                      color: Colors.white.withAlpha(120), fontSize: 16),
                ),
              )
            : Text(getBeatNames()),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (isSearching) {
                    setState(() {
                      filteredList = sortedList;
                    });
                  }
                  isSearching = !isSearching;
                });
              },
              icon: isSearching ? Icon(Icons.cancel) : Icon((Icons.search))),
          IconButton(
              onPressed: () => AppUtils.showDialog(
                  context,
                  UserSelectionDialog(
                      allUsers: allUsers,
                      listUser: listUser,
                      prefs: prefs!,
                      todayDate: todayDate,
                      getDate: getDate,
                      applyFilter: applyFilter,
                      availableBeats: availableBeats,
                      selectedBeats: selectedBeats,
                    selectedUser: selectedUser,
                  )),
              icon: Icon(Icons.filter_list_alt)),
          PopupMenuButton<int>(
              itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                    const PopupMenuItem<int>(
                        value: 1, child: Text(AppStrings.mapListView)),
                    const PopupMenuItem<int>(
                        value: 2, child: Text(AppStrings.sortList)),
                    const PopupMenuItem<int>(
                        value: 3, child: Text(AppStrings.refresh)),
                  ],
              onSelected: (int value) {
                if (stores.isNotEmpty) {
                  switch (value) {
                    case 1:
                      setState(() {
                        viewType = viewType == 'list' ? 'map' : 'list';
                      });
                      break;
                    case 2:
                      setState(() {
                        fetchingLocation = true;
                        positionStream!.cancel();
                        positionStream = null;
                        getLocation();
                      });
                      break;
                    case 3:
                      // setRefreshClick();
                      break;
                  }
                }
              })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fetchingLocation
              ? Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstants.color_FF5DC0FF,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      AppStrings.waitForCorrectLocation,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                )
              : Container(),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Text(
              '${AppStrings.showingResults} : ${filteredList.length}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          sortedList.isNotEmpty
              ? viewType == 'list'
                  ? Expanded(
                      child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredList.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return InkWell(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 16, right: 16, top: 5, bottom: 5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                  color: ColorConstants.color_FFE5E5E5,
                                  width: 1),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                        flex: 3,
                                        child: Text(
                                          '${AppStrings.storeName}:',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )),
                                    Expanded(
                                        flex: 7,
                                        child: Text(
                                          '${filteredList[index].storeName}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                        flex: 3,
                                        child: Text(
                                          '${AppStrings.distance}:',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )),
                                    Expanded(
                                        flex: 7,
                                        child: Row(
                                          children: [
                                            Text(
                                              '${getDistanceValue(filteredList[index].distance!)} ',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Expanded(
                                                child: FutureBuilder(
                                              initialData: 2,
                                              future: getVisitDetails(
                                                  filteredList[index].storeId!),
                                              builder: (BuildContext ctx,
                                                  AsyncSnapshot<int> pos) {
                                                return Text(
                                                  '\u25CF ${visitTypes[pos.data!]}',
                                                  style: TextStyle(
                                                      color: visitColors[
                                                          pos.data!],
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                );
                                              },
                                            )),
                                          ],
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: Icon(
                                          Icons.call_outlined,
                                          color: ColorConstants.colorPrimary,
                                          size: 24,
                                        ),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              CircleBorder()),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.all(5)),
                                          backgroundColor: MaterialStateProperty
                                              .all(ColorConstants
                                                  .color_ECE6F6_FF), // <-- Button color
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            AppStrings.noOrder,
                                            style: TextStyle(
                                                color:
                                                    ColorConstants.colorPrimary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorConstants.color_ECE6F6_FF,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20), // <-- Radius
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            AppStrings.bookOrder,
                                            style: TextStyle(
                                                color:
                                                    ColorConstants.colorPrimary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorConstants.color_ECE6F6_FF,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20), // <-- Radius
                                            ),
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            AppUtils.showBottomDialog(
                                context,
                                true,
                                false,
                                Colors.white,
                                StoreOptionsDialog(store: filteredList[index]));
                          },
                        );
                      },
                    ))
                  : MapStoresComponent(
                      location: location!, stores: filteredList)
              : Expanded(
                  child: Center(
                  child: CircularProgressIndicator(),
                ))
        ],
      ),
    );
  }

  void getDate(String date) {
    print(date);
    setState(() {
      todayDate = date;
    });
  }

  @override
  void dispose() {
    if (positionStream != null) {
      positionStream!.cancel();
    }
    super.dispose();
  }

  List<UserHierarchyLocation>? parseLocations(String? locations) {
    if (locations != null) {
      List<dynamic> parsedListJson = jsonDecode(locations);
      return List<UserHierarchyLocation>.from(
          parsedListJson.map<UserHierarchyLocation>(
              (dynamic i) => UserHierarchyLocation.fromJson(i)));
    }
    return [];
  }

  List<UserHierarchySalesmanDistributor>? parseDistributors(
      String? distributors) {
    if (distributors != null) {
      List<dynamic> parsedListJson = jsonDecode(distributors);
      return List<UserHierarchySalesmanDistributor>.from(
          parsedListJson.map<UserHierarchySalesmanDistributor>(
              (dynamic i) => UserHierarchySalesmanDistributor.fromJson(i)));
    }
    return [];
  }

  List<UserHierarchyBeat>? parseBeats(String? beats) {
    if (beats != null) {
      List<dynamic> parsedListJson = jsonDecode(beats);
      return List<UserHierarchyBeat>.from(parsedListJson.map<UserHierarchyBeat>(
          (dynamic i) => UserHierarchyBeat.fromJson(i)));
    }
    return [];
  }

  void applyFilter(
      int selectedUser, List<UserHierarchyBeat> available, List<UserHierarchyBeat> selected, String todayDate) {
    setState(() {
      this.selectedUser = selectedUser;
      todayBeatNames = selected.map((e) => e.name!).toList();
      selectedBeats = selected;
      availableBeats = available;
      this.todayDate = todayDate;
    });

    if (selectedUser == AppUtils.getSalesman(prefs!)) {
      getStores();
    } else {
      setRefreshClick();
    }
  }

  Future<bool> storesAvailable() async {
    var result = await instance.execQuery(
        'SELECT COUNT(*) AS cnt FROM ${instance.storeDataDetail} WHERE ${StoresDataDetailFields.salesmanId} = $selectedUser');
    return result[0]['cnt'] > 0;
  }
}

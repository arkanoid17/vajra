import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/store_types_data_detail/store_types_data_detail.dart';
import 'package:vajra/db/stores_data_detail/stores_data_detail.dart';
import 'package:vajra/db/user_hierarchy_data_detail/user_hierarchy_data_detail.dart';
import 'package:vajra/models/user_hierarchy/hierarchy_beat_calendar.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy_beat.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy_location.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy_salesman_distributors.dart';
import 'package:vajra/models/user_selector/user_selector.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/utils/app_utils.dart';

class StoreListing extends StatefulWidget {
  const StoreListing({super.key});

  @override
  State<StatefulWidget> createState() => _StoreListing();
}

class _StoreListing extends State<StoreListing> {
  List<String> todayBeatNames = [];
  List<UserHierarchyDataDetail> allUsers = [];
  List<UserSelector> listUser = [];
  List<UserHierarchyBeat> selectedBeats = [];

  Position? location;
  StreamSubscription<Position>? positionStream;

  List<StoreTypesDataDetail> listStoreTypes = [];

  SharedPreferences? prefs;

  String todayDate = '';
  int selectedUser = 0;

  late DatabaseHelper instance;

  List<StoresDataDetail> stores = [];

  void getLocation() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: AppUtils.getDistanceLocationUpdate(prefs!),
    );
    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null) {
        setState(() {
          location = position;
        });
      }
    });
  }

  void setTodayDate() {
    setState(() {
      todayDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    });
  }

  void getStoreTypes() {
    List<StoreTypesDataDetail> details = [];
    instance
        .execQuery('SELECT * FROM ${instance.storeTypesDataDetail}')
        .then((value) => {
              for (var element in value)
                {
                  details.add(StoreTypesDataDetail(
                      element[StoreTypesDataDetailFields.id],
                      element[StoreTypesDataDetailFields.name])),
                }
            });

    setState(() {
      listStoreTypes = details.isNotEmpty ? details : [];
    });
  }

  void getAllUsers() {
    List<UserHierarchyDataDetail> details = [];
    instance
        .execQuery(
            'SELECT * FROM ${instance.tableUserHierarchyDataDetail} WHERE ${UserHierarchyDataDetailFields.isActive}=1')
        .then((value) => {
              for (var element in value)
                {
                  details.add(UserHierarchyDataDetail(
                      element[UserHierarchyDataDetailFields.serverId],
                      element[UserHierarchyDataDetailFields.employName],
                      element[UserHierarchyDataDetailFields.employId],
                      element[UserHierarchyDataDetailFields.locations],
                      element[
                          UserHierarchyDataDetailFields.salesmanDistributors],
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
                      element[UserHierarchyDataDetailFields.isGeoRestricted] ==
                          1,
                      element[UserHierarchyDataDetailFields.place],
                      element[UserHierarchyDataDetailFields.role],
                      element[UserHierarchyDataDetailFields.manager],
                      element[UserHierarchyDataDetailFields.createdBy],
                      element[UserHierarchyDataDetailFields.updatedBy])),
                },
              setState(() {
                allUsers = details.isNotEmpty ? details : [];
              }),
              fetchUsersInSelector(),
            });
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
            null);
        selectors.add(selector);
      }

      setState(() {
        listUser = selectors.isNotEmpty ? selectors : [];
      });
      selectUserTodayBeat();
    }
  }

  void selectUserTodayBeat() {
    List<UserHierarchyBeat> beats = [];
    for (UserSelector user in listUser) {
      if (user.id == AppUtils.getSalesman(prefs!)) {
        beats.addAll(user.beats != null ? user.beats! : []);
      }
    }
    if (beats.isNotEmpty) {
      int wk = AppUtils.weekOfTheMonth();
      String dayOfWeek = AppUtils.dayOfTheWeek();

      print('week - $wk  day - $dayOfWeek');

      List<UserHierarchyBeat> todayBeats = [];
      for (UserHierarchyBeat beat in beats) {
        if(beat.calendar!=null && beat.calendar!.isNotEmpty){
          for (HierarchyBeatCalendar calendar in beat.calendar!) {
            if (calendar.dayName == dayOfWeek && calendar.weekNo == wk) {
              todayBeats.add(beat);
              break;
            }
          }
        }
      }

      if(todayBeats.isNotEmpty){
        setState(() {
          selectedBeats = todayBeats;
        });

      }

    }
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
            }),
            getLocation(),
            selectedUser = AppUtils.getSalesman(value),
          });
    }

    getStoreTypes();

    getAllUsers();

    super.initState();
  }

  String getBeatNames(){
    var names = '';
    for(UserHierarchyBeat name in selectedBeats){
      names += '${name.name} ,';
    }

    names = names.substring(0,names.length-1);
    
    return names;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(getBeatNames()),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          location == null
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

          Padding(padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),child: Text('${AppStrings.showingResults} : ${stores.length}',style: const TextStyle(fontSize: 14,color: Colors.grey),),),



        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
}

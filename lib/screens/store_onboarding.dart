import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/utils/app_utils.dart';

import '../models/nearby_stores_data/nearby_stores_response.dart';
import '../models/user_data/user_data.dart';
import '../services/APIServices.dart';

class StoreOnboarding extends StatefulWidget {
  const StoreOnboarding({super.key});

  @override
  State<StatefulWidget> createState() => _StoreOnboarding();
}

class _StoreOnboarding extends State<StoreOnboarding> {
  late Position location;
  late SharedPreferences prefs;
  StreamSubscription<Position>? positionStream;
  bool isFetchingLocation = true;

  bool isFetchingStores = true;
  List<NearbyStoresResponse> stores = [];
  List<NearbyStoresResponse> filteredStores = [];

  bool isSearching = false;

  @override
  void initState() {
    AppUtils.getPrefs().then((value) => {
          setState(() {
            prefs = value;
          }),
          getLocation()
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching?TextField(
          style: TextStyle(color: Colors.white, fontSize: 16),
          onChanged: (text) {
            setState(() {
              filteredStores = text.isNotEmpty
                  ? stores
                  .where((element) => element.name!
                  .toLowerCase()
                  .contains(text.trim().toLowerCase()))
                  .toList()
                  : stores;
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: AppStrings.search,
            hintStyle: TextStyle(
                color: Colors.white.withAlpha(120), fontSize: 16),
          ),
        ):const Text(AppStrings.nearbyStores),
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
                      filteredStores = stores;
                    });
                  }
                  isSearching = !isSearching;
                });
              },
              icon: isSearching ? Icon(Icons.cancel) : Icon((Icons.search)))
        ],
      ),
      body: isFetchingLocation
          ? Center(
              child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                Text(
                  AppStrings.pleaseWaitWhileWeFetchLocation,
                  style: TextStyle(
                      color: ColorConstants.colorPrimary, fontSize: 14),
                ),
                CircularProgressIndicator()
              ],
            ))
          : isFetchingStores
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: filteredStores.length,
                              itemBuilder: (BuildContext ctx, int index) {
                                return Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Card(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: ColorConstants
                                                  .color_ECE6F6_FF,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                            ),
                                            width: double.infinity,
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              filteredStores[index].name!,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .colorPrimary,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: ColorConstants
                                                        .color_ECE6F6_FF,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                  ),
                                                  child: Image.network(
                                                    filteredStores[index]
                                                        .images!
                                                        .outerImage!,
                                                    width: 120,
                                                    height: 110,
                                                    fit: BoxFit.fill,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Icon(
                                                          Icons.store,
                                                          color: ColorConstants
                                                              .colorPrimary,
                                                          size: 100,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                    child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                '${AppStrings.owner}: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )),
                                                          Expanded(
                                                              flex: 7,
                                                              child: Text(
                                                                  filteredStores[index]
                                                                              .ownerName !=
                                                                          null
                                                                      ? filteredStores[
                                                                              index]
                                                                          .ownerName!
                                                                      : '',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip)),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                '${AppStrings.number}: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )),
                                                          Expanded(
                                                              flex: 7,
                                                              child: Text(
                                                                  filteredStores[index]
                                                                              .contactNo !=
                                                                          null
                                                                      ? filteredStores[
                                                                              index]
                                                                          .contactNo!
                                                                      : '',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip)),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                '${AppStrings.distance}: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )),
                                                          Expanded(
                                                              flex: 7,
                                                              child: Text(
                                                                  filteredStores[index]
                                                                              .distance !=
                                                                          null
                                                                      ? '${filteredStores[index].distance!} m'
                                                                      : '',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip)),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Container(
                                                            height: 25,
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {},
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          ColorConstants
                                                                              .color_ECE6F6_FF,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20), // <-- Radius
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      AppStrings
                                                                          .addToMyBeats,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              ColorConstants.colorPrimary),
                                                                    )),
                                                          ))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context,
                                        '/dynamic-actions',
                                        arguments: {
                                          'action_id': getOnBoardProcessId()
                                        }
                                    );
                                  },
                                  child: Text(AppStrings.addNewStore.toUpperCase())))
                        ],
                      )
                    ],
                  ),
                ),
    );
  }

  void getLocation() async {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: AppUtils.getDistanceLocationUpdate(prefs),
      timeLimit: Duration(seconds: AppUtils.getTimeLocationUpdate(prefs)),
    );
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null) {
        setState(() {
          isFetchingLocation = false;
          location = position;
        });
        fetchNearbyStores();
        if (positionStream != null) {
          positionStream!.cancel();
        }
      }
    });
  }

  void fetchNearbyStores() async {
    int limit = 0;
    int radius = 0;

    UserData? user = AppUtils.getUserData(prefs);

    if (user != null) {
      if (user.settings != null &&
          user.settings!.near_by_stores_limit != null) {
        limit = user.settings!.near_by_stores_limit!;
      }
      if (user.settings != null &&
          user.settings!.near_by_stores_radius != null) {
        radius = user.settings!.near_by_stores_radius!;
      }
    }

    //todo uncomment this before run
    // double latitude = location.latitude;
    // double longitude = location.longitude;

    double latitude = 17.4418632;
    double longitude = 78.3970516;

    String url =
        '${AppUtils.baseUrl}${APIServices.getNearbyStoresService(latitude, longitude, limit, radius)}';

    var headers = AppUtils.headers(
        prefs.getString('tenant_id') != null
            ? prefs.getString('tenant_id')!
            : '',
        prefs.getString('token') != null ? prefs.getString('token')! : '');

    var nearByStores = await AppUtils.requestBuilder(url, headers);

    try {
      if (nearByStores.statusCode == 200) {
        updateNearbyStoreList(nearByStores.body);
        setState(() {
          isFetchingStores = false;
        });
      }
    } catch (e) {
      AppUtils.showMessage(e.toString());
      setState(() {
        isFetchingStores = false;
      });
    }
  }

  void updateNearbyStoreList(String? body) {
    if (body != null) {
      List<dynamic> parsedListJson = jsonDecode(body);
      List<NearbyStoresResponse> nearby = List<NearbyStoresResponse>.from(
          parsedListJson.map<NearbyStoresResponse>(
              (dynamic i) => NearbyStoresResponse.fromJson(i)));

      if (nearby.isEmpty) {
        AppUtils.showMessage(AppStrings.noNearbyStores);
      }

      setState(() {
        stores = nearby;
        filteredStores = nearby;
      });
    }
  }

  getOnBoardProcessId() {
    int id = 0;
    UserData? user =  AppUtils.getUserData(prefs);
    if(user!=null && user.settings!=null && user.settings!.onBoardAction!=null){
      id = user.settings!.onBoardAction!;
    }
    return id;
  }
}

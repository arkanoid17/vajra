import 'dart:convert';

import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/components/bar_chart_component.dart';
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/user_stats_data_detail/user_stats_data_detail.dart';
import 'package:vajra/dialogs/date_dropdown.dart';
import 'package:vajra/dialogs/popup_menu.dart';
import 'package:vajra/models/sales_history_data/sales_history.dart';
import 'package:vajra/models/user_data/user_data.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy_location.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/services/APIServices.dart';
import 'package:vajra/utils/app_utils.dart';
import 'package:vajra/utils/sync_handler.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SharedPreferences? prefs;
  late DatabaseHelper instance;

  List<UserHierarchyLocation> locations = [];
  List<String> locationNames = [];
  String? locationValue;

  TextEditingController locationController = TextEditingController();

  bool isSyncing = false;
  var percentage = 0.0;

  var todayBills = 0;
  var thisMonthBills = 0;
  var pendingSyncBills = 0;

  var todayNoBills = 0;
  var thisMonthNoBills = 0;
  var pendingSyncNoBills = 0;

  var todayNrv = 0.0;
  var thisMonthNrv = 0.0;
  var pendingSyncNrv = 0.0;

  var chartDateText = AppStrings.today;
  var fromDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var toDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  var chartView = AppStrings.billed;

  String series = 'daily';
  String salesman = '';
  String includeFields1 = "total_nrv";
  String includeFields2 = "total_ptr";
  String includeFields3 = "orders";

  Map<String, String> headers = {};

  List<SalesHistoryData> listSalesHistory = [];

  void showLogoutDialog() {}

  void setLocations() {
    UserData? user = AppUtils.getUserData(prefs!);
    if (user != null && user.locations != null) {
      if (user.locations!.isNotEmpty) {
        setState(() {
          locations.clear();
          locations.addAll(user.locations!);
          locationNames.clear();
        });
        for (UserHierarchyLocation location in user.locations!) {
          setState(() {
            locationNames.add(location.name!);
          });
        }

        if (prefs!.containsKey('selected_place_id')) {
          int selectedPlaceId = prefs!.getInt('selected_place_id')!;

          for (UserHierarchyLocation location in user.locations!) {
            if (location.id == selectedPlaceId) {
              setState(() {
                locationValue = location.name;
                locationController =
                    TextEditingController(text: location.name!);
              });
            }
          }
        } else {
          if (user.locations!.isNotEmpty) {
            setState(() {
              locationValue = user.locations![0].name!;
              locationController =
                  TextEditingController(text: user.locations![0].name!);
            });
          }
        }
      }
    }
  }

  void onLocationChange(String name) {
    int x = -1;
    for (String lName in locationNames) {
      ++x;
      if (lName == name) {
        var id = locations[x].id!;
        prefs!.setInt('selected_place_id', id);
        setLocations();
        break;
      }
    }
  }

  void setRegisters(String key) {
    FBroadcast.instance().register(key, (value, callback) {
      switch (key) {
        case AppStrings.key_start:
          AppUtils.showMessage(AppStrings.syncStarted);
          setSyncing(true);
          setState(() {
            percentage = 0.0;
          });
          break;
        case AppStrings.key_set_places:
          setLocations();
          break;
        case AppStrings.key_success:
          setSyncing(false);
          AppUtils.showMessage(AppStrings.dataRetrievalSuccess);
          break;
        case AppStrings.key_failure:
          setSyncing(false);
          AppUtils.showMessage(AppStrings.dataRetrievalSuccess);
          break;
        case AppStrings.key_sync_progress:
          setState(() {
            percentage = value;
          });
          break;
        case AppStrings.key_set_chart:
          fetchChartData();
          break;
      }
    }, context: this);
  }

  void setSyncing(bool val) {
    setState(() {
      isSyncing = val;
    });
  }

  void getUserStats() {
    instance
        .execQuery('SELECT * FROM ${instance.userStatsDataDetail}')
        .then((value) => {
              for (var element in value)
                {
                  setState(() {
                    thisMonthNrv = element[UserStatsDataDetailFields.monthNrv];
                    todayNrv = element[UserStatsDataDetailFields.todayNrv];
                    thisMonthBills =
                        element[UserStatsDataDetailFields.monthBilled];
                    thisMonthNoBills =
                        element[UserStatsDataDetailFields.monthUnbilled];
                    todayBills = element[UserStatsDataDetailFields.todayBilled];
                    todayNoBills =
                        element[UserStatsDataDetailFields.todayUnbilled];
                  })
                }
            });
  }

  void onDateSelected(String item, String fromDate, String toDate) {
    setState(() {
      chartDateText = item;
      this.fromDate = fromDate;
      this.toDate = toDate;
    });
  }

  TextStyle getTabTextStyle(String item) {
    return item == chartView
        ? TextStyle(
            color: ColorConstants.colorPrimary.withOpacity(1),
            fontSize: 16,
            fontWeight: FontWeight.w600)
        : TextStyle(
            color: ColorConstants.colorPrimary.withOpacity(0.3),
            fontSize: 16,
            fontWeight: FontWeight.w400);
  }

  @override
  void initState() {
    instance = DatabaseHelper.instance;

    setRegisters(AppStrings.key_start);
    setRegisters(AppStrings.key_set_places);
    setRegisters(AppStrings.key_sync_progress);
    setRegisters(AppStrings.key_success);
    setRegisters(AppStrings.key_failure);
    setRegisters(AppStrings.key_set_chart);

    if (prefs == null) {
      AppUtils.getPrefs().then((value) => {
            setState(() {
              prefs = value;
            }),
            setLocations(),
            SyncHandler(context, value, instance).startSync(),
            setState(() {
              salesman = value.getString('user_id')!;
              headers = AppUtils.headers(
                  value.getString('tenant_id') != null
                      ? value.getString('tenant_id')!
                      : '',
                  value.getString('token') != null
                      ? value.getString('token')!
                      : '');
            }),
            fetchChartData()
          });
    }

    getUserStats();

    super.initState();
  }

  void fetchChartData() async {
    var salesHistoryService = await AppUtils.requestBuilder(
        AppUtils.baseUrl +
            APIServices.getSalesHistoryService(series, fromDate, toDate,
                salesman, includeFields1, includeFields2, includeFields3),
        headers);
    try {
      if (salesHistoryService.statusCode == 200) {
        handleSalesHistoryData(salesHistoryService.body);
      }
    } catch (e) {
      AppUtils.showMessage('salesHistoryService error - ${e.toString()}');
    }
  }

  void handleSalesHistoryData(String? body) {
    if (body != null && body.isNotEmpty) {
      List<dynamic> parsedListJson = jsonDecode(body);
      if (mounted) { // check whether the state object is in tree
        setState(() {
          listSalesHistory = List<SalesHistoryData>.from(
              parsedListJson.map<SalesHistoryData>(
                      (dynamic i) => SalesHistoryData.fromJson(i)));
        });
      }
    }
  }

  void setChartViewState(String value) {
    setState(() {
      chartView = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return prefs != null
        ? Scaffold(
            key: _scaffoldKey,
            drawer: getDrawer(),
            body: Container(
              color: Colors.white,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Image.asset('assets/images/bg_dashboard_header.jpg',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 32.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () =>
                                    _scaffoldKey.currentState!.openDrawer(),
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                                height: 1,
                              ),
                              locations.isNotEmpty
                                  ? Container(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          top: 5,
                                          right: 15,
                                          bottom: 5),
                                      child: PopupMenuDialog(
                                        names: locationNames,
                                        selected: locationValue!,
                                        onLocationChanged: onLocationChange,
                                      ),
                                      decoration: const BoxDecoration(
                                          color: ColorConstants.color_ECE6F6_20,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                    )
                                  : Container(),
                              Flexible(
                                fit: FlexFit.tight,
                                child: const SizedBox(
                                  width: 15,
                                  height: 1,
                                ),
                              ),
                              isSyncing
                                  ? CircularPercentIndicator(
                                      radius: 18.0,
                                      lineWidth: 3.0,
                                      percent: (percentage / 100),
                                      center: Text(
                                        '${percentage.toInt()}%',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                      progressColor: Colors.white,
                                    )
                                  : Container(),
                              const SizedBox(
                                width: 15,
                                height: 1,
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              const SizedBox(
                                width: 1,
                                height: 40,
                              ),
                              Row(
                                children: [
                                  Transform.translate(
                                    offset: const Offset(-25, 0),
                                    child: Image.asset(
                                        'assets/images/ic_hello_message.png'),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        AppStrings.welcomeToApplication,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                        height: 12,
                                      ),
                                      Text(
                                        getName(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                        height: 5,
                                      ),
                                      Text(
                                        getUserId(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 1,
                                height: 60,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 192,
                                      height: 236,
                                      margin: const EdgeInsets.only(left: 16),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/ic_bg_bill_stats.png"),
                                            fit: BoxFit.cover),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Center(
                                              child: Text(
                                                AppStrings.bills,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Center(
                                                child: Column(
                                              children: [
                                                Text(
                                                  '$todayBills',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  AppStrings.today,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Center(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '$thisMonthBills',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const Text(
                                                        AppStrings.thisMonth,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Center(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '$pendingSyncBills',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const Text(
                                                        AppStrings
                                                            .pendingToSync,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 192,
                                      height: 236,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/ic_bg_no_bill_stats.png"),
                                            fit: BoxFit.cover),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Center(
                                              child: Text(
                                                AppStrings.noBills,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Center(
                                                child: Column(
                                              children: [
                                                Text(
                                                  '$todayNoBills',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  AppStrings.today,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Center(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '$thisMonthNoBills',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const Text(
                                                        AppStrings.thisMonth,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Center(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '$pendingSyncNoBills',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const Text(
                                                        AppStrings
                                                            .pendingToSync,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 192,
                                      height: 236,
                                      margin: const EdgeInsets.only(right: 16),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/ic_bg_nrv_stats.png"),
                                            fit: BoxFit.cover),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Center(
                                              child: Text(
                                                AppStrings.nrv,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Center(
                                                child: Column(
                                              children: [
                                                Text(
                                                  '$todayNrv',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  AppStrings.today,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Center(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '$thisMonthNrv',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const Text(
                                                        AppStrings.thisMonth,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Center(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '$pendingSyncNrv',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const Text(
                                                        AppStrings
                                                            .pendingToSync,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 1,
                                height: 60,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: Card(
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                AppStrings.performance,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                                height: 1,
                                              ),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: GestureDetector(
                                                  onTap: () => {
                                                    AppUtils.showBottomDialog(
                                                        context,
                                                        true,
                                                        true,
                                                        Colors.white,
                                                        DateDropDown(
                                                          selected:
                                                              chartDateText,
                                                          prefs: prefs!,
                                                          onDateSelected:
                                                              onDateSelected,
                                                        ))
                                                  },
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                        color: ColorConstants
                                                            .color_ECE6F6_64,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              top: 10,
                                                              right: 15,
                                                              bottom: 10),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                              'assets/images/ic_calendar_primary.png'),
                                                          const SizedBox(
                                                            width: 10,
                                                            height: 1,
                                                          ),
                                                          Flexible(
                                                              fit:
                                                                  FlexFit.tight,
                                                              child: Text(
                                                                '$chartDateText',
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .colorPrimary,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )),
                                                          const Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: ColorConstants
                                                                .colorPrimary,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () => {
                                                  setChartViewState(
                                                      AppStrings.billed)
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(AppStrings.billed,
                                                        style: getTabTextStyle(
                                                            AppStrings.billed)),
                                                    const SizedBox(height: 5),
                                                    AppStrings.billed ==
                                                            chartView
                                                        ? Container(
                                                            height: 4,
                                                            width: 40,
                                                            decoration: const BoxDecoration(
                                                                color: ColorConstants
                                                                    .color_FF95CA4),
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => {
                                                  setChartViewState(
                                                      AppStrings.ptr)
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(AppStrings.ptr,
                                                        style: getTabTextStyle(
                                                            AppStrings.ptr)),
                                                    const SizedBox(height: 5),
                                                    AppStrings.ptr == chartView
                                                        ? Container(
                                                            height: 4,
                                                            width: 40,
                                                            decoration: const BoxDecoration(
                                                                color: ColorConstants
                                                                    .color_FF95CA4),
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => {
                                                  setChartViewState(
                                                      AppStrings.nrv)
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(AppStrings.nrv,
                                                        style: getTabTextStyle(
                                                            AppStrings.nrv)),
                                                    const SizedBox(height: 5),
                                                    AppStrings.nrv == chartView
                                                        ? Container(
                                                            height: 4,
                                                            width: 40,
                                                            decoration: const BoxDecoration(
                                                                color: ColorConstants
                                                                    .color_FF95CA4),
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 300,
                                            child: BarChartComponent(
                                                listSalesHistory:
                                                    listSalesHistory,
                                                chartView: chartView),
                                          )
                                        ],
                                      ),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(
              color: ColorConstants.colorPrimary,
            ),
          );
  }

  String getFirstLetter() {
    String name =
        prefs!.getString('name') != null ? prefs!.getString('name')! : '';
    return name != '' ? name[0] : '';
  }

  Widget getDrawer() {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: ColorConstants.colorPrimary,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Center(
                    child: Text(
                      getFirstLetter(),
                      style: const TextStyle(
                          color: ColorConstants.colorPrimary, fontSize: 35),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  prefs!.getString('name') != null
                      ? prefs!.getString('name')!
                      : '',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  prefs!.getString('user_id') != null
                      ? prefs!.getString('user_id')!
                      : '',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 1,
          height: 40,
        ),
        ListTile(
          dense: true,
          leading: Image.asset("assets/images/ic_menu_pending_activities.jpg"),
          title: const Text(
            AppStrings.pendingActivities,
            style: TextStyle(fontSize: 12, color: ColorConstants.colorPrimary),
          ),
          onTap: () => {closeDrawer(AppStrings.pendingActivities)},
        ),
        ListTile(
          dense: true,
          leading: Image.asset("assets/images/ic_menu_order_history.jpg"),
          title: const Text(
            AppStrings.orderHistory,
            style: TextStyle(fontSize: 12, color: ColorConstants.colorPrimary),
          ),
          onTap: () => {closeDrawer(AppStrings.orderHistory)},
        ),
        ListTile(
          dense: true,
          leading: Image.asset("assets/images/ic_menu_my_report.jpg"),
          title: const Text(
            AppStrings.myReport,
            style: TextStyle(fontSize: 12, color: ColorConstants.colorPrimary),
          ),
          onTap: () => {closeDrawer(AppStrings.myReport)},
        ),
        ListTile(
          dense: true,
          leading: Image.asset("assets/images/ic_menu_onboarding.jpg"),
          title: const Text(
            AppStrings.onboardStore,
            style: TextStyle(fontSize: 12, color: ColorConstants.colorPrimary),
          ),
          onTap: () => {closeDrawer(AppStrings.onboardStore)},
        ),
        ListTile(
          dense: true,
          leading: Image.asset("assets/images/ic_menu_actions.jpg"),
          title: const Text(
            AppStrings.actions,
            style: TextStyle(fontSize: 12, color: ColorConstants.colorPrimary),
          ),
          onTap: () => {closeDrawer(AppStrings.actions)},
        ),
        ListTile(
          dense: true,
          leading: Image.asset("assets/images/ic_menu_share_back_up.jpg"),
          title: const Text(
            AppStrings.shareBackup,
            style: TextStyle(fontSize: 12, color: ColorConstants.colorPrimary),
          ),
          onTap: () => {closeDrawer(AppStrings.shareBackup)},
        ),
        ListTile(
          dense: true,
          leading: Image.asset("assets/images/ic_sync.png"),
          title: const Text(
            AppStrings.syncData,
            style: TextStyle(fontSize: 12, color: ColorConstants.colorPrimary),
          ),
          onTap: () => {closeDrawer(AppStrings.syncData)},
        ),
        ListTile(
          dense: true,
          leading: Image.asset("assets/images/ic_menu_app_info.jpg"),
          title: const Text(
            AppStrings.appInfo,
            style: TextStyle(fontSize: 12, color: ColorConstants.colorPrimary),
          ),
          onTap: () => {closeDrawer(AppStrings.appInfo)},
        ),
        ListTile(
          dense: true,
          leading: Image.asset("assets/images/ic_menu_logout.jpg"),
          title: const Text(
            AppStrings.logout,
            style: TextStyle(fontSize: 12, color: ColorConstants.colorPrimary),
          ),
          onTap: () => {closeDrawer(AppStrings.logout)},
        )
      ],
    ));
  }

  closeDrawer(String name) {
    Navigator.pop(context);
    switch (name) {
      case AppStrings.logout:
        prefs!.clear();
        instance.deleteDatabase();
        Navigator.pushReplacementNamed(context, '/login');
        break;
      case AppStrings.syncData:
        SyncHandler(context, prefs!, instance).startSync();
        break;
    }
  }

  String getName() {
    return prefs!.getString('name') != null ? prefs!.getString('name')! : '';
  }

  String getUserId() {
    return prefs!.getString('user_id') != null
        ? prefs!.getString('user_id')!
        : '';
  }
}

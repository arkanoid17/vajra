import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/distributor_data_detail/distributor_data_detail.dart';
import 'package:vajra/db/product_data_detail/product_data_detail.dart';
import 'package:vajra/db/product_distributor_type_data_detail/product_distributor_type_data_detail.dart';
import 'package:vajra/db/stores_data_detail/stores_data_detail.dart';
import 'package:vajra/models/user_data/user_data.dart';
import 'package:vajra/dialogs/user_selection_diaalog.dart';
import 'package:vajra/models/user_hierarchy/distributor_types.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy.dart';
import 'package:vajra/services/navigation_service.dart';

import '../db/schemes_data_detail/schemes_data_detail.dart';
import '../db/user_hierarchy_data_detail/user_hierarchy_data_detail.dart';
import '../models/login/user_permissions.dart';
import '../models/product/pack.dart';
import '../models/user_data/user_group.dart';
import '../resource_helper/strings.dart';

class AppUtils {
  static const int splashTimeout = 3 * 1000; //3000 milisecond is 3 seconds

  static const String version = "2.30";

  static bool isSyncGoingOn = false;

  static int syncInterval = 2;

  static int db_version = 1;

  static String imageFiles = "images";
  static String webFiles = "web_files";
  static String report = "report_files";

  static int location_update_min_distance = 5;
  static int min_time_location_update = 5;

  static void showMessage(var message){
    var snackbar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!).showSnackBar(snackbar);
  }

  static const String PROD_URL = "https://api.glenmark.adjoint.in/";
  static const String DEV_URL = "https://dev.glenmark.adjoint.in/";
  static const String LOCAL_URL = "http://192.168.55.106:8000/";

  // static const String baseUrl = PROD_URL;
  // static const String baseUrl = LOCAL_URL;
  static const String baseUrl = DEV_URL;

  static const String sh_pref = 'Vajra';

  static showBottomDialog(BuildContext context,bool isDismissable,bool isScrollControlled, Color backgroundColor,view){
    showModalBottomSheet(
        context: context,

        isDismissible: isDismissable,
        isScrollControlled: isScrollControlled,
        backgroundColor: backgroundColor,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (ctx) {
          return view;
        });
  }
  
  static showDialog(BuildContext context,Widget widget){
    showGeneralDialog(
      context: context,
      pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          ) {
        return widget;
      },
    );
  }

  static Map<String,String> headers(String tenantId,String token){
    Map<String,String> headers = {};
    if(tenantId!=""){
      headers['tenant-id'] = tenantId;
    }
    if(token!=""){
      headers['Authorization'] = "Token $token";
    }
    headers["APP-VERSION"] = version;
    headers["CLIENT"] = "ANDROID";
    return headers;
  }

  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  static Future<SharedPreferences> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<Response> requestBuilder(String url,Map<String,String> headers) {
    return  http.get(Uri.parse(url),headers: headers).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          return http.Response('Error', 408); // Request Timeout response status code
        });
  }

  static UserData? getUserData(SharedPreferences prefs){
    String? user = prefs.getString('user_data');
    try{
      return UserData.fromJson(jsonDecode(user!));
    }catch(e){
      showMessage(e.toString());
    }
    return null;
  }

  static void writeResponseToDisk(String content,String folderName,String name,String ext) async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/$folderName';
    directory = Directory(path);
    if(!await directory.exists()){
      directory.create();
    }

    print(content);

    final File file = File('${directory.path}/$name.$ext');
    await file.writeAsString(content);
  }

  static int getSalesman(SharedPreferences pref){
    if(pref.containsKey('server_id')){
      return pref.getInt('server_id')!;
    }
    return 0;
  }

  static String getFyDate(SharedPreferences prefs){
    UserData? user = getUserData(prefs);
    if(user!=null && user.settings!=null && user.settings!.fyDate!=null && user.settings!.fyDate!.isNotEmpty){
      DateFormat format = DateFormat('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
      return DateFormat('yyyy-MM-dd').format(format.parse(user.settings!.fyDate!).toUtc());
    }
    return '';
  }

  static int getDistanceLocationUpdate(SharedPreferences prefs){
    UserData? user = getUserData(prefs);
    if (user!=null && user.settings!=null){
      if (user.settings!.min_distance_location_update!=null ){
        return user.settings!.min_distance_location_update!;
      }
    }
    return location_update_min_distance;
  }

  static int getTimeLocationUpdate(SharedPreferences prefs){
    UserData? user = getUserData(prefs);
    if (user!=null && user.settings!=null){
      if (user.settings!.min_time_location_update!=null ){
        return user.settings!.min_time_location_update!;
      }
    }
    return min_time_location_update;
  }


  static String dayOfTheWeek(DateTime dateSelected){
    const Map<int, String> weekdayName = {1: "MONDAY", 2: "TUESDAY", 3: "WEDNESDAY", 4: "THURSDAY", 5: "FRIDAY", 6: "SATURDAY", 7: "SUNDAY"};
    return weekdayName[dateSelected.weekday]!;
  }

  static int weekOfTheMonth(DateTime dateSelected) {
    String date = dateSelected.toString();

// This will generate the time and date for first day of month
    String firstDay = date.substring(0, 8) + '01' + date.substring(10);

// week day for the first day of the month
    int weekDay = DateTime.parse(firstDay).weekday;

    DateTime testDate = DateTime.now();

    int weekOfMonth;

//  If your calender starts from Monday
    weekDay--;
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    print('Week of the month: $weekOfMonth');
    weekDay++;

// If your calender starts from sunday
    if (weekDay == 7) {
      weekDay = 0;
    }
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    print('Week of the month: $weekOfMonth');
    return weekOfMonth;
  }


  static String getDistance(double p1,double p2,double q1,double q2){
    return Geolocator.distanceBetween(p1, p2, q1, q2).toStringAsFixed(2);
  }

  static Future<void> showDatePickerDialog(BuildContext context,String selectedDate,Function getDate) async{
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateFormat('dd/MM/yyyy').parse(selectedDate),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      getDate(DateFormat('dd/MM/yyyy').format(picked));
    }
  }

  static Future<int> getGeoFenceEval(StoresDataDetail store,SharedPreferences prefs, Position location) async{
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if(isLocationEnabled){
      bool storeHasLocation = (store.storeLatitude!=null && store.storeLatitude!.isNotEmpty) && (store.storeLatitude!=null && store.storeLatitude!.isNotEmpty);
      if(storeHasLocation){
        var clientAccuracy = AppUtils.getUserData(prefs)!.settings!.gpsAccuracy;
        var clientGeoRadius = getGeoRadius(prefs);
        var clientGeofenceOn = AppUtils.getUserData(prefs)!.isGeoRestricted;

        if(validLocation(AppUtils.getDistance(double.parse(
            store.storeLatitude != null ? store.storeLatitude! : '0.0'),
            double.parse(
                store.storeLongitude != null ? store.storeLongitude! : '0.0'),
            location.latitude,
            location.longitude
        ),
            clientGeoRadius
        )){
          if(location.accuracy<=double.parse(clientAccuracy!)){
            return 3;
          }else{
            if(clientGeofenceOn!){
              return 4;
            }else{
              return 2;
            }
          }
        }else{
          if(clientGeofenceOn!){
            return 4;
          }else{
            return 2;
          }
        }
      }else{
        return 2;
      }
    }else{
      return 1;
    }

  }

  static  bool validLocation(String distance,String clientGeoRadius){
    return double.parse(distance)<=int.parse(clientGeoRadius);
  }

  static String getGeoRadius(SharedPreferences prefs){
    return AppUtils.getUserData(prefs)!.settings!.geoFenceRadius!=null?AppUtils.getUserData(prefs)!.settings!.geoFenceRadius!:'';
  }

  static String getNowDateAndTime(){
    DateFormat df = DateFormat('dd-MM-yyyy HH:mm:ss');
    return df.format(DateTime.now());
  }

  static Pack getSelectedPack(String? packs){
    List<dynamic> parsedListJson = jsonDecode(packs!);
    List<Pack> productPacks = List<Pack>.from(parsedListJson.map<Pack>((dynamic i) => Pack.fromJson(i)));
    for(Pack p in productPacks){
      if(p.isSelected!){
        return p;
      }
    }
    return productPacks[0];
  }

  static Future<List<ProductDataDistributorTypeDataDetail>> getDistributorTypes(int productId,int selecteduser,DatabaseHelper instance) async {

    List<ProductDataDistributorTypeDataDetail> distTypes = [];

    var types = await instance.execQuery('SELECT * FROM ${instance.productDataDistributorTypeDataDetail} WHERE ${ProductDataDistributorTypeDataDetailFields.productId} = $productId AND ${ProductDataDistributorTypeDataDetailFields.salesmanId} = $selecteduser');


    for(var type in types){
      print('${type['productId']} - ${type['distributorTypeId']}');
      distTypes.add(ProductDataDistributorTypeDataDetail(type['productId'], type['salesmanId'], type['distributorTypeId'], type['distributorTypeName']));
    }




    return distTypes;
  }

  static var schemes = {
    'flat':1,
    'percentage':2,
    'qps':3,
    'visibility':4
  };

  static dynamic getUserFromHierarchy(DatabaseHelper instance,SharedPreferences prefs) async{
    var employId = getUserData(prefs)!.employId;
    var hierarchyRaw = await instance.execQuery('SELECT * FROM ${instance.tableUserHierarchyDataDetail} WHERE ${UserHierarchyDataDetailFields.employId} = $employId');
    if(hierarchyRaw.isNotEmpty){
      return hierarchyRaw[0];
    }
    return null;
  }



  static bool checkPermission(SharedPreferences prefs,String codename){
    UserData? user = getUserData(prefs);
    if (user!=null) {
      var groups = user.groups;
      if (groups!=null && groups.isNotEmpty) {
        for (UserGroup group in groups) {
          List<UserPermissions> permissions = group.permissions!=null?group.permissions!:[];
          if (permissions.isNotEmpty) {
            for (UserPermissions permission in permissions) {
              if (permission.codeName == codename) {
                return true;
              }
            }
          }
        }
      }
      List<UserPermissions> userPermissions = user.userPermissions!=null?user.userPermissions!:[];
      if (userPermissions.isNotEmpty) {
        for (UserPermissions permission in userPermissions) {
          if (permission.codeName ==codename) {
            return true;
          }
        }
      }

    }
    return false;
  }

  static Future<bool> permissionChecker(List<Permission> permissions)async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();

    bool granted = true;

    for(var permission in permissions){
      if(statuses[permission] != PermissionStatus.granted){
        granted = false;
        break;
      }
    }

    return granted;
  }

  static Future<String> getImagePath(String name)async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/$imageFiles';
    directory = Directory(path);
    if(!await directory.exists()){
    directory.create();
    }
    final File file = File('${directory.path}/$name');
    return file.path;
  }

  static String getCurrency(SharedPreferences prefs){
    String currency = '';
    var userData = getUserData(prefs);
    if(userData!=null){
      currency = userData.settings!.currency!;
    }
    if(currency == 'INR'){
      currency = '\u20B9';
    }
    return currency;
  }

  static Future<ProductDataDetail?> getProductFromId(int? productId, int selectedUser, DatabaseHelper instance) async{
    ProductDataDetail? prd;
    var product = await instance.execQuery('SELECT * FROM ${instance.productDataDetail} WHERE ${ProductDataFields.productId} = $productId AND ${ProductDataFields.salesmanId} = $selectedUser');
    if(product.isNotEmpty){
      prd = ProductDataDetail(
          product[0]['productName'],
          product[0]['productId'],
          product[0]['barcodeNumber'],
          product[0]['hsnNumber'],
          product[0]['description'],
          product[0]['manufacturer'],
          product[0]['productCategory'],
          product[0]['scope'],
          product[0]['mrp'],
          product[0]['nrv'],
          product[0]['ptr'],
          product[0]['taxType'],
          product[0]['isQps']==1,
          product[0]['discountValue'],
          product[0]['productStatus']==1,
          product[0]['quantityLimit'],
          product[0]['taxValue'],
          product[0]['pts'],
          product[0]['netPrice'],
          product[0]['isFeatureProduct']==1,
          product[0]['packs'],
          product[0]['pricingId'],
          product[0]['pricingNodeId'],
          product[0] ['queryNodeId'],
          product[0]['channel'],
          product[0]['count'],
          product[0]['packCount'],
          product[0]['image'],
          product[0]['salesmanId'],
          product[0]['brand'],
          product[0]['schemeId'],
          product[0]['schemeCount']
      );
    }
    return prd ;
  }

  static List<ProductDataDistributorTypeDataDetail> getCommonTypes(List<ProductDataDistributorTypeDataDetail> list1,List<ProductDataDistributorTypeDataDetail> list2){
    List<ProductDataDistributorTypeDataDetail> list = [];
    for(var i1 in list1){
      for(var i2 in list2){
        if(i1.distributorTypeId==i2.distributorTypeId){
          list.add(i1);
          break;
        }
      }
    }
    return list;
  }

  static getProductWithCountAndPrices(SchemesDataDetail detail,List<ProductDataDetail> items) async {
    var prd = items
        .where((element) => element.productId == detail.productId)
        .first;

    if (prd != null) {
      List<dynamic> parsedListJson = jsonDecode(prd.packs!);
      List<Pack> productPacks = List<Pack>.from(
          parsedListJson.map<Pack>((dynamic i) => Pack.fromJson(i)));
      productPacks[0].isSelected = true;
      prd.packs = jsonEncode(productPacks);
      prd.packCount = detail.minQty;
      prd.count = detail.minQty;
    }

    ProductDataDetail prod = ProductDataDetail(
        prd.productName,
        prd.productId, prd.barcodeNumber,
        prd.hsnNumber,
        prd.description,
        prd.manufacturer,
        prd.productCategory,
        prd.scope,
        prd.mrp,
        prd.nrv,
        prd.ptr,
        prd.taxType,
        detail.isQps,
        prd.discountValue,
        prd.productStatus,
        prd.quantityLimit,
        prd.taxValue,
        prd.pts,
        prd.netPrice,
        prd.isFeatureProduct,
        prd.packs,
        prd.pricingId,
        prd.pricingNodeId,
        prd.queryNodeId,
        prd.channel,
        prd.count,
        prd.packCount,
        prd.image,
        prd.salesmanId,
        prd.brand,
        prd.schemeId,
        prd.schemeCount
    );

    return prod;
  }

  static getTotalAmount(ProductDataDetail prd) {
    var count = prd.count!;
    var price = double.parse(prd.ptr!);
    return (count*price).toStringAsFixed(2);
  }

  static Future<bool> checkAllItemsHaveDistTypes(List<ProductDataDetail> items,int selectedUser,DatabaseHelper instance) async{
    bool allItemHaveDistType = true;
    for(var item in items){
      var distTypes = await AppUtils.getDistributorTypes(item.productId!,selectedUser,instance);
      if(distTypes.isEmpty){
        allItemHaveDistType = false;
        break;
      }
    }
    return allItemHaveDistType;
  }

  static Future<bool> hasCommonDistType(List<ProductDataDetail> items,int selectedUser,DatabaseHelper instance) async{
    List<ProductDataDistributorTypeDataDetail>  list = [];
    var distType = await AppUtils.getDistributorTypes(items[0].productId!,selectedUser,instance);
    for(var item in items){
      var productDistType = await AppUtils.getDistributorTypes(item.productId!,selectedUser,instance);
      var commonTypes = AppUtils.getCommonTypes(distType,productDistType);
      for(var type in commonTypes){
        bool exists = false;
        for(var item in list){
          if(item.distributorTypeId==type.distributorTypeId){
            exists = true;
            break;
          }
        }
        if(!exists){
          list.add(type);
        }
      }
    }
    return list.isNotEmpty;
  }

  static int getFreeFactor(List<ProductDataDetail> item,List<SchemesDataDetail> schemes) {
    List<int> freeList = [];
    for(var item in item)  {
      for(var scheme in schemes){
        if(item.productId==scheme.productId){
          freeList.add(
              item.count!~/scheme.minQty!
          );
          break;
        }
      }
    }
    return freeList.reduce(min);
  }

  static List<int> getMax(Map<int,int> mapTypeCount) {
    int maxValueInMap = 0;

    for(var key in mapTypeCount.keys){
      if(maxValueInMap<mapTypeCount[key]!){
        maxValueInMap = mapTypeCount[key]!;
      }
    }

    List<int> ids = [];

    for(var key in mapTypeCount.keys){
      if(mapTypeCount[key] == maxValueInMap){
        ids.add(key);
      }
    }

    return ids;

  }


  static Future<DistributorDataDetail?> getDistributor(int id,DatabaseHelper instance) async{
    var dist = await instance.execQuery('SELECT * FROM ${instance.distributorDataDetail} WHERE ${DistributorDataDetailFields.distributorId} = $id');
    if(dist!=null && dist.isNotEmpty){

      DistributorDataDetail distributor = DistributorDataDetail(
          dist[0]['distributorId'],
          dist[0]['name'],
          dist[0]['code'],
          dist[0]['contactNumber'],
          dist[0]['type'],
          dist[0]['distributorStatus']==1,
          dist[0]['emailId'],
          dist[0]['salesmanId'],
          dist[0]['territories'],
          dist[0]['types']
      );

      return distributor;
    }

    return null;
  }

  static Future<UserHierarchyDataDetail?> getUserFromHierarchyById(DatabaseHelper instance,int userId) async {

    UserHierarchyDataDetail? user;

    var userHierarchyRaw = await instance.execQuery('SELECT * FROM ${instance.tableUserHierarchyDataDetail} WHERE ${UserHierarchyDataDetailFields.serverId} = $userId');

    if(userHierarchyRaw.isNotEmpty){

      user = UserHierarchyDataDetail(
          userHierarchyRaw[0]['serverId'],
          userHierarchyRaw[0]['employName'],
          userHierarchyRaw[0]['employId'],
          userHierarchyRaw[0]['locations'],
          userHierarchyRaw[0]['salesmanDistributors'],
          userHierarchyRaw[0]['beats'],
          userHierarchyRaw[0]['lastLogin'],
          userHierarchyRaw[0]['tenantId'],
          userHierarchyRaw[0]['userId'],
          userHierarchyRaw[0]['name'],
          userHierarchyRaw[0]['mobileNumber'],
          userHierarchyRaw[0]['email'],
          userHierarchyRaw[0]['isExternal']==1,
          userHierarchyRaw[0]['isActive']==1,
          userHierarchyRaw[0]['dateJoined'],
          userHierarchyRaw[0]['fcmToken'],
          userHierarchyRaw[0]['createdAt'],
          userHierarchyRaw[0]['updatedAt'],
          userHierarchyRaw[0]['isSalesman']==1,
          userHierarchyRaw[0]['isGeoRestricted']==1,
          userHierarchyRaw[0]['place'],
          userHierarchyRaw[0]['role'],
          userHierarchyRaw[0]['manager'],
          userHierarchyRaw[0]['createdBy'],
          userHierarchyRaw[0]['updatedBy']
      );
    }

    return user;

  }

  static Widget getDiscountView(List<SchemesDataDetail> list,SharedPreferences prefs) {
    List<SchemesDataDetail> paid = list.where((element) => !element.isQps!).toList();
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5,),
            const Text(AppStrings.buy,style: TextStyle(color: Colors.grey,fontSize: 12),),
            const SizedBox(height: 10,),
            Column(children: AppUtils.getItemRows(paid),),
            const SizedBox(height: 20,),
            Wrap(
              children: [
                Text(AppStrings.getDiscountOf,style: TextStyle(color: Colors.grey,fontSize: 12),),
                SizedBox(width: 5,),
                getDiscountAmountView(paid[0],prefs)
              ],
            )
          ],
        )
    );
  }

  static Widget getDiscountAmountView(SchemesDataDetail disc,SharedPreferences prefs) {
    Widget view = Container();
    if(disc.discountUom=='INR') {
      view = Text('${AppUtils.getCurrency(prefs)} ${disc.discountValue}',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600),);
    }
    if(disc.discountUom=='%') {
      view = Text('${disc.discountValue} ${disc.discountUom}',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600),);
    }
    return view;
  }


  static  Widget getQpsView(List<SchemesDataDetail> list) {
    List<SchemesDataDetail> free = list.where((element) => element.isQps!).toList();
    List<SchemesDataDetail> paid = list.where((element) => !element.isQps!).toList();
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            Text(AppStrings.buy,style: TextStyle(color: Colors.grey,fontSize: 12),),
            SizedBox(height: 10,),
            Column(children: getItemRows(paid),),
            SizedBox(height: 10,),
            Text(AppStrings.get,style: TextStyle(color: Colors.grey,fontSize: 12),),
            SizedBox(height: 10,),
            Column(children: getItemRows(free),),
            SizedBox(height: 10,),
          ],
        )
    );
  }

  static getItemRows(List<SchemesDataDetail> paid) {
    List<Widget> widgets = [];
    for (SchemesDataDetail scheme in paid){
      widgets.add(Row(
        children: [
          Expanded(
              child: Text('${scheme.minQty} ${AppStrings.itemsOf}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black),)
          ),
          Text(scheme.productName!,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black))
        ],
      )) ;
    }
    return widgets;
  }

  static Widget getVisibilityView(List<SchemesDataDetail> list,SharedPreferences pref) {
    List<SchemesDataDetail> paid = list.where((element) => !element.isQps!).toList();
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5,),
            const Text(AppStrings.buy,style: TextStyle(color: Colors.grey,fontSize: 12),),
            const SizedBox(height: 10,),
            Column(children: getVisibilityItemRows(paid,pref),),
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: Text('${AppStrings.worth}:',style: TextStyle(fontSize: 12,color: Colors.grey),)),
                Text('${paid[0].minPurchaseValue}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Text('${AppStrings.andMaintainDisplayOf} ',style: TextStyle(fontSize: 12,color: Colors.grey),),
                Text('${paid[0].tenure} ${AppStrings.days} ',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),),
                Text('${AppStrings.toGet} ',style: TextStyle(fontSize: 12,color: Colors.grey),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                const Expanded(child: Text('${AppStrings.offerValue}:',style: TextStyle(fontSize: 12,color: Colors.grey),)),
                Text('${AppUtils.getCurrency(pref)} ${paid[0].discountValue}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),),
              ],
            ),
          ],
        )
    );
  }

  static List<Widget> getVisibilityItemRows(List<SchemesDataDetail> paid,SharedPreferences pref) {
    List<Widget> widgets = [];
    for (SchemesDataDetail scheme in paid){
      widgets.add(Row(
        children: [
          Expanded(
              child: Text(scheme.productName!,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black))
          ),
        ],
      )) ;
    }
    return widgets;
  }

}
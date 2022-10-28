import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vajra/models/user_data/user_data.dart';
import 'package:vajra/services/navigation_service.dart';

class AppUtils {
  static const int splashTimeout = 3 * 1000; //3000 milisecond is 3 seconds

  static const String version = "2.30";

  static bool isSyncGoingOn = false;

  static int syncInterval = 2;

  static int db_version = 1;

  static String webFiles = "web_files";

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


  static String dayOfTheWeek(){
    const Map<int, String> weekdayName = {1: "MONDAY", 2: "TUESDAY", 3: "WEDNESDAY", 4: "THURSDAY", 5: "FRIDAY", 6: "SATURDAY", 7: "SUNDAY"};
    return weekdayName[DateTime.now().weekday]!;
  }

  static int weekOfTheMonth() {
    String date = DateTime.now().toString();

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

}
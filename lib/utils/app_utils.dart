import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
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

}
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:vajra_test/cores/model/country_codes.dart';
import 'package:vajra_test/cores/model/user/locations.dart';
import 'package:vajra_test/cores/model/user/user_data.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';
import 'package:vajra_test/cores/themes/app_theme.dart';
import 'package:vajra_test/cores/utils/date_utils.dart' as dateUtils;
import 'package:vajra_test/features/auth/view/pages/login.dart';
import 'package:vajra_test/features/home/model/repositories/home_local_repository.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_beats.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_beats_calendar.dart';
import 'package:vajra_test/features/sync/model/repositories/userhierarchy/user_hierarchy_local_repository.dart';
import 'package:vajra_test/init_dependencies.dart';

class AppUtils {
  static bool isSyncing = false;
  static int syncInterval = 2;
}

Future<List<CountryCode>> loadCountries() async {
  String data = await rootBundle.loadString('assets/json/country.json');
  var json = jsonDecode(data) as List<dynamic>;
  var countryList = json.map((e) {
    var country = e as Map<String, dynamic>;
    return CountryCode.fromMap(country);
  }).toList();
  return countryList;
}

void showBottomDialog(BuildContext context, Widget widget,
    [bool isScrollControlled = true]) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) => widget,
    isScrollControlled: isScrollControlled,
  );
}

void showAlertDialog(BuildContext context, String title, String content,
    bool isCancelable, List<Widget> actions) {
  showDialog(
    barrierDismissible: isCancelable,
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        title,
        style: AppTheme.textTheme(AppPalette.blackColor, 22.0, FontWeight.w500),
      ),
      content: Text(
        content,
        style: AppTheme.textTheme(AppPalette.blackColor, 18.0, FontWeight.w400),
      ),
      actions: actions,
    ),
  );
}

Future<String?> getDeviceId() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    // For Android, use the Android ID (available from Android API 23+)
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    return androidInfo.device; // Android device ID
  } else if (Platform.isIOS) {
    // For iOS, use the identifierForVendor
    IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
    return iosInfo.identifierForVendor; // iOS device ID
  }

  return null; // Return null for unsupported platforms
}

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
}

Future<String> getUserName() async {
  Box box = serviceLocator();
  return box.get('name');
}

Future<String> getEmpId() async {
  Box box = serviceLocator();
  return box.get('user_id');
}

Future<List<Locations>> getPlaces() async {
  Box<Locations> box = serviceLocator();

  return box.values.toList();
}

void logout(BuildContext context) async {
  Box box = serviceLocator();
  box.clear();

  Box<Locations> locationsBox = serviceLocator();
  locationsBox.clear();

  Navigator.pushAndRemoveUntil(context, Login.route(), (route) => false);
}

Map<String, String> headers = {
  'tenant-id': serviceLocator<Box>().get('tenant-id'),
  'Authorization': 'Token ${serviceLocator<Box>().get('token')}',
};

int getSalesmanId() {
  Box box = serviceLocator();
  String data = box.get('user');

  print(data);

  UserData user = UserData.fromJson(jsonDecode(data));
  return user.id ?? 0;
}

bool isSalesman() {
  Box box = serviceLocator();
  String data = box.get('user');
  UserData user = UserData.fromJson(jsonDecode(data));
  return user.isSalesman ?? false;
}

void saveLastSyncTime() {
  final now = DateTime.now();
  String lastSyncTime = DateFormat('dd/MM/yyyy hh:mm:ss a').format(now);
  Box box = serviceLocator();
  box.put('last_sync_time', lastSyncTime);
}

bool isSyncTime() {
  try {
    final String syncTime = HomeLocalRepository().getLastSyncTime();

    if (syncTime.isEmpty) {
      return true;
    }

    final lastSyncTime = DateFormat("dd/MM/yyyy hh:mm:ss a").parse(syncTime);

    final difference = dateUtils.DateUtils.getDifferenceInHours(
      lastSyncTime,
      DateTime.now(),
    );

    return difference >= AppUtils.syncInterval;
  } catch (e) {
    return false;
  }
}


double getDistance(
  double startLatitude,
  double startLongitude,
  double endLatitude,
  double endLongitude,
) {
  final distance = Geolocator.distanceBetween(
    startLatitude,
    startLongitude,
    endLatitude,
    endLongitude,
  );

  print(distance);

  return distance;
}

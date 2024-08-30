import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:vajra_test/cores/model/country_codes.dart';
import 'package:vajra_test/cores/model/user/locations.dart';
import 'package:vajra_test/features/auth/view/pages/login.dart';
import 'package:vajra_test/init_dependencies.dart';

Future<List<CountryCode>> loadCountries() async {
  String data = await rootBundle.loadString('assets/json/country.json');
  var json = jsonDecode(data) as List<dynamic>;
  var countryList = json.map((e) {
    var country = e as Map<String, dynamic>;
    return CountryCode.fromMap(country);
  }).toList();
  return countryList;
}

void showBottomDialog(BuildContext context, Widget widget) {
  showModalBottomSheet(context: context, builder: (ctx) => widget);
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

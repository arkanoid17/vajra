import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/utils/app_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  SharedPreferences? prefs;

  void navigate() {
    prefs!.containsKey('token')
        ? Navigator.pushReplacementNamed(context, '/dashboard')
        : Navigator.pushReplacementNamed(context, '/login');
  }

  void splashTimer() {
    Timer scheduleTimeout([int milliseconds = 10000]) =>
        Timer(Duration(milliseconds: milliseconds), navigate);
    scheduleTimeout(AppUtils.splashTimeout);
  }

  void checkPermissions() async{
    if(Platform.isAndroid){
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
        //add more permission to request here.
      ].request();


      if(statuses[Permission.location] == PermissionStatus.granted && statuses[Permission.storage] == PermissionStatus.granted){
        splashTimer();
      }else{
        Permission.location.request();
        AppUtils.showMessage( "Please grant all permissions");
        // checkPermissions();
      }
    }else{
      var locationStatus = await Permission.locationWhenInUse.request();
      if(locationStatus.isGranted){
        var storageStatus = await Permission.storage.request();
        if(storageStatus.isGranted) {
          splashTimer();
        }else{
          AppUtils.showMessage( "Please grant all permissions");
        }
      } else{
        AppUtils.showMessage( "Please grant all permissions");
      }

    }
  }



  @override
  Widget build(BuildContext context) {

    AppUtils.getPrefs().then((value) => {
      prefs = value,
      checkPermissions()
    });


    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/ic_splash.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: null
      ),
    );
  }
}

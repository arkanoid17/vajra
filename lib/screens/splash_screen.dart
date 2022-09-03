import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vajra/utils/app_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {


  void navigate() {
    // bool hasToken = prefs.containsKey('token');
    // prefs.containsKey('token')
    //     ? Navigator.pushReplacementNamed(context, '/dashboard')
    //     : Navigator.pushReplacementNamed(context, '/login');

    Navigator.pushReplacementNamed(context, '/login');
  }

  void splashTimer() {
    Timer scheduleTimeout([int milliseconds = 10000]) =>
        Timer(Duration(milliseconds: milliseconds), navigate);
    scheduleTimeout(AppUtils.splashTimeout);
  }


  @override
  Widget build(BuildContext context) {

    splashTimer();

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

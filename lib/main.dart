import 'package:flutter/material.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/screens/login.dart';
import 'package:vajra/screens/splash_screen.dart';

void main() {
  runApp(const MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        primarySwatch: ColorConstants.colorPrimary,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        // '/dashboard': (context) => Dashboard(),
      },
    );
  }
}



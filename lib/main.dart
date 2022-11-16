
import 'package:flutter/material.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/screens/book_order.dart';
import 'package:vajra/screens/dashboard.dart';
import 'package:vajra/screens/dynamic_actions_page.dart';
import 'package:vajra/screens/error_page.dart';
import 'package:vajra/screens/login.dart';
import 'package:vajra/screens/my_report.dart';
import 'package:vajra/screens/splash_screen.dart';
import 'package:vajra/screens/store_listing.dart';
import 'package:vajra/screens/store_onboarding.dart';
import 'package:vajra/services/navigation_service.dart';

void main() {
  runApp(const MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      onGenerateRoute: _getRoute,

      title: AppStrings.appName,
      theme: ThemeData(
        primarySwatch: ColorConstants.colorTheme,
      ),
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => Dashboard(),
        '/stores': (context) => StoreListing(),
        '/store-onboarding': (context) => StoreOnboarding(),
        '/my-report': (context) => MyReport(),
      },
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name == '/book-order') {
      // FooRoute constructor expects SomeObject
      return _buildRoute(settings, BookOrder(settings.arguments));
    }

    if (settings.name == '/dynamic-actions') {
      // FooRoute constructor expects SomeObject
      return _buildRoute(settings, DynamicActionsPage(settings.arguments));
    }

    return _buildRoute(settings,  ErrorPage());
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}



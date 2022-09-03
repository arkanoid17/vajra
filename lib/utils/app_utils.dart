import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static const int splashTimeout = 3 * 1000; //3000 milisecond is 3 seconds

  static void showMessage(BuildContext ctx, var message) {
    var snackbar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(ctx).showSnackBar(snackbar);
  }

  static const String PROD_URL = "https://api.glenmark.adjoint.in/";
  static const String DEV_URL = "https://dev.glenmark.adjoint.in/";
  static const String LOCAL_URL = "http://192.168.55.106:8000/";

  // static const String baseUrl = PROD_URL;
  // static const String baseUrl = LOCAL_URL;
  static const String baseUrl = DEV_URL;

  static const String sh_pref = 'Vajra';

  static void showBottomDialog(BuildContext context,bool isDismissable,bool isScrollControlled, Color backgroundColor,view){
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

}
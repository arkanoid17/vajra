import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/features/location/bloc/location_bloc.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';
import 'package:vajra_test/cores/themes/app_theme.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/main.dart';

class AppLocations {
  static const locationSettings = LocationSettings(
    distanceFilter: 10,
  );

  static Future<bool> checkLocationPermission() async {
    var status = await (Platform.isAndroid
        ? permissionHandler.Permission.location.request()
        : permissionHandler.Permission.locationWhenInUse.request());

    return status.isGranted;
  }

  static void showLocationPermissionDialog() {
    showAlertDialog(MyApp.navigatorKey.currentState!.context, AppStrings.vajra,
        AppStrings.pleaseGiveLocationAcessToUseApp, false, [
      TextButton(
        onPressed: () => Geolocator.openAppSettings(),
        child: Text(
          AppStrings.settings,
          style: AppTheme.textTheme(
            AppPalette.primaryColor,
            14.0,
            FontWeight.w400,
          ),
        ),
      )
    ]);
  }

  static checkLocationService() async {
    final locationStream = Geolocator.getServiceStatusStream();

    locationStream.listen((status) {
      MyApp.navigatorKey.currentContext!.read<LocationBloc>().add(
          OnLocationServiceChangedEvent(
              status: status == ServiceStatus.enabled));
    });
  }

  static void handleServiceStatusChange(bool status, BuildContext ctx) {
    if (status) {
      showAlertDialog(
          ctx, AppStrings.vajra, AppStrings.pleaseEnableLocation, false, [
        TextButton(
            onPressed: () => Geolocator.openLocationSettings,
            child: Text(
              AppStrings.settings,
              style: AppTheme.textTheme(
                AppPalette.primaryColor,
                14.0,
                FontWeight.normal,
              ),
            ))
      ]);
    } else {
      if (ctx.widget is Overlay) Navigator.pop(ctx);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:vajra_test/cores/constants/app_dimens.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';

class AppTheme {
  static ThemeData apptheme = ThemeData(
    primaryColor: const Color.fromRGBO(83, 27, 147, 1),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: _border(AppPalette.primaryColor),
      border: _border(AppPalette.borderColor),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppPalette.primaryColor,
        iconTheme: IconThemeData(color: AppPalette.whiteColor)),
    drawerTheme: DrawerThemeData(),
  );

  static _border(color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(
          AppDimens.inputBorderRadius,
        ),
      );

  static const titleText = TextStyle(
      color: AppPalette.blackColor, fontWeight: FontWeight.w500, fontSize: 18);

  static const smallText = TextStyle(
      color: AppPalette.blackColor, fontWeight: FontWeight.w300, fontSize: 14);

  static textTheme(color, size, weight) => TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
      );

  static final homeCardsBorder = BoxDecoration(
    border: Border.all(
      color: AppPalette.borderColorCards,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(
      4,
    ),
  );
}

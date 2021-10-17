import 'package:flutter/material.dart';
import 'package:vchat/constant/app_color.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    fontFamily: "NanumGothicCoding",
    primaryColor: AppColor.primaryColor,
    primaryColorDark: AppColor.primaryColorDark,
    primaryColorLight: AppColor.primaryColorLight,
    backgroundColor: AppColor.primaryColor,
    scaffoldBackgroundColor: AppColor.primaryColorLight,
    cardColor: AppColor.primaryColorDark,
    appBarTheme: const AppBarTheme(color: Colors.white),
    textTheme: const TextTheme(
      headline1: TextStyle(),
      headline2: TextStyle(),
      headline3: TextStyle(),
      headline4: TextStyle(),
      headline5: TextStyle(),
      headline6: TextStyle(),
      subtitle1: TextStyle(),
      subtitle2: TextStyle(),
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
      caption: TextStyle(),
      button: TextStyle(),
      overline: TextStyle(),
    ).apply(
      bodyColor: AppColor.primaryColorLight,
      displayColor: AppColor.primaryColorLight,
    ),
  );
}

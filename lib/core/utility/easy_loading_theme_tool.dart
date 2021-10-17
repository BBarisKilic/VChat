import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vchat/core/constant/core_color.dart';

class EasyLoadingThemeTool {
  static void mainTheme() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.foldingCube
      ..loadingStyle = EasyLoadingStyle.custom
      ..contentPadding = const EdgeInsets.all(30.0)
      ..indicatorSize = 60.0
      ..radius = 10.0
      ..progressColor = CoreColor.primaryColorLight
      ..backgroundColor = const Color(0xff393335).withOpacity(0.8)
      ..indicatorColor = const Color(0xff2696D7).withOpacity(0.8)
      ..textColor = CoreColor.primaryColorLight
      ..boxShadow = <BoxShadow>[]
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
  }
}

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController{
  final selectedIndex = 0.obs;

  List<Widget> widgetOptions = <Widget>[
    DashboardScreen(),
    ProfileScreen()
  ];

  List<String> appTitle = <String>[
    "Beranda".tr,
    "Profil".tr
  ];
}
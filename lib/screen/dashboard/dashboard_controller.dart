import 'package:carousel_slider/carousel_slider.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController {
  final selectedIndex = 0.obs;

  bool isLogin = false;

  List<Widget> widgetOptions = <Widget>[
    const DashboardScreen(),
    const ProfileScreen(),
  ];

  List<String> appTitle = <String>["Beranda".tr, "Profil".tr];

  List<Widget> bannerList = [
    const Text('for commercial banner 1'),
    const Text('for commercial banner 2'),
    const Text('for commercial banner 3'),
  ];
  var bannerIndex = 0.obs;
  CarouselController commercialCarousel = CarouselController();

  @override
  void onInit() {
    super.onInit();
    Future.wait([cekToken()]);
  }

  Future<bool> cekToken() async {
    String? token = await storage.readToken();
    debugPrint("token : $token");
    isLogin = token != null;
    update();
    return (token == null);
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController {
  final selectedIndex = 0.obs;

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

  Future<bool> cekToken() async {
    // isLoading = true;
    update();
    String? token = await storage.readToken();
    debugPrint("token : $token");
    if (token == null) {
      Get.offAll(const LoginScreen());
      // String all = await storage.readString(StorageCore.allowedMenu);
      // AllowedMenu menu = AllowedMenu.fromJson(jsonDecode(all));
      // print(menu.beranda);
    }
    // isLoading = false;
    update();
    return (token == null);
  }
}

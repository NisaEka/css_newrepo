import 'package:carousel_slider/carousel_slider.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_shipper_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController {
  final selectedIndex = 0.obs;

  bool isLogin = false;
  bool isLoading = false;

  String? marqueeText;
  String? userName;

  List<Widget> widgetOptions = <Widget>[
    const DashboardScreen(),
    const ProfileScreen(),
  ];

  List<String> appTitle = <String>["Beranda".tr, "Profil".tr];

  List<Widget> bannerList = [];
  var bannerIndex = 0.obs;
  CarouselController commercialCarousel = CarouselController();

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
    update();
  }

  Future<bool> cekToken() async {
    String? token = await storage.readToken();
    debugPrint("token : $token");
    isLogin = token != null;
    update();
    return isLogin;
  }

  Future<void> initData() async {
    cekToken();
    isLoading = true;
    bannerList = [
      const Text('for commercial banner 1'),
      const Text('for commercial banner 2'),
      const Text('for commercial banner 3'),
    ];

    marqueeText = 'Data diperbaharui setiap jam 06 : 45 WIB';

    try {
      await transaction.getSender().then((value) async => await storage.saveData(
            StorageCore.shipper,
            value.payload,
          ));

      await transaction.getAccountNumber().then((value) async => await storage.saveData(
            StorageCore.accounts,
            value,
          ));

      var shipper = ShipperModel.fromJson(await storage.readData(StorageCore.shipper));
      userName = shipper.name;
      update();
    } catch (e) {
      e.printError();
    }

    isLoading = false;
    update();
  }
}

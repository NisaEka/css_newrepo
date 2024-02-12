import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
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

  List<Items> menuItems = [];
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

  Future<void> cekFavoritMenu() async {
    var favMenu = await storage.readString(StorageCore.favoriteMenu);
    var menu = MenuItemModel.fromJson(jsonDecode(favMenu));
    print('menu kosong : ${menu.items != null}');

    if (favMenu.isEmpty) {
      await storage.saveData(
          StorageCore.favoriteMenu,
          MenuItemModel(items: [
            Items(
              title: "Input Kirimanmu",
              icon: ImageConstant.paketmuIcon,
              route: "/inputKiriman",
              isFavorite: true,
              isEdit: false,
              isAuth: true,
            ),
            Items(
              title: "Cek Ongkir",
              icon: ImageConstant.cekOngkirIcon,
              route: "/cekOngkir",
              isFavorite: true,
              isEdit: false,
              isAuth: false,
            ),
            Items(
              title: "Draft Transaksi",
              icon: ImageConstant.paketmuIcon,
              route: "draft_transaksi",
              isFavorite: true,
              isEdit: false,
              isAuth: true,
            ),
            Items(
              title: "Riwayat Kiriman",
              icon: ImageConstant.paketmuIcon,
              route: "/riwayatKiriman",
              isFavorite: true,
              isEdit: false,
              isAuth: true,
            ),
          ]));
    } else {
      menuItems.addAll(menu.items ?? []);
    }
  }

  Future<void> cekLocalLanguage() async {
    String local = await storage.readString(StorageCore.localeApp);
    local.isEmpty.printInfo();
    if (local.isEmpty) {
      (Get.deviceLocale == Locale("id", "ID")).printInfo(info: "local");
      if (Get.deviceLocale == Locale("id", "ID")) {
        await storage.writeString(StorageCore.localeApp, "id_ID");
        Get.updateLocale(Locale("id", "ID"));
        update();
      } else {
        await storage.writeString(StorageCore.localeApp, "en_US");
        Get.updateLocale(Locale("en", "ES"));
        update();
      }
    } else {
      if (local == "id_ID") {
        await storage.writeString(StorageCore.localeApp, "id_ID");
        Get.updateLocale(Locale("id", "ID"));
        update();
      } else {
        await storage.writeString(StorageCore.localeApp, "en_US");
        Get.updateLocale(Locale("en", "ES"));
        update();
      }
    }
  }

  Future<void> initData() async {
    cekLocalLanguage();
    cekFavoritMenu();
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

      await transaction.getDropshipper().then((value) async => await storage.saveData(
            StorageCore.dropshipper,
            value,
          ));

      await transaction.getReceiver().then((value) async => await storage.saveData(
            StorageCore.receiver,
            value,
          ));

      await profil.getBasicProfil().then((value) async => await storage.saveData(
            StorageCore.userProfil,
            value.payload,
          ));

      update();
    } catch (e) {
      e.printError();
    }

    isLoading = false;
    update();
  }
}

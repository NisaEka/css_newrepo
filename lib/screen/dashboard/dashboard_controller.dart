import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_profil_model.dart';
import 'package:css_mobile/data/model/transaction/get_shipper_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/profile/alt/alt_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController {
  final selectedIndex = 0.obs;
  final nomorResi = TextEditingController();
  DateTime? currentBackPressTime;

  bool isLogin = false;
  bool isLoading = false;
  bool isOnline = false;
  bool isCcrf = true;

  GetCcrfProfilModel? ccrf;

  String? marqueeText;
  String? userName;
  String? jlcPoint;

  List<Widget> widgetOptions = <Widget>[
    const DashboardScreen(),
    const AltProfileScreen(),
  ];

  List<Items> menuItems = [];
  List<String> appTitle = <String>["Beranda".tr, "Profil".tr];
  List<Widget> bannerList = [];
  var bannerIndex = 0.obs;
  CarouselController commercialCarousel = CarouselController();
  AllowedMenu allow = AllowedMenu();

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      initData(),
    ]);
    update();
  }

  Future<bool> cekToken() async {
    String? token = await storage.readToken();
    debugPrint("token : $token");
    isLogin = token != null;
    update();

    return isLogin;
  }

  void loadMenu() async {
    Get.showSnackbar(
      const GetSnackBar(
        icon: Icon(
          Icons.info,
          color: whiteColor,
        ),
        message: 'test cek favmenu',
        isDismissible: true,
        duration: Duration(seconds: 3),
        backgroundColor: successColor,
      ),
    );
  }

  Future<void> cekFavoritMenu() async {
    menuItems = [
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
        route: "/draftTransaksi",
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
    ];
    var favMenu = await storage.readString(StorageCore.favoriteMenu);
    var stickerLabel = await storage.readString(StorageCore.transactionLabel);
    var shipcost = await storage.readString(StorageCore.shippingCost);
    update();
    if (favMenu.isEmpty == true) {
      await storage.saveData(
        StorageCore.favoriteMenu,
        MenuItemModel(items: menuItems),
      );
      update();
    } else {
      menuItems = [];
      var menu = MenuItemModel.fromJson(jsonDecode(favMenu));
      menuItems.addAll(menu.items ?? []);
    }

    update();

    if (stickerLabel.isEmpty || shipcost.isEmpty) {
      await storage.writeString(StorageCore.transactionLabel, "/sticker_megahub1");
      await storage.writeString(StorageCore.shippingCost, "PUBLISH");
    }
    update();
  }

  Future<void> cekLocalLanguage() async {
    String local = await storage.readString(StorageCore.localeApp);
    local.isEmpty.printInfo();
    if (local.isEmpty || local == 'id_ID' || local == 'en_US' || local == "id" || local == "en") {
      (Get.deviceLocale == const Locale("id", "ID")).printInfo(info: "local");
      if (Get.deviceLocale == const Locale("id", "ID")) {
        await storage.writeString(StorageCore.localeApp, "id");
        Get.updateLocale(const Locale("id", "ID"));
        update();
      } else {
        await storage.writeString(StorageCore.localeApp, "en");
        Get.updateLocale(const Locale("en", "ES"));
        update();
      }
    } else {
      if (local == "id") {
        await storage.writeString(StorageCore.localeApp, "id");
        Get.updateLocale(const Locale("id", "ID"));
        update();
      } else {
        await storage.writeString(StorageCore.localeApp, "en");
        Get.updateLocale(const Locale("en", "ES"));
        update();
      }
    }
  }

  Future<void> initData() async {
    connection.isOnline().then((value) => isOnline = value);
    cekFavoritMenu();
    update();
    cekLocalLanguage();
    cekToken();
    isLoading = true;
    bannerList = [
      const Text('for commercial banner 1'),
      const Text('for commercial banner 2'),
      const Text('for commercial banner 3'),
    ];

    marqueeText = 'Data diperbaharui setiap jam 06 : 45 WIB';
    var shipper = ShipperModel.fromJson(await storage.readData(StorageCore.shipper));
    userName = shipper.name ?? "";
    // if (isLogin == true) {
    try {
      await jlc.postTotalPoint().then((value) {
        print("jlc point : ${value.data?.first.sisaPoint}");
        jlcPoint = value.data?.first.sisaPoint.toString();
        update();
      });
      await transaction
          .getSender()
          .then((value) async => await storage.saveData(
                StorageCore.shipper,
                value.payload,
              ))
          .then((_) async {
        var data = ShipperModel.fromJson(await storage.readData(StorageCore.shipper));
        userName = data.name;
        update();
      });

      await transaction.getAccountNumber().then((value) async => await storage.saveData(
            StorageCore.accounts,
            value,
          ));

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

      allow = AllowedMenu.fromJson(await storage.readData(StorageCore.allowedMenu));

      await profil.getCcrfProfil().then((value) async {
        ccrf = value;
        update();
      });

      isCcrf = ccrf?.payload != null;
      storage.saveData(StorageCore.ccrfProfil, ccrf?.payload);
      update();
    } catch (e, i) {
      e.printError();
      i.printError();
    }
    // }

    isLoading = false;
    update();
    // if (isLogin && allow.buatPesanan != "Y" && isOnline) {
    //   menuItems.removeWhere((e) => e.title == "Input Kirimanmu");
    // }
    // if (isLogin && allow.riwayatPesanan != "Y" && isOnline) {
    //   menuItems.removeWhere((e) => e.title == "Riwayat Kiriman");
    //   menuItems.removeWhere((e) => e.title == "Draft Transaksi");
    // }
    // if (isLogin && allow.lacakPesanan != "Y" && isOnline) {
    //   menuItems.removeWhere((e) => e.title == "Lacak Kiriman");
    // }
    // if (isLogin && allow.uangCod != "Y" && isOnline) {
    //   menuItems.removeWhere((e) => e.title == "Uang_COD Kamu");
    // }
    // if (isLogin && allow.monitoringAgg != "Y" && isOnline) {
    //   menuItems.removeWhere((e) => e.title == "Pembayaran Aggregasi");
    // }
    // if (isLogin && allow.monitoringAggMinus != "Y" && isOnline) {
    //   menuItems.removeWhere((e) => e.title == "Aggregasi Minus");
    // }
    // if (isLogin && allow.cekOngkir != "Y" && isOnline) {
    //   menuItems.removeWhere((e) => e.title == "Cek Ongkir");
    // }
  }

  bool pop = false;

  bool onPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.showSnackbar(
        GetSnackBar(
          icon: const Icon(
            Icons.info,
            color: whiteColor,
          ),
          message: 'Double click back button to exit',
          isDismissible: true,
          duration: const Duration(seconds: 3),
          backgroundColor: greyColor.withOpacity(0.8),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        ),
      );
      pop = false;
      update();
      return false;
    }
    pop = true;
    update();
    return true;
  }
}

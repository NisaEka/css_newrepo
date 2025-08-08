import 'dart:convert';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherMenuCotroller extends BaseController {
  List filterList = ['Semua', 'Paketmu', 'Cek Ongkir'];
  String selectedFilter = "Semua";

  List<Items> favoritList = [];
  List<Items> paketmuList = [];
  List<Items> keuanganmuList = [];
  List<Items> otherList = [];
  List<Items> hubungiAkuList = [];

  MenuItemModel? menuData;
  MenuModel? allow = Get.arguments?['allowance'];
  bool isLogin = Get.arguments?['isLogin'] ?? false;
  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<bool> cekToken() async {
    String? token = await storage.readAccessToken();
    isLogin = token != null;
    update();
    return isLogin;
  }

  Future<void> initData() async {
    favoritList = [];
    cekToken();
    try {
      var menu = MenuItemModel.fromJson(await storage.readData(StorageCore.favoriteMenu));
      favoritList.addAll(menu.items ?? []);
      update();
    } catch (e) {
      AppLogger.e('error initData other menu $e');
    }

    paketmuList = [
      Items(
        title: "Input Kirimanmu",
        // icon: IconsConstant.add,
        icon: ImageConstant.paketmuIcon,
        isAuth: true,
        isFavorite: favoritList.where((e) => e.title == "Input Kirimanmu").isNotEmpty,
        isEdit: isEdit,
        route: "/inputKiriman",
      ),
      Items(
        title: "Riwayat Kiriman",
        // icon: IconsConstant.history,
        icon: ImageConstant.paketmuIcon,
        isAuth: true,
        isFavorite: favoritList.where((e) => e.title == "Riwayat Kiriman").isNotEmpty,
        isEdit: isEdit,
        route: "/riwayatKiriman",
      ),
      Items(
        title: "Draft Transaksi",
        // icon: IconsConstant.bookmark,
        icon: ImageConstant.paketmuIcon,
        isAuth: true,
        isFavorite: favoritList.where((e) => e.title == "Draft Transaksi").isNotEmpty,
        isEdit: isEdit,
        route: "/draftTransaksi",
      ),
      Items(
        title: "Lacak Kiriman",
        // icon: IconsConstant.search,
        icon: ImageConstant.paketmuIcon,
        isAuth: false,
        isFavorite: favoritList.where((e) => e.title == "Lacak Kiriman").isNotEmpty,
        isEdit: isEdit,
        route: "/lacakKiriman",
      ),
      Items(
          title: "Minta Dijemput",
          // icon: IconsConstant.requestPickup,
          icon: ImageConstant.paketmuIcon,
          isAuth: true,
          isFavorite: favoritList.where((e) => e.title == "Request Pickup").isNotEmpty,
          isEdit: isEdit,
          route: "/requestPickup"),
      Items(
        title: "Pantau Paketmu",
        // icon: IconsConstant.pantau,
        icon: ImageConstant.paketmuIcon,
        isAuth: true,
        isFavorite: favoritList.where((e) => e.title == "Pantau Paketmu").isNotEmpty,
        isEdit: isEdit,
        route: "/pantauPaketmu",
      ),
    ];

    keuanganmuList = [
      Items(
        title: "Pembayaran Aggregasi",
        // icon: IconsConstant.agg,
        icon: ImageConstant.keuanganmuIcon,
        isAuth: true,
        isFavorite: favoritList.where((e) => e.title == "Pembayaran Aggregasi").isNotEmpty,
        isEdit: isEdit,
        route: "/pembayaranAggregasi",
      ),
      Items(
        title: "Aggregasi Minus",
        // icon: IconsConstant.aggMinus,
        icon: ImageConstant.keuanganmuIcon,
        isAuth: true,
        isFavorite: favoritList.where((e) => e.title == "Aggregasi Minus").isNotEmpty,
        isEdit: isEdit,
        route: "/aggregasiMinus",
      ),
      Items(
        title: "Invoice",
        // icon: IconsConstant.invoice,
        icon: ImageConstant.keuanganmuIcon,
        isAuth: true,
        isFavorite: favoritList.where((e) => e.title == "Invoice").isNotEmpty,
        isEdit: isEdit,
        route: "/invoice",
      ),
    ];

    otherList = [
      Items(
        title: "Cek Ongkir",
        // icon: IconsConstant.cekOngkir,
        icon: ImageConstant.cekOngkirIcon,
        isAuth: false,
        isFavorite: favoritList.where((e) => e.title == "Cek Ongkir").isNotEmpty,
        isEdit: isEdit,
        route: "/cekOngkir",
      ),
    ];

    hubungiAkuList = [
      Items(
          title: "Laporanku",
          // icon: IconsConstant.ticket,
          icon: ImageConstant.hubungiAkuIcon,
          isAuth: true,
          isFavorite: favoritList.where((e) => e.title == "Laporanku").isNotEmpty,
          isEdit: isEdit,
          route: "/laporanku"),
      Items(
          title: "E-Claim",
          // icon: IconsConstant.eclaim,
          icon: ImageConstant.hubungiAkuIcon,
          isAuth: true,
          isFavorite: favoritList.where((e) => e.title == "E-Claim").isNotEmpty,
          isEdit: isEdit,
          route: "/eclaim"),
    ];

    update();
    cekAllowance();
  }

  void cekAllowance() {
    if (isLogin && (allow?.paketmuInput != "Y" && allow?.buatPesanan != "Y")) {
      paketmuList.removeWhere((e) => e.title == "Input Kirimanmu");
      favoritList.removeWhere((e) => e.title == "Input Kirimanmu");
    }
    if (isLogin && (allow?.paketmuRiwayat != "Y" && allow?.riwayatPesanan != "Y")) {
      paketmuList.removeWhere((e) => e.title == "Riwayat Kiriman");
      paketmuList.removeWhere((e) => e.title == "Draft Transaksi");
      favoritList.removeWhere((e) => e.title == "Riwayat Kiriman");
      favoritList.removeWhere((e) => e.title == "Draft Transaksi");
    }
    if (isLogin && (allow?.paketmuLacak != "Y" && allow?.lacakPesanan != "Y")) {
      paketmuList.removeWhere((e) => e.title == "Lacak Kiriman");
      favoritList.removeWhere((e) => e.title == "Lacak Kiriman");
    }
    if (isLogin && (allow?.keuanganCod != "Y" && allow?.uangCod != "Y")) {
      keuanganmuList.removeWhere((e) => e.title == "Uang_COD Kamu");
      favoritList.removeWhere((e) => e.title == "Uang_COD Kamu");
    }
    if (isLogin && (allow?.keuanganAggregasi != "Y" && allow?.monitoringAgg != "Y")) {
      keuanganmuList.removeWhere((e) => e.title == "Pembayaran Aggregasi");
      favoritList.removeWhere((e) => e.title == "Pembayaran Aggregasi");
    }
    if (isLogin && (allow?.keuanganAggregasiMinus != "Y" && allow?.monitoringAggMinus != "Y")) {
      keuanganmuList.removeWhere((e) => e.title == "Aggregasi Minus");
      favoritList.removeWhere((e) => e.title == "Aggregasi Minus");
    }
    if (isLogin && allow?.cekOngkir != "Y") {
      otherList.removeWhere((e) => e.title == "Cek Ongkir");
      favoritList.removeWhere((e) => e.title == "Cek Ongkir");
    }
    if (isLogin && allow?.pantauPaketmu != "Y") {
      otherList.removeWhere((e) => e.title == "Pantau Paketmu");
      favoritList.removeWhere((e) => e.title == "Pantau Paketmu");
    }
    if (isLogin && allow?.hubungiLaporan != "Y") {
      otherList.removeWhere((e) => e.title == "Laporanku");
      favoritList.removeWhere((e) => e.title == "Laporanku");
    }
    if (isLogin && (allow?.mintaDijemput != "Y" && allow?.paketmuMintadijemput != "Y")) {
      paketmuList.removeWhere((e) => e.title == "Request Pickup");
      favoritList.removeWhere((e) => e.title == "Request Pickup");
    }
    if (isLogin && (allow?.pantauPaketmu != "Y")) {
      paketmuList.removeWhere((e) => e.title == "Pantau Paketmu");
      favoritList.removeWhere((e) => e.title == "Pantau Paketmu");
    }
    if (isLogin && (allow?.keuanganTagihan != "Y")) {
      keuanganmuList.removeWhere((e) => e.title == "Invoice");
      favoritList.removeWhere((e) => e.title == "Invoice");
    }
    if (isLogin && (allow?.hubungiLaporan != "Y")) {
      hubungiAkuList.removeWhere((e) => e.title == "Laporanku");
      favoritList.removeWhere((e) => e.title == "Laporanku");
    }
    if (isLogin && (allow?.eclaim != "Y" && allow?.hubungiEclaim != "Y")) {
      hubungiAkuList.removeWhere((e) => e.title == "E-Claim");
      favoritList.removeWhere((e) => e.title == "E-Claim");
    }

    if (isLogin && (allow?.mintaDijemput != "Y" && allow?.paketmuMintadijemput != "Y")) {
      paketmuList.removeWhere((e) => e.title == "Minta Dijemput");
      favoritList.removeWhere((e) => e.title == "Minta Dijemput");
    }

    update();
  }

  void removeFavorit(int i) {
    paketmuList.where((e) => e.title == favoritList[i].title).isNotEmpty
        ? paketmuList.where((e) => e.title == favoritList[i].title).first.isFavorite = false
        : null;
    otherList.where((e) => e.title == favoritList[i].title).isNotEmpty
        ? otherList.where((e) => e.title == favoritList[i].title).first.isFavorite = false
        : null;
    hubungiAkuList.where((e) => e.title == favoritList[i].title).isNotEmpty
        ? hubungiAkuList.where((e) => e.title == favoritList[i].title).first.isFavorite = false
        : null;

    favoritList.removeAt(i);
    update();
  }

  void addFavorit(int i, Items menu) {
    if ((favoritList.where((e) => e.title == menu.title).isEmpty)) {
      if (favoritList.length < 4) {
        paketmuList.where((e) => e == menu).isNotEmpty ? paketmuList.where((e) => e == menu).first.isFavorite = true : null;
        otherList.where((e) => e == menu).isNotEmpty ? otherList.where((e) => e == menu).first.isFavorite = true : null;
        keuanganmuList.where((e) => e == menu).isNotEmpty ? keuanganmuList.where((e) => e == menu).first.isFavorite = true : null;
        hubungiAkuList.where((e) => e == menu).isNotEmpty ? hubungiAkuList.where((e) => e == menu).first.isFavorite = true : null;
        update();
        favoritList.add(menu);
      } else {
        AppSnackBar.error('Favorit tidak dapat lebih dari 4 item'.tr);
      }
    } else {
      paketmuList.where((e) => e == menu).isNotEmpty ? paketmuList.where((e) => e == menu).first.isFavorite = false : null;
      otherList.where((e) => e == menu).isNotEmpty ? otherList.where((e) => e == menu).first.isFavorite = false : null;
      keuanganmuList.where((e) => e == menu).isNotEmpty ? keuanganmuList.where((e) => e == menu).first.isFavorite = false : null;
      hubungiAkuList.where((e) => e == menu).isNotEmpty ? hubungiAkuList.where((e) => e == menu).first.isFavorite = false : null;
      update();

      favoritList.removeWhere((e) => e.title == menu.title);
    }

    update();
  }

  void saveChanges() async {
    if (isEdit == false) {
      isEdit = true;
      update();
    } else {
      isEdit = false;
      update();
      updateStorage();
    }
    update();
  }

  void updateStorage() async {
    var data = '{"items" : ${jsonEncode(favoritList)}}';
    menuData = MenuItemModel.fromJson(jsonDecode(data));
    update();
    await storage.saveData(StorageCore.favoriteMenu, menuData).then((value) {
      initData();
    });
  }

  void routeToMenu(Items menuItem, BuildContext context) {
    (menuItem.isAuth == true && !isLogin)
        ? showDialog(
            context: context,
            builder: (context) => const LoginAlertDialog(),
          )
        : Get.toNamed(menuItem.route.toString(), arguments: {});
  }
}

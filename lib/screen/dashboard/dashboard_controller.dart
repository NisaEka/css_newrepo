import 'dart:convert';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/auth/input_login_model.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_profil_model.dart';
import 'package:css_mobile/data/model/transaction/get_shipper_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/login/login_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_state.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/barcode_scan_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController {
  final state = DashboardState();

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      saveFCMToken(),
      initData(),
      loadTransCountList(),
    ]);
  }

  Future<bool> cekToken() async {
    String? token = await storage.readToken();
    debugPrint("token : $token");
    state.isLogin = token != null;
    update();

    return state.isLogin;
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
    state.menuItems = [
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
    // var stickerLabel = await storage.readString(StorageCore.transactionLabel);
    // var shipcost = await storage.readString(StorageCore.shippingCost);
    update();
    if (favMenu.isEmpty == true) {
      await storage.saveData(
        StorageCore.favoriteMenu,
        MenuItemModel(items: state.menuItems),
      );
      update();
    } else {
      state.menuItems = [];
      var menu = MenuItemModel.fromJson(jsonDecode(favMenu));
      state.menuItems.addAll(menu.items ?? []);
    }

    update();

    bool label = (await storage.readString(StorageCore.transactionLabel)).isEmpty;

    if (label) {
      await setting.getSettingLabel().then(
        (value) async {
          await storage.writeString(
            StorageCore.transactionLabel,
            value.payload?.where((e) => e.enable ?? false).first.name,
          );
          await storage.writeString(
            StorageCore.shippingCost,
            value.payload?.first.showPrice ?? false ? "PUBLISH" : "HIDE",
          );
        },
      );
    }

    update();
  }

  void cekAllowance() {
    if (state.isLogin && state.allow.paketmuInput != "Y" && state.isOnline && state.allow.buatPesanan != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Input Kirimanmu");
    }
    if (state.isLogin && state.allow.paketmuRiwayat != "Y" && state.isOnline && state.allow.riwayatPesanan != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Riwayat Kiriman");
      state.menuItems.removeWhere((e) => e.title == "Draft Transaksi");
    }
    if (state.isLogin && state.allow.paketmuLacak != "Y" && state.isOnline && state.allow.lacakPesanan != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Lacak Kiriman");
    }
    if (state.isLogin && state.allow.keuanganCod != "Y" && state.isOnline && state.allow.uangCod != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Uang_COD Kamu");
    }
    if (state.isLogin && state.allow.keuanganAggregasi != "Y" && state.isOnline && state.allow.monitoringAgg != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Pembayaran Aggregasi");
    }
    if (state.isLogin && state.allow.keuanganAggregasiMinus != "Y" && state.isOnline && state.allow.monitoringAggMinus != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Aggregasi Minus");
    }
    if (state.isLogin && state.allow.cekOngkir != "Y" && state.isOnline) {
      state.menuItems.removeWhere((e) => e.title == "Cek Ongkir");
    }
    if (state.isLogin && state.allow.pantauPaketmu != "Y" && state.isOnline) {
      state.menuItems.removeWhere((e) => e.title == "Pantau Paketmu");
    }
  }

  Future<void> cekLocalLanguage() async {
    String local = await storage.readString(StorageCore.localeApp);

    if (local.isEmpty || local == 'id_ID' || local == 'en_US') {
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

  Future<void> saveFCMToken() async {
    try {
      // String? token = await FirebaseMessaging.instance.getToken();

      state.fcmToken = await storage.readString(StorageCore.fcmToken);
      // print('fcm token : ${state.fcmToken}');
      // print('fcm token : ${token}');

      await auth
          .postFcmToken(
            await LoginController().getDeviceinfo(state.fcmToken ?? '') ?? Device(),
          )
          .then((value) async => value.code == 200
              ? await auth.updateDeviceInfo(
                  await LoginController().getDeviceinfo(state.fcmToken ?? '') ?? Device(),
                )
              : value.code == 401 || value.code == 400 || value.code == null
                  ? await auth.postFcmTokenNonAuth(
                      await LoginController().getDeviceinfo(state.fcmToken ?? '') ?? Device(),
                    )
                  : debugPrint('post device info : ${value.code}'));
    } catch (e, i) {
      e.printError();
      i.printError();
    }
  }

  Future<void> loadTransCountList() async {
    state.transCountList.clear();
    try {
      transaction.postTransactionDashboard('1722445200000 - 1725814800000', '').then(
        (value) {
          state.transCountList.addAll(value.payload ?? []);
        },
      );
    } catch (e) {
      e.printError();
    }

    update();
  }

  Future<void> initData() async {
    connection.isOnline().then((value) => state.isOnline = value);
    cekFavoritMenu();
    update();
    cekLocalLanguage();
    cekToken();
    state.isLoading = true;

    bool accounts =
        ((await storage.readString(StorageCore.accounts)).isEmpty || (await storage.readString(StorageCore.accounts)) == 'null') && state.isLogin;
    bool dropshipper =
        ((await storage.readString(StorageCore.dropshipper)).isEmpty || (await storage.readString(StorageCore.dropshipper)) == 'null') &&
            state.isLogin;
    bool receiver =
        ((await storage.readString(StorageCore.receiver)).isEmpty || (await storage.readString(StorageCore.receiver)) == 'null') && state.isLogin;
    bool sender =
        ((await storage.readString(StorageCore.shipper)).isEmpty || (await storage.readString(StorageCore.shipper)) == 'null') && state.isLogin;
    bool basic =
        ((await storage.readString(StorageCore.userProfil)).isEmpty || (await storage.readString(StorageCore.userProfil)) == 'null') && state.isLogin;
    bool ccrfP =
        ((await storage.readString(StorageCore.ccrfProfil)).isEmpty || (await storage.readString(StorageCore.ccrfProfil)) == 'null') && state.isLogin;
    update();

    try {
      if (sender) {
        await transaction.getSender().then((value) async => await storage.saveData(
              StorageCore.shipper,
              value.payload,
            ));
      }

      if (accounts) {
        await transaction.getAccountNumber().then((value) async => await storage.saveData(
              StorageCore.accounts,
              value,
            ));
      }

      if (dropshipper) {
        await transaction.getDropshipper().then((value) async => await storage.saveData(
              StorageCore.dropshipper,
              value,
            ));
      }

      if (receiver) {
        await transaction.getReceiver().then((value) async => await storage.saveData(
              StorageCore.receiver,
              value,
            ));
      }

      if (basic) {
        await profil.getBasicProfil().then((value) async => await storage.saveData(
              StorageCore.userProfil,
              value.payload,
            ));
      }

      if (ccrfP) {
        await profil.getCcrfProfil().then((value) async {
          state.ccrf = value.payload;
          await storage.saveData(StorageCore.ccrfProfil, value.payload);
        });
      } else {
        state.ccrf = CcrfProfilModel.fromJson(await storage.readData(StorageCore.ccrfProfil));
      }

      state.isCcrf = (state.ccrf != null && state.ccrf?.generalInfo?.apiStatus == "Y");
      storage.saveData(StorageCore.ccrfProfil, state.ccrf);
      await jlc.postTotalPoint().then((value) {
        if (value.status == true) {
          state.jlcPoint = value.data?.first.sisaPoint.toString();
          update();
        } else {
          state.jlcPoint = '0';
        }
      }).catchError((value) {
        debugPrint("jlc error $value");
      });
      update();
      state.ccrf = CcrfProfilModel.fromJson(await storage.readData(StorageCore.ccrfProfil));
      var shipper = ShipperModel.fromJson(await storage.readData(StorageCore.shipper));
      state.userName = shipper.name ?? '';
      state.allow = AllowedMenu.fromJson(await storage.readData(StorageCore.allowedMenu));
      update();
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    cekAllowance();
    state.isLoading = false;
    update();
  }

  bool pop = false;

  bool onPop() {
    DateTime now = DateTime.now();
    if (state.currentBackPressTime == null || now.difference(state.currentBackPressTime!) > const Duration(seconds: 2)) {
      state.currentBackPressTime = now;
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

  onLacakKiriman(bool useBarcode, String value) {
    Get.to(
      useBarcode ? const BarcodeScanScreen() : const LacakKirimanScreen(),
      arguments: {
        'nomor_resi': value,
        "cek_resi": true,
      },
    )?.then((value) {
      state.nomorResi.clear();
      update();
    });
  }
}

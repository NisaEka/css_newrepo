import 'dart:convert';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/auth/input_login_model.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/login/login_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_state.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/barcode_scan_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController {
  final state = DashboardState();

  @override
  void onInit() {
    super.onInit();

    Future.wait([
      isFirst(),
      cekToken(),
      saveFCMToken(),
      initData(),
      cekLocalLanguage(),
      loadBanner(),
      loadNews(),
    ]);
  }

  Future<void> refreshToken() async {
    if (state.isLogin) {
      await auth.postRefreshToken().then((value) async {
        debugPrint("nrToken : ${value.data?.token?.refreshToken}");

        storage.saveToken(
          value.data?.token?.accessToken ?? '',
          value.data?.menu ?? MenuModel(),
          value.data?.token?.refreshToken ?? '',
        );
      });
    } else {
      storage.deleteLogin();
    }
  }

  Future<bool> cekToken() async {
    String? aToken = await storage.readAccessToken();
    String? rToken = await storage.readRefreshToken();
    state.isLogin = aToken?.isNotEmpty ?? false;
    debugPrint("token : $aToken");
    debugPrint("rtoken : $rToken");

    refreshToken();
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

  Future<void> loadBanner() async {
    try {
      jlc.postDashboardBanner().then((value) {
        state.bannerList.addAll(value.data ?? []);
        update();
      });
    } catch (e) {
      e.printError();
    }
  }

  Future<void> loadNews() async {
    AppLogger.i('load news');
    try {
      jlc.postDashboardNews().then((value) {
        state.newsList.addAll(value.data ?? []);
        update();
      });
    } catch (e) {
      e.printError();
    }

    update();
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

    bool label =
        (await storage.readString(StorageCore.transactionLabel)).isEmpty;

    if (label) {
      await setting.getSettingLabel().then(
        (value) async {
          await storage.writeString(
            StorageCore.transactionLabel,
            value.data?.where((e) => e.enable ?? false).first.name,
          );
          await storage.writeString(
            StorageCore.shippingCost,
            value.data?.first.showPrice ?? false ? "PUBLISH" : "HIDE",
          );
        },
      );
    }

    update();
  }

  void cekAllowance() {
    if (state.isLogin &&
        state.allow.paketmuInput != "Y" &&
        state.isOnline &&
        state.allow.buatPesanan != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Input Kirimanmu");
    }
    if (state.isLogin &&
        state.allow.paketmuRiwayat != "Y" &&
        state.isOnline &&
        state.allow.riwayatPesanan != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Riwayat Kiriman");
      state.menuItems.removeWhere((e) => e.title == "Draft Transaksi");
    }
    if (state.isLogin &&
        state.allow.paketmuLacak != "Y" &&
        state.isOnline &&
        state.allow.lacakPesanan != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Lacak Kiriman");
    }
    if (state.isLogin &&
        state.allow.keuanganCod != "Y" &&
        state.isOnline &&
        state.allow.uangCod != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Uang_COD Kamu");
    }
    if (state.isLogin &&
        state.allow.keuanganAggregasi != "Y" &&
        state.isOnline &&
        state.allow.monitoringAgg != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Pembayaran Aggregasi");
    }
    if (state.isLogin &&
        state.allow.keuanganAggregasiMinus != "Y" &&
        state.isOnline &&
        state.allow.monitoringAggMinus != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Aggregasi Minus");
    }
    if (state.isLogin && state.allow.cekOngkir != "Y" && state.isOnline) {
      state.menuItems.removeWhere((e) => e.title == "Cek Ongkir");
    }
    if (state.isLogin && state.allow.pantauPaketmu != "Y" && state.isOnline) {
      state.menuItems.removeWhere((e) => e.title == "Pantau Paketmu");
    }
  }

  Future<void> cekTheme() async {
    state.themeMode = await storage.readString(StorageCore.themeMode);
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;

    if (state.themeMode.isEmpty) {
      if (brightness == Brightness.dark) {
        await storage.writeString(StorageCore.themeMode, "dark");
        ThemeMode.dark;
        Get.changeTheme(CustomTheme.dark);

        update();
      } else {
        await storage.writeString(StorageCore.themeMode, "light");
        ThemeMode.light;
        Get.changeTheme(CustomTheme.light);

        update();
      }
    } else {
      if (state.themeMode == "dark") {
        await storage.writeString(StorageCore.themeMode, "dark");
        ThemeMode.dark;
        Get.changeTheme(CustomTheme.dark);

        update();
      } else {
        await storage.writeString(StorageCore.themeMode, "light");
        ThemeMode.light;
        Get.changeTheme(CustomTheme.light);

        update();
      }
    }
  }

  Future<void> cekLocalLanguage() async {
    state.local = await storage.readString(StorageCore.localeApp);

    if (state.local.isEmpty ||
        state.local == 'id_ID' ||
        state.local == 'en_US') {
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
      if (state.local == "id") {
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
      state.fcmToken = await storage.readString(StorageCore.fcmToken);
      // print('fcm token : ${state.fcmToken}');
      // print('fcm token : ${token}');

      await auth
          .postFcmToken(
        await LoginController().getDeviceinfo(state.fcmToken ?? '') ?? Device(),
      )
          .then((value) async {
        value.code == 409
            ? await auth.updateDeviceInfo(
                await LoginController().getDeviceinfo(state.fcmToken ?? '') ??
                    Device(),
              )
            // : value.code == 401 || value.code == 400 || value.code == null
            : await auth.postFcmTokenNonAuth(
                await LoginController().getDeviceinfo(state.fcmToken ?? '') ??
                    Device(),
              );
        // : debugPrint('post device info : ${value.code}'));
        debugPrint('post device info : ${value.code}');
      });
    } catch (e, i) {
      e.printError();
      i.printError();
    }
  }

  Future<void> loadTransCountList() async {
    state.transCountList.clear();
    try {
      transaction.postTransactionDashboard(QueryParamModel()).then(
        (value) {
          state.transCountList.addAll(value.data?.summary ?? []);
          update();
        },
      );
    } catch (e) {
      e.printError();
    }

    update();
  }

  Future<void> isFirst() async {
    state.isFirst = (await storage.readString(StorageCore.isFirst)).isEmpty ||
        (await storage.readString(StorageCore.isFirst)) == 'null' ||
        (await storage.readString(StorageCore.isFirst)) == 'false';

    if (state.isFirst) {
      StorageCore().writeString(StorageCore.isFirst, "true");
    }
  }

  Future<void> initData() async {
    connection.isOnline().then((value) => state.isOnline = value);
    cekFavoritMenu();
    update();
    cekTheme();
    state.isLoading = true;

    storage.deleteString(StorageCore.transactionTemp);
    loadTransCountList();

    bool accounts = ((await storage.readString(StorageCore.accounts)).isEmpty ||
            (await storage.readString(StorageCore.accounts)) == 'null') &&
        state.isLogin;
    bool dropshipper = ((await storage.readString(StorageCore.dropshipper))
                .isEmpty ||
            (await storage.readString(StorageCore.dropshipper)) == 'null') &&
        state.isLogin;
    bool receiver = ((await storage.readString(StorageCore.receiver)).isEmpty ||
            (await storage.readString(StorageCore.receiver)) == 'null') &&
        state.isLogin;
    bool sender = ((await storage.readString(StorageCore.shipper)).isEmpty ||
            (await storage.readString(StorageCore.shipper)) == 'null') &&
        state.isLogin;
    bool basic = ((await storage.readString(StorageCore.userProfil)).isEmpty ||
            (await storage.readString(StorageCore.userProfil)) == 'null') &&
        state.isLogin;
    bool ccrfP = ((await storage.readString(StorageCore.ccrfProfil)).isEmpty ||
            (await storage.readString(StorageCore.ccrfProfil)) == 'null' ||
            (await storage.readString(StorageCore.ccrfProfil)) == '{}') &&
        state.isLogin;
    update();

    try {
      if (basic) {
        await profil.getBasicProfil().then((value) async {
          await storage.saveData(
            StorageCore.userProfil,
            value.data?.user,
          );

          if (state.basic?.language == "INDONESIA") {
            await storage.writeString(StorageCore.localeApp, "id");
            Get.updateLocale(const Locale("id", "ID"));
            update();
          } else {
            await storage.writeString(StorageCore.localeApp, "en");
            Get.updateLocale(const Locale("en", "ES"));
            update();
          }
        });
      } else {
        state.basic =
            UserModel.fromJson(await storage.readData(StorageCore.userProfil));
        update();
        if (state.basic?.language == "INDONESIA") {
          await storage.writeString(StorageCore.localeApp, "id");
          Get.updateLocale(const Locale("id", "ID"));
          update();
        } else {
          await storage.writeString(StorageCore.localeApp, "en");
          Get.updateLocale(const Locale("en", "ES"));
          update();
        }
      }

      if (sender) {
        await profil.getShipper().then((value) async {
          AppLogger.i("shipper data : ${value.data?.first.toJson()}");

          if (value.data != null) {
            await storage.saveData(
              StorageCore.shipper,
              value.data?.first,
            );
          } else {
            var s =
                UserModel.fromJson(storage.readData(StorageCore.userProfil));
            await storage.saveData(
              StorageCore.shipper,
              s,
            );
          }
        });
      }

      if (ccrfP) {
        await profil.getCcrfProfil().then((value) async {
          state.ccrf = value.data;
          await storage.saveData(StorageCore.ccrfProfil, value.data);
        });
      } else {
        state.ccrf = CcrfProfileModel.fromJson(
            await storage.readData(StorageCore.ccrfProfil));
      }

      if (accounts) {
        await master.getAccounts().then((value) async => await storage.saveData(
              StorageCore.accounts,
              value,
            ));
      }

      if (dropshipper) {
        await master
            .getDropshippers(QueryParamModel())
            .then((value) async => await storage.saveData(
                  StorageCore.dropshipper,
                  value,
                ));
      }

      if (receiver) {
        await master
            .getReceivers(QueryParamModel())
            .then((value) async => await storage.saveData(
                  StorageCore.receiver,
                  value,
                ));
      }

      state.isCcrf =
          (state.ccrf != null && state.ccrf?.generalInfo?.ccrfApistatus == "Y");

      storage.saveData(StorageCore.ccrfProfil, state.ccrf);
      // #TODO : implement jlc api
      // await jlc.postTotalPoint().then((value) {
      //   if (value.status == true) {
      //     state.jlcPoint = value.data?.first.sisaPoint.toString();
      //     update();
      //   } else {
      //     state.jlcPoint = '0';
      //   }
      // }).catchError((value) {
      //   debugPrint("jlc error $value");
      // });
      update();
      UserModel shipper =
          UserModel.fromJson(await storage.readData(StorageCore.userProfil));
      state.userName = shipper.name ?? '';
      state.allow =
          MenuModel.fromJson(await storage.readData(StorageCore.userMenu));
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
    if (state.currentBackPressTime == null ||
        now.difference(state.currentBackPressTime!) >
            const Duration(seconds: 2)) {
      state.currentBackPressTime = now;
      AppSnackBar.custom(
        message: 'Double click back button to exit',
        backgroundColor: greyColor.withOpacity(0.8),
        icon: const Icon(
          Icons.info,
          color: whiteColor,
        ),
        durationInSeconds: 3,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.GROUNDED,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        padding: const EdgeInsets.all(10),
        messageText: null,
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

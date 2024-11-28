import 'dart:async';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/auth/get_device_info_model.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
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

  // Timer? _tokenRefreshTimer;

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      isFirst(),
      cekToken(),
      initData(),
      cekLocalLanguage(),
      loadBanner(),
      loadNews(),
    ]);
  }

  @override
  void onClose() {
    // _tokenRefreshTimer
    //     ?.cancel(); // Cancel the timer when the controller is disposed
    super.onClose();
  }

  // void startTokenRefreshScheduler() {
  //   // Cancel any existing timer
  //   _tokenRefreshTimer?.cancel();
  //
  //   // Schedule the refreshToken method to run every 2 hours
  //   _tokenRefreshTimer = Timer.periodic(
  //     const Duration(hours: 2), // Set duration to 2 hours
  //     (timer) {
  //       refreshToken();
  //     },
  //   );
  // }

  Future<void> refreshToken() async {
    if (state.isLogin) {
      await auth.postRefreshToken().then((value) async {
        AppLogger.i('refresh token : ${value.data?.token?.refreshToken}');

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
    AppLogger.i('token : $aToken');
    AppLogger.i('rtoken : $rToken');

    refreshToken();
    update();

    return state.isLogin;
  }

  void loadMenu() async {
    AppSnackBar.success('test cek fav menu');
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
    try {
      jlc.postDashboardNews().then((value) {
        state.newsList.addAll(value.data ?? []);
        update();
      });
    } catch (e, i) {
      AppLogger.e('error loadNews $e, $i');
    }

    update();
  }

  Future<void> cekFavoritMenu() async {
    state.menuItems = [
      Items(
        title: "Input Kirimanmu",
        icon: IconsConstant.add,
        route: "/inputKiriman",
        isFavorite: true,
        isEdit: false,
        isAuth: true,
      ),
      Items(
        title: "Cek Ongkir",
        icon: IconsConstant.cekOngkir,
        route: "/cekOngkir",
        isFavorite: true,
        isEdit: false,
        isAuth: false,
      ),
      Items(
        title: "Draft Transaksi",
        icon: IconsConstant.bookmark,
        route: "/draftTransaksi",
        isFavorite: true,
        isEdit: false,
        isAuth: true,
      ),
      Items(
        title: "Riwayat Kiriman",
        icon: IconsConstant.history,
        route: "/riwayatKiriman",
        isFavorite: true,
        isEdit: false,
        isAuth: true,
      ),
    ];
    var favMenu = await storage.readData(StorageCore.favoriteMenu);
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
      var menu = MenuItemModel.fromJson(favMenu);
      state.menuItems.addAll(menu.items ?? []);
    }

    update();

    bool label =
        (await storage.readString(StorageCore.transactionLabel)).isEmpty;

    if (label && state.isLogin) {
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

      await auth
          .postFcmToken(
        await LoginController().getDeviceinfo(state.fcmToken ?? '') ??
            DeviceModel(),
      )
          .then((value) async {
        AppLogger.i('userID : ${state.basic?.id}');
        value.code == 409
            ? await auth.updateDeviceInfo(
                (await LoginController().getDeviceinfo(state.fcmToken ?? ''))
                        ?.copyWith(registrationId: state.basic?.id) ??
                    DeviceModel(),
              )
            : value.code == 401
                ? await auth
                    .postFcmTokenNonAuth(
                      await LoginController()
                              .getDeviceinfo(state.fcmToken ?? '') ??
                          DeviceModel(),
                    )
                    .then((v) async => v.code == 409
                        ? await auth.updateDeviceInfo(
                            await LoginController()
                                    .getDeviceinfo(state.fcmToken ?? '') ??
                                DeviceModel(),
                          )
                        : null)
                : null;
      });
    } catch (e, i) {
      AppLogger.e('error saveFCMToken $e, $i');
    }
  }

  Future<void> loadTransCountList() async {
    state.transCountList.clear();

    if (state.isLogin) {
      try {
        transaction.postTransactionDashboard(QueryParamModel()).then(
          (value) {
            state.transSummary = value.data;
            state.transCountList.addAll(value.data?.summary ?? []);
            update();
          },
        );
      } catch (e) {
        e.printError();
      }
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
        ((await storage.readString(StorageCore.accounts)) == 'null'));
    bool dropshipper =
        ((await storage.readString(StorageCore.dropshipper)).isEmpty ||
            (await storage.readString(StorageCore.dropshipper)) == 'null');
    bool receiver = ((await storage.readString(StorageCore.receiver)).isEmpty ||
        (await storage.readString(StorageCore.receiver)) == 'null');
    // bool sender = ((await storage.readString(StorageCore.shipper)).isEmpty || (await storage.readString(StorageCore.shipper)) == 'null');
    bool basic = ((await storage.readString(StorageCore.basicProfile))
                .isEmpty ||
            (await storage.readString(StorageCore.basicProfile)) == 'null') &&
        state.isLogin;
    bool ccrfP = ((await storage.readString(StorageCore.ccrfProfile)).isEmpty ||
        (await storage.readString(StorageCore.ccrfProfile)) == 'null' ||
        (await storage.readString(StorageCore.ccrfProfile)) == '{}');
    update();
    state.basic =
        UserModel.fromJson(await storage.readData(StorageCore.basicProfile));
    saveFCMToken();

    try {
      if (basic) {
        await profil.getBasicProfil().then((value) async {
          await storage.saveData(StorageCore.basicProfile, value.data?.user);
          state.basic = UserModel.fromJson(
              await storage.readData(StorageCore.basicProfile));
          saveFCMToken();

          await storage.saveData(
              StorageCore.shipper,
              ShipperModel(
                name: value.data?.user?.brand,
                phone: value.data?.user?.phone,
                address: value.data?.user?.address,
                zipCode: value.data?.user?.zipCode,
                city: value.data?.user?.origin?.originName,
                origin: value.data?.user?.origin,
                country: value.data?.user?.language,
                region: value.data?.user?.origin?.branch?.regional,
              ));

          if (state.basic?.language == "INDONESIA") {
            await storage.writeString(StorageCore.localeApp, "id");
            Get.updateLocale(const Locale("id", "ID"));
            update();
          } else if (state.basic?.language == "ENGLISH") {
            await storage.writeString(StorageCore.localeApp, "en");
            Get.updateLocale(const Locale("en", "ES"));
            update();
          }
        });
      } else {
        update();
        if (state.basic?.language == "INDONESIA") {
          await storage.writeString(StorageCore.localeApp, "id");
          Get.updateLocale(const Locale("id", "ID"));
          update();
        } else if (state.basic?.language == "ENGLISH") {
          await storage.writeString(StorageCore.localeApp, "en");
          Get.updateLocale(const Locale("en", "ES"));
          update();
        }
      }

      if (ccrfP && state.isLogin) {
        await profil.getCcrfProfil().then((value) async {
          state.ccrf = value.data;
          await storage.saveData(StorageCore.ccrfProfile, value.data);
        });
      } else {
        state.ccrf = CcrfProfileModel.fromJson(
            await storage.readData(StorageCore.ccrfProfile));
      }

      if (accounts && state.isLogin) {
        await master
            .getAccounts(QueryModel(limit: 0, sort: [
              {"accountNumber": "asc"}
            ]))
            .then((value) async => await storage.saveData(
                  StorageCore.accounts,
                  value,
                ));
      }

      if (dropshipper && state.isLogin) {
        await master
            .getDropshippers(QueryParamModel())
            .then((value) async => await storage.saveData(
                  StorageCore.dropshipper,
                  value,
                ));
      }

      if (receiver && state.isLogin) {
        await master
            .getReceivers(QueryParamModel())
            .then((value) async => await storage.saveData(
                  StorageCore.receiver,
                  value,
                ));
      }

      state.isCcrf =
          (state.ccrf != null && state.ccrf?.generalInfo?.apiStatus == "Y");

      storage.saveData(StorageCore.ccrfProfile, state.ccrf);

      if (state.isLogin) {
        await jlc.postTotalPoint().then((value) {
          if (value.data != null && value.data!.isNotEmpty) {
            state.jlcPoint = value.data!.first.sisaPoint.toString();
            update();
          } else {
            state.jlcPoint = '0';
          }
        }).catchError((value) {
          debugPrint("jlc error $value");
        });
        update();
      }

      UserModel shipper =
          UserModel.fromJson(await storage.readData(StorageCore.basicProfile));
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

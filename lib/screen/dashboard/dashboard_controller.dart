import 'dart:async';
import 'package:collection/collection.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/data/model/auth/get_device_info_model.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_news_model.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/notification/get_notification_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/model/transaction/dashboard_kiriman_kamu_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/login/login_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_state.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/barcode_scan_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_screen.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
import 'package:css_mobile/widgets/dialog/safety_tips_dialog.dart';
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
      initData(),
      cekLocalLanguage(),
      loadPromo(),
      loadNews(),
      getAggregation(),
      getAggregationMinus(),
      getBanners(),
    ]);
  }

  Future<void> cekMessages() async {
    state.unreadNotifList = [];

    var unread = GetNotificationModel.fromJson(await storage.readData(StorageCore.unreadMessage));
    state.unreadNotifList.addAll(unread.payload ?? []);
    update();
  }

  Future<void> getBanners() async {
    state.bannerList = [];
    update();
    try {
      await master
          .getAppsInfo(QueryModel(
        table: true,
        limit: 0,
        where: [
          {"infoStatus": "on"},
          {"infoCategory": "INFORMASI COMMERCIAL - CSS CUSTOMER MOBILE"}
        ],
        sort: [
          {"infoCreateddate": "desc"}
        ],
      ))
          .then((banners) {
        state.bannerList.addAll(banners.data ?? []);
        state.bannerList.forEachIndexed(
          (index, banner) {
            if ((banner.region != "ALL" && banner.region != state.basic?.origin?.branch?.regionalCode) ||
                (banner.branch != "ALL" && banner.region != state.basic?.origin?.branch?.branchCode) ||
                (banner.origin != "ALL" && banner.region != state.basic?.origin?.originCode)) {
              state.bannerList.removeAt(index);
            }
          },
        );
        update();
      });
    } catch (e, i) {
      AppLogger.e("error get banners : $e $i");
    }
  }

  Future<bool> cekToken() async {
    String? aToken = await storage.readAccessToken();
    String? rToken = await storage.readRefreshToken();
    state.isLogin = aToken?.isNotEmpty ?? false;
    AppLogger.i('token : $aToken');
    AppLogger.i('rtoken : $rToken');

    update();

    return state.isLogin;
  }

  void loadMenu() async {
    AppSnackBar.success('test cek fav menu');
  }

  Future<void> loadPromo() async {
    state.promoList.clear();

    try {
      jlc.postDashboardBanner().then((value) {
        if (value.code == 200) {
          state.promoList.addAll(value.data ?? []);
          update();
        } else {
          // state.promoList.add(BannerModel());
          state.promoList.clear();
        }
      });
    } catch (e) {
      AppLogger.e('error load promo : $e');
      state.promoList.clear();

      update();
    }
  }

  Future<void> loadNews() async {
    state.newsList.clear();
    if (state.isOnline) {
      try {
        jlc.postDashboardNews().then((value) {
          AppLogger.i('respon news : ${value.toJson()}');
          if (value.code == 200) {
            state.newsList.addAll(value.data ?? []);
            update();
          } else {
            state.newsList.add(NewsModel());
          }
        });
      } catch (e, i) {
        AppLogger.e('error loadNews $e, $i');
        state.newsList.add(NewsModel());
        update();
      }
    } else {
      state.newsList.add(NewsModel());
    }

    update();
  }

  void onAddTransaction(BuildContext context) {
    state.isLogin
        ? Get.to(() => const InformasiPengirimScreen(), arguments: {})
        : showDialog(
            context: context,
            builder: (context) => const LoginAlertDialog(),
          );
  }

  Future<void> cekFavoritMenu() async {
    state.menuItems = [
      Items(
        title: "Input Kirimanmu",
        // icon: IconsConstant.add,
        icon: ImageConstant.paketmuIcon,
        route: "/inputKiriman",
        isFavorite: true,
        isEdit: false,
        isAuth: true,
      ),
      Items(
        title: "Cek Ongkir",
        // icon: IconsConstant.cekOngkir,
        icon: ImageConstant.cekOngkirIcon,
        route: "/cekOngkir",
        isFavorite: true,
        isEdit: false,
        isAuth: false,
      ),
      Items(
        title: "Draft Transaksi",
        // icon: IconsConstant.bookmark,
        icon: ImageConstant.paketmuIcon,
        route: "/draftTransaksi",
        isFavorite: true,
        isEdit: false,
        isAuth: true,
      ),
      Items(
        title: "Riwayat Kiriman",
        // icon: IconsConstant.history,
        icon: ImageConstant.paketmuIcon,
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
    //
    // bool label =
    //     (await storage.readString(StorageCore.transactionLabel)).isEmpty;

    // if (state.isLogin) {
    //   await setting.getSettingLabel().then(
    //     (value) async {
    //       await storage.writeString(
    //         StorageCore.transactionLabel,
    //         value.data?.labels?.where((e) => e.enabled ?? false).first.name,
    //       );
    //       await storage.writeString(
    //         StorageCore.shippingCost,
    //         value.data?.priceLabel != '0' ? "PUBLISH" : "HIDE",
    //       );
    //     },
    //   );
    // }
    //
    // update();
  }

  void cekAllowance() {
    AppLogger.w("allowance : ${state.allow.toJson()}");
    if (state.isLogin && state.allow.paketmuInput != "Y" && state.allow.buatPesanan != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Input Kirimanmu");
    }
    if (state.isLogin && state.allow.paketmuRiwayat != "Y" && state.allow.riwayatPesanan != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Riwayat Kiriman");
      state.menuItems.removeWhere((e) => e.title == "Draft Transaksi");
    }
    if (state.isLogin && state.allow.paketmuLacak != "Y" && state.allow.lacakPesanan != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Lacak Kiriman");
    }
    if (state.isLogin && state.allow.keuanganCod != "Y" && state.allow.uangCod != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Uang_COD Kamu");
    }
    if (state.isLogin && state.allow.keuanganAggregasi != "Y" && state.allow.monitoringAgg != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Pembayaran Aggregasi");
    }
    if (state.isLogin && state.allow.keuanganAggregasiMinus != "Y" && state.allow.monitoringAggMinus != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Aggregasi Minus");
    }
    if (state.isLogin && state.allow.cekOngkir != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Cek Ongkir");
    }
    if (state.isLogin && state.allow.pantauPaketmu != "Y") {
      state.menuItems.removeWhere((e) => e.title == "Pantau Paketmu");
    }
  }

  Future<void> cekTheme() async {
    state.themeMode = await storage.readString(StorageCore.themeMode);
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;

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

    if (state.local.isEmpty || state.local == 'id_ID' || state.local == 'en_US') {
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
        await LoginController().getDeviceinfo(state.fcmToken ?? '') ?? DeviceInfoModel(),
      )
          .then((value) async {
        AppLogger.i('userID : ${state.basic?.id}');
        value.code == 409
            ? await auth.updateDeviceInfo(
                (await LoginController().getDeviceinfo(state.fcmToken ?? ''))?.copyWith(registrationId: state.basic?.id) ?? DeviceInfoModel(),
              )
            : value.code == 401
                ? await auth
                    .postFcmTokenNonAuth(
                      await LoginController().getDeviceinfo(state.fcmToken ?? '') ?? DeviceInfoModel(),
                    )
                    .then((v) async => v.code == 409
                        ? await auth.updateDeviceInfo(
                            await LoginController().getDeviceinfo(state.fcmToken ?? '') ?? DeviceInfoModel(),
                          )
                        : null)
                : null;
      });
    } catch (e, i) {
      AppLogger.e('error saveFCMToken $e, $i');
    }
  }

  Future<void> loadPantauCountList() async {
    state.isLoadingKiriman = true;
    state.kirimanKamu = DashboardKirimanKamuModel();
    update();
    if (state.isLogin && state.isOnline) {
      try {
        var pantau = await transaction.getPantauCount(QueryModel(
          table: true,
          between: [
            {
              "awbDate": [
                DateTime.now().subtract(const Duration(days: 6)).copyWith(hour: 0, minute: 0, second: 0),
                DateTime.now(),
              ]
            }
          ],
        ));

        pantau.data?.forEach((item) {
          if (item.status == 'Total Kiriman') {
            state.kirimanKamu.totalKiriman = item.totalCod + item.totalCodOngkir + item.totalNonCod;
            for (var chart in item.chart) {
              state.kirimanKamu.lineChart.add(chart.y);
            }
            state.kirimanKamu.totalCod = item.totalCod;
            state.kirimanKamu.codAmount = item.codAmount;
            state.kirimanKamu.totalCodOngkir = item.totalCodOngkir;
            state.kirimanKamu.codOngkirAmount = item.codOngkirAmount;
            state.kirimanKamu.totalNonCod = item.totalNonCod;
            state.kirimanKamu.nonCodAmount = item.ongkirNonCodAmount;
          }

          if (item.status == 'Dalam Proses') {
            state.kirimanKamu.onProcess = item.totalCod + item.totalCodOngkir + item.totalNonCod;
          }

          if (item.status == 'Sukses Diterima') {
            state.kirimanKamu.suksesDiterima = item.totalCod + item.totalCodOngkir + item.totalNonCod;
          }

          if (item.status == 'Dibatalkan Oleh Kamu') {
            state.kirimanKamu.totalCancel = item.totalCod + item.totalCodOngkir + item.totalNonCod;
          }
        });
        state.kirimanKamu.calculatePercentages();
      } catch (e, i) {
        AppLogger.e('error pantau count :$e');
        AppLogger.e('error pantau count :$i');
      } finally {
        state.isLoadingKiriman = false;
        update();
      }
    }
    state.isLoadingKiriman = false;
    update();
  }

  Future<void> loadTransCountList(bool isKirimanCOD) async {
    state.isLoadingKirimanCOD = isKirimanCOD;
    state.kirimanKamuCOD = DashboardKirimanKamuModel();
    state.transSummary = null;
    List<num> charts = [0, 0, 0, 0, 0, 0, 0, 0];
    update();
    if (state.isLogin && state.isOnline) {
      try {
        transaction.postTransactionDashboard(QueryModel()).then(
          (value) {
            state.transSummary = value.data;
            update();

            value.data?.summary?.forEach((item) {
              if (item.status == 'Jumlah Transaksi') {
                state.kirimanKamuCOD.totalKiriman =
                    (value.data?.totalKirimanCod?.codAmount?.toInt() ?? 0) + (value.data?.totalKirimanCod?.codOngkirAmount?.toInt() ?? 0);
              }

              if (item.status == 'Belum Terkumpul') {
                state.kirimanKamuCOD.onProcess = ((item.totalCod?.toInt() ?? 0));
                item.chart?.forEachIndexed(
                  (index, element) {
                    charts[index] += element.y;
                  },
                );
              }

              if (item.status == 'Sukses Diterima') {
                state.kirimanKamuCOD.suksesDiterima = ((item.totalCod?.toInt() ?? 0));
                item.chart?.forEachIndexed(
                  (index, element) {
                    charts[index] += element.y;
                  },
                );
              }

              if (item.status == 'Sudah Kembali') {
                item.chart?.forEachIndexed(
                  (index, element) {
                    charts[index] += element.y;
                  },
                );
              }

              if (item.status == 'Dibatalkan') {
                state.kirimanKamuCOD.totalCancel = ((item.totalCod?.toInt() ?? 0));
                state.kirimanKamuCOD.totalNonCod = ((item.totalCod?.toInt() ?? 0));
                state.kirimanKamuCOD.nonCodAmount = item.codAmount?.toInt() ?? 0;
                item.chart?.forEachIndexed(
                  (index, element) {
                    charts[index] += element.y;
                  },
                );
              }

              if (item.status == 'Butuh di Cek') {
                state.kirimanKamuCOD.totalCod = ((item.totalCod?.toInt() ?? 0));
                state.kirimanKamuCOD.codAmount = item.codAmount?.toInt() ?? 0;
                item.chart?.forEachIndexed(
                  (index, element) {
                    charts[index] += element.y;
                  },
                );
              }

              if (item.status == 'Dalam Peninjauan') {
                state.kirimanKamuCOD.totalCodOngkir = ((item.totalCod?.toInt() ?? 0));
                state.kirimanKamuCOD.codAmount = item.codAmount?.toInt() ?? 0;
                item.chart?.forEachIndexed(
                  (index, element) {
                    charts[index] += element.y;
                  },
                );
              }
            });
            state.kirimanKamuCOD.lineChart = charts;
            state.kirimanKamuCOD.calculatePercentages();
          },
        );
        update();
      } catch (e, i) {
        AppLogger.e('error loadTransCountList $e');
        AppLogger.e('error loadTransCountList $i');
      }
      await Future.delayed(const Duration(seconds: 2));
      state.isLoadingKirimanCOD = false;
      update();
    }
  }

  Future<void> isFirst() async {
    state.isFirstInstall = (await storage.readString(StorageCore.isFirstInstall)).isEmpty ||
        (await storage.readString(StorageCore.isFirstInstall)) == 'null' ||
        (await storage.readString(StorageCore.isFirstInstall)) == 'false';

    if (state.isFirstInstall) {
      StorageCore().writeString(StorageCore.isFirstInstall, "true");
    }
  }

  Future<void> initData() async {
    connection.isOnline().then((value) => state.isOnline = value);
    cekMessages();
    cekFavoritMenu();

    update();
    cekTheme();
    state.isLoading = true;

    storage.deleteString(StorageCore.transactionTemp);

    update();

    bool accounts = ((await storage.readString(StorageCore.accounts)).isEmpty || ((await storage.readString(StorageCore.accounts)) == 'null'));
    bool dropshipper = ((await storage.readString(StorageCore.dropshipper)).isEmpty || (await storage.readString(StorageCore.dropshipper)) == 'null');
    bool receiver = ((await storage.readString(StorageCore.receiver)).isEmpty || (await storage.readString(StorageCore.receiver)) == 'null');
    // bool sender = ((await storage.readString(StorageCore.shipper)).isEmpty || (await storage.readString(StorageCore.shipper)) == 'null');
    bool basic = ((await storage.readString(StorageCore.basicProfile)).isEmpty || (await storage.readString(StorageCore.basicProfile)) == 'null') &&
        state.isLogin;
    bool officer =
        ((await storage.readString(StorageCore.officerProfile)).isEmpty || (await storage.readString(StorageCore.officerProfile)) == 'null');
    bool ccrfP = ((await storage.readString(StorageCore.ccrfProfile)).isEmpty ||
        (await storage.readString(StorageCore.ccrfProfile)) == 'null' ||
        (await storage.readString(StorageCore.ccrfProfile)) == '{}');
    update();
    var basicProfile = await storage.readString(StorageCore.basicProfile);
    if (basicProfile != 'null' && basicProfile.isNotEmpty) {
      state.basic = UserModel.fromJson(await storage.readData(StorageCore.basicProfile));
    }
    saveFCMToken();

    if (state.isLogin) {
      final accessToken = await StorageCore().readAccessToken();
      final refreshToken = await StorageCore().readRefreshToken();
      if (accessToken == null && refreshToken == null) {
        StorageCore().deleteLogin();
        Get.offAll(() => const DashboardScreen());
      }
    }

    try {
      if (basic) {
        try {
          await profil.getBasicProfil().then((value) async {
            AppLogger.i("get basic : ${value.data?.toJson()}");
            await storage.saveData(
              StorageCore.basicProfile,
              value.data?.user,
            );
            state.basic = UserModel.fromJson(await storage.readData(StorageCore.basicProfile));
            state.allow = value.data?.menu ?? MenuModel();
            storage.saveData(StorageCore.userMenu, value.data?.menu);
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
                  region: value.data?.user?.origin?.branch?.region,
                ));

            if (state.basic?.userType != "PEMILIK" && officer) {
              await setting.getOfficerByID(state.basic?.id ?? '').then(
                (value) async {
                  await storage.saveData(StorageCore.officerProfile, value.data);
                },
              );
            }

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
        } catch (e, i) {
          AppLogger.e('error get basic $e');
          AppLogger.e('error get basic $i');
        }
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
        state.ccrf = CcrfProfileModel.fromJson(await storage.readData(StorageCore.ccrfProfile));
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
        await master.getDropshippers(QueryModel(limit: 0)).then((value) async => await storage.saveData(
              StorageCore.dropshipper,
              value,
            ));
      }

      if (receiver && state.isLogin) {
        await master.getReceivers(QueryModel(limit: 0)).then((value) async => await storage.saveData(
              StorageCore.receiver,
              value,
            ));
      }

      state.isCcrf = (state.ccrf != null && state.ccrf?.generalInfo?.apiStatus == "Y");

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
    } catch (e, i) {
      AppLogger.e("error dashboard init : $e");
      AppLogger.e("error dashboard init : $i");
    }
    UserModel shipper = UserModel.fromJson(await storage.readData(StorageCore.basicProfile));
    state.userName = shipper.name ?? '';
    state.allow = MenuModel.fromJson(await storage.readData(StorageCore.userMenu));
    update();
    cekAllowance();
    state.isLoading = false;
    update();

    loadPantauCountList();
    loadTransCountList(true);
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
          message: 'Ketuk dua kali untuk keluar'.tr,
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
      useBarcode ? () => const BarcodeScanScreen() : () => const LacakKirimanScreen(),
      arguments: {
        'nomor_resi': value,
        "cek_resi": true,
      },
    )?.then((value) {
      state.nomorResi.clear();
      update();
    });
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // AppLogger.i('shipper info : ${state.shipper?.zipCode?.isEmpty}');
      if ((state.isFromLogin == true)) {
        // if (state.shipperZipCode.text.isEmpty || state.shipperAddress.text.isEmpty) {
        await Get.dialog(const SafetyTipsDialog());
      }
    });
  }

  Future<void> getAggregation() async {
    var date = await storage.readString(StorageCore.lastAgg);
    state.isLoadAggregation = true;
    state.aggregationModel = null;
    update();
    AppLogger.d("last date : $date");
    if (date.isNotEmpty) {
      try {
        final agg = await aggregation.getAggregationTotal(QueryModel(
          limit: 0,
          between: [
            {
              "mpayWdrGrpPayDatePaid": [
                // "2024-12-16 00:00:00", "2024-12-16 23:59:59",
                date.toDate(originFormat: "yyyy-MM-dd hh:mm:ss")?.subtract(const Duration(hours: 24)).toIso8601String(),
                date,
              ]
            }
          ],
          sort: [
            {"mpayWdrGrpPayDatePaid": "desc"}
          ],
        ));

        state.aggregationModel = AggregationModel(mpayWdrGrpPayNetAmt: agg.data?.total);
      } catch (e, i) {
        AppLogger.e("error get aggregation dashboard : $e");
        AppLogger.e("error get aggregation dashboard : $i");
      }
    }
    state.isLoadAggregation = false;
    update();
  }

  Future<void> getAggregationMinus() async {
    int totalAggMinus = 0;
    try {
      final aggregations = await aggregation.getAggregationMinus(QueryModel(
        limit: 0,
        sort: [
          {"createddtm": "desc"}
        ],
      ));
      aggregations.data?.forEach((e) {
        totalAggMinus += e.netAmt;
      });
      state.aggregationMinus = AggregationMinusModel(netAmt: totalAggMinus);
    } catch (e, i) {
      AppLogger.e("error get aggregation minus : $e $i");
    }

    update();
  }
}

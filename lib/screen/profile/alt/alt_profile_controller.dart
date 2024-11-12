import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/bottombar_controller.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';

import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/facility_screen.dart';
import 'package:css_mobile/widgets/dialog/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AltProfileController extends BaseController {
  final HideNavbar bottom = HideNavbar();

  bool isLogin = false;
  bool isEdit = false;
  bool pop = false;
  bool isLoading = false;

  UserModel? basicProfil;
  String? version;
  MenuModel menuModel = MenuModel();
  CcrfProfileModel? ccrf;
  bool isCcrf = false;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData(), getCcrf()]);
  }

  bool onPop() {
    // DateTime now = DateTime.now();
    // if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
    //   currentBackPressTime = now;
    //   Get.showSnackbar(
    //     GetSnackBar(
    //       icon: const Icon(
    //         Icons.info,
    //         color: whiteColor,
    //       ),
    //       message: 'Double click back button to exit',
    //       isDismissible: true,
    //       duration: const Duration(seconds: 3),
    //       backgroundColor: greyColor.withOpacity(0.8),
    //       padding: const EdgeInsets.all(10),
    //       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
    //     ),
    //   );
    //   pop = false;
    //   update();
    //   return false;
    // }
    pop = true;
    update();
    Get.off(const DashboardScreen());
    return true;
  }

  Future<void> initData() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    isLoading = true;
    update();

    try {
      String? token = await storage.readToken();
      debugPrint("token : $token");
      isLogin = token != null;
      // if (await storage.readData(StorageCore.userProfil) == null) {
      await profil.getBasicProfil().then((value) async {
        basicProfil = value.data?.user;
        update();
      });
      // }
    } catch (e, i) {
      e.printError();
      i.printError();
      basicProfil = UserModel.fromJson(
        await storage.readData(StorageCore.userProfil),
      );
    }

    menuModel =
        MenuModel.fromJson(await storage.readData(StorageCore.userMenu));
    update();

    isLoading = false;
    update();
  }

  Future<void> getCcrf() async {
    // bool ccrfProfile = await storage.readString(StorageCore.ccrfProfil) == null;
    try {
      // if (ccrfProfile) {
      await profil.getCcrfProfil().then((value) {
        ccrf = value.data;
        update();
      });
      // }
    } catch (e) {
      e.printError();
    }

    isCcrf = ccrf != null && ccrf?.generalInfo?.ccrfApistatus == "Y";
    update();
  }

  void doLogout() async {
    isLoading = true;
    update();
    await auth
        .logout(
            // Device(
            //   fcmToken: await storage.readString(StorageCore.fcmToken),
            // ),
            )
        .then((value) {
      // if (value.code == 201) {
      storage.deleteLogin();
      storage.deleteString(StorageCore.favoriteMenu);
      Get.offAll(const LoginScreen());
      // }
    });
    isLoading = false;
    update();
  }

  void isCcrfAction(dynamic screen, BuildContext context) {
    isCcrf
        ? Get.to(screen)
        : showDialog(
            context: context,
            builder: (context) => InfoDialog(
              infoText:
                  "Untuk mengakses menu ini silahkan aktifkan terlebih dahulu di menu fasilitas"
                      .tr,
              nextButton: () => Get.off(const FacilityScreen()),
            ),
          );
  }
}

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/bottombar_controller.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/profile/get_basic_profil_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_profil_model.dart';
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

  BasicProfilModel? basicProfil;
  String? version;
  AllowedMenu allow = AllowedMenu();
  GetCcrfProfilModel? ccrf;
  bool isCcrf = false;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData(), getCcrf()]);
  }

  bool onPop() {
    DateTime now = DateTime.now();
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

    try {
      String? token = await storage.readToken();
      debugPrint("token : $token");
      isLogin = token != null;
      await profil.getBasicProfil().then((value) async {
        basicProfil = value.payload;
        update();
      });

      allow = AllowedMenu.fromJson(await storage.readData(StorageCore.allowedMenu));
      update();
    } catch (e, i) {
      e.printError();
      i.printError();
      basicProfil = BasicProfilModel.fromJson(
        await storage.readData(StorageCore.userProfil),
      );
    }

    update();
  }

  Future<void> getCcrf() async {
    try {
      await profil.getCcrfProfil().then((value) {
        ccrf = value;
        update();
      });
    } catch (e) {
      e.printError();
    }

    isCcrf = ccrf?.payload != null;
    update();
  }

  void doLogout() async {
    storage.deleteToken();
    storage.deleteString(StorageCore.favoriteMenu);
    Get.offAll(const LoginScreen());
  }

  void isCcrfAction(dynamic screen, BuildContext context) {
    isCcrf
        ? Get.to(screen)
        : showDialog(
            context: context,
            builder: (context) => InfoDialog(
              infoText: "Untuk mengakses menu ini silahkan aktifkan terlebih dahulu di menu fasilitas".tr,
              nextButton: () => Get.off(const FacilityScreen()),
            ),
          );
  }
}

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/bottombar_controller.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';

import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_screen.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/facility_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
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
    pop = true;
    update();
    Get.delete<DashboardController>().then(
      (_) => Get.offAll(const DashboardScreen()),
    );
    return true;
  }

  Future<void> sendEmail() async {
    try {
      await auth.postEmailForgotPassword(basicProfil?.email ?? '').then((value) => value.code == 201
          ? Get.to(
              const ForgotPasswordOTPScreen(),
              arguments: {
                'email': basicProfil?.email ?? '',
                'isChange': true,
              },
            )
          : value.code == 404
              ? AppSnackBar.error('User Not Found'.tr)
              : AppSnackBar.error('Bad Request'.tr));
    } catch (e) {
      AppLogger.e('error sendEmail $e');
    }
  }

  Future<void> initData() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    isLoading = true;
    update();

    try {
      String? token = await storage.readAccessToken();
      AppLogger.i('token : $token');
      isLogin = token != null;
      // if (await storage.readData(StorageCore.userProfil) == null) {
      await profil.getBasicProfil().then((value) async {
        basicProfil = value.data?.user;
        update();
      });
      // }
    } catch (e, i) {
      AppLogger.e('error initData alt profile $e, $i');
      basicProfil = UserModel.fromJson(
        await storage.readData(StorageCore.basicProfile),
      );
    }

    menuModel = MenuModel.fromJson(await storage.readData(StorageCore.userMenu));
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
      AppLogger.e('error getCcrf', e);
    }

    isCcrf = ccrf != null && ccrf?.generalInfo?.apiStatus == "Y";
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
              infoText: "Untuk mengakses menu ini silahkan aktifkan terlebih dahulu di menu fasilitas".tr,
              nextButton: () => Get.off(const FacilityScreen()),
            ),
          );
  }
}

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';

import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_screen.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/facility_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/dialog/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'profile_state.dart';

class ProfileController extends BaseController {
  final state = ProfileState();

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData(), getCcrf()]);
  }

  bool onPop() {
    state.pop = true;
    update();
    Get.delete<DashboardController>().then(
      (_) => Get.offAll(const DashboardScreen()),
    );
    return true;
  }

  Future<void> sendEmail() async {
    try {
      await auth
          .postEmailForgotPassword(state.basicProfile?.email ?? '')
          .then((value) => value.code == 201
              ? Get.to(
                  const ForgotPasswordOTPScreen(),
                  arguments: {
                    'email': state.basicProfile?.email ?? '',
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
    state.version = packageInfo.version;
    state.isLoading = true;
    update();

    String? token = await storage.readAccessToken();
    AppLogger.i('token : $token');
    state.isLogin = token != null;
    bool basic = ((await storage.readString(StorageCore.basicProfile))
                .isEmpty ||
            (await storage.readString(StorageCore.basicProfile)) == 'null') &&
        state.isLogin;

    if (basic) {
      await profil.getBasicProfil().then((value) async {
        state.basicProfile = value.data?.user;
        update();
      });
    } else {
      state.basicProfile = UserModel.fromJson(
        await storage.readData(StorageCore.basicProfile),
      );
    }

    state.menuModel =
        MenuModel.fromJson(await storage.readData(StorageCore.userMenu));
    update();

    state.isLoading = false;
    update();
  }

  Future<void> getCcrf() async {
    bool ccrfP = ((await storage.readString(StorageCore.ccrfProfile)).isEmpty ||
            (await storage.readString(StorageCore.ccrfProfile)) == 'null' ||
            (await storage.readString(StorageCore.ccrfProfile)) == '{}') &&
        state.isLogin;

    if (ccrfP) {
      await profil.getCcrfProfil().then((value) {
        state.ccrf = value.data;
        update();
      });
    } else {
      state.ccrf = CcrfProfileModel.fromJson(
          await storage.readData(StorageCore.ccrfProfile));
    }

    state.isCcrf =
        state.ccrf != null && state.ccrf?.generalInfo?.apiStatus == "Y";
    update();
  }

  void doLogout() async {
    state.isLoading = true;
    update();
    final refreshToken = await StorageCore().readRefreshToken() ?? '';
    await auth.logout(refreshToken).then((value) {
      // if (value.code == 201) {
      storage.deleteLogin();
      storage.deleteString(StorageCore.favoriteMenu);
      Get.offAll(const LoginScreen());
      // }
    });
    state.isLoading = false;
    update();
  }

  void isCcrfAction(dynamic screen, BuildContext context) {
    state.isCcrf
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

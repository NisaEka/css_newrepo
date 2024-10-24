import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_screen.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PengaturanController extends BaseController {
  bool isLogin = false;
  bool isLoading = false;
  String? version;
  String? lang;
  AllowedMenu allow = AllowedMenu();
  UserModel? basicProfil;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;

    String? token = await storage.readToken();
    isLogin = token != null;

    lang = await storage.readString(StorageCore.localeApp);

    allow = AllowedMenu.fromJson(await storage.readData(StorageCore.allowedMenu));

    basicProfil = UserModel.fromJson(
      await storage.readData(StorageCore.userProfil),
    );

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
        .then((value) async {
      if (value.code == 200) {
        await auth.logout();
        storage.deleteLogin();
        Get.offAll(const LoginScreen());
      }
    });
    isLoading = false;
    update();
  }

  void changeLanguage(String language) async {
    if (language == "ID") {
      Get.updateLocale(const Locale("id", "ID"));
      await storage.writeString(StorageCore.localeApp, "id");
      lang = "id";
    } else {
      Get.updateLocale(const Locale("en", "US"));
      await storage.writeString(StorageCore.localeApp, "en");
      lang = "en";
    }

    initData();
    update();
  }

  Future<void> sendEmail() async {
    try {
      await auth.postEmailForgotPassword(basicProfil?.email ?? '').then(
            (value) => value.code == 200
                ? Get.to(
                    const ForgotPasswordOTPScreen(),
                    arguments: {
                      'email': basicProfil?.email ?? '',
                      'isChange': true,
                    },
                  )
                : value.code == 404
                    ? Get.showSnackbar(
                        GetSnackBar(
                          icon: const Icon(
                            Icons.warning,
                            color: whiteColor,
                          ),
                          message: 'User Not Found'.tr,
                          isDismissible: true,
                          duration: const Duration(seconds: 3),
                          backgroundColor: errorColor,
                        ),
                      )
                    : Get.showSnackbar(
                        GetSnackBar(
                          icon: const Icon(
                            Icons.warning,
                            color: whiteColor,
                          ),
                          message: 'Bad Request'.tr,
                          isDismissible: true,
                          duration: const Duration(seconds: 3),
                          backgroundColor: errorColor,
                        ),
                      ),
          );
    } catch (e) {
      e.printError();
    }
  }
}

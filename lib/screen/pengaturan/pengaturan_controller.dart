import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/forgot_password/fp_otp/fp_otp_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PengaturanController extends BaseController {
  bool isLogin = false;
  bool isLoading = false;
  String? version;
  String? lang;
  String? mode;
  MenuModel allow = MenuModel();
  UserModel? basicProfil;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;

    String? token = await storage.readAccessToken();
    isLogin = token != null;

    lang = await storage.readString(StorageCore.localeApp);
    mode = await storage.readString(StorageCore.themeMode);

    allow = MenuModel.fromJson(await storage.readData(StorageCore.userMenu));

    basicProfil = UserModel.fromJson(await storage.readData(StorageCore.basicProfile));

    update();
  }

  void changeLanguage(String language) async {
    // if (!isLogin) {
    // if (value.code == 200) {
    if (language == "ID") {
      Get.updateLocale(const Locale("id", "ID"));
      await storage.writeString(StorageCore.localeApp, "id");
      lang = "id";
    } else {
      Get.updateLocale(const Locale("en", "US"));
      await storage.writeString(StorageCore.localeApp, "en");
      lang = "en";
    }
    // }
    // }
    await profil.putProfileBasic(
      UserModel(
        language: language == "ID" ? 'INDONESIA' : 'ENGLISH',
        name: basicProfil?.name,
        brand: basicProfil?.brand,
        phone: basicProfil?.phone,
        address: basicProfil?.address,
        origin: basicProfil?.origin,
        zipCode: basicProfil?.zipCode,
      ),
    );
    initData();
    update();
  }

  void changeTheme(String theme) async {
    if (theme == "dark") {
      // Get.updateLocale(const Locale("id", "ID"));
      await storage.writeString(StorageCore.themeMode, "dark");
      ThemeMode.dark;
      Get.changeTheme(CustomTheme.dark);

      mode = "dark";
    } else {
      // Get.updateLocale(const Locale("en", "US"));
      await storage.writeString(StorageCore.themeMode, "light");
      ThemeMode.light;
      Get.changeTheme(CustomTheme.light);

      mode = "light";
    }

    initData();
    update();
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
}

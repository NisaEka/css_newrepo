import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/storage_core.dart';
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

    basicProfil =
        UserModel.fromJson(await storage.readData(StorageCore.basicProfile));

    update();
  }

  void changeLanguage(String language) async {
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

    if (isLogin) {
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

      await profil.getBasicProfil().then((value) async {
        await storage.saveData(StorageCore.basicProfile, value.data?.user);
        basicProfil = value.data?.user;
      });
    }

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
}

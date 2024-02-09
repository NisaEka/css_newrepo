import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PengaturanController extends BaseController {
  bool isLogin = false;
  String? version;
  String? lang;

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

    update();
  }

  void doLogout() async {
    storage.deleteToken();

    Get.offAll(const LoginScreen());
  }

  void changeLanguage(String language) async {
    if (language == "ID") {
      Get.updateLocale(const Locale("id", "ID"));
      await storage.writeString(StorageCore.localeApp, "id_ID");
      lang = "id_ID";
    } else {
      Get.updateLocale(const Locale("en", "US"));
      await storage.writeString(StorageCore.localeApp, "en_US");
      lang = "en_US";
    }

    initData();
    update();
  }
}

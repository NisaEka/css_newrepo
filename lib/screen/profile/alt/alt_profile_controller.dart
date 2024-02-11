import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../data/model/profile/get_basic_profil_model.dart';

class AltProfileController extends BaseController {
  bool isLogin = false;
  BasicProfilModel? basicProfil;
  String? version;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;

    try {
      String? token = await storage.readToken();
      debugPrint("token : $token");
      isLogin = token != null;

      basicProfil = BasicProfilModel.fromJson(
        await storage.readData(StorageCore.userProfil),
      );

    } catch (e, i) {
      e.printError();
      i.printError();
    }

    update();
  }

  void doLogout() async {
    storage.deleteToken();

    Get.offAll(const LoginScreen());
  }
}

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/util/biometric_pin/app_session.dart';
import 'package:css_mobile/util/biometric_pin/biometric_service.dart';
import 'package:css_mobile/widgets/dialog/verify_pin_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LockedController extends BaseController {
  bool authInProgress = false;
  String? error;
  int failCount = 0;
  static const int failThreshold = 2;

  @override
  void onInit() {
    super.onInit();
    Future.wait([cekLocalLanguage(), startAuth()]);
  }

  bool get showPinButton => failCount >= failThreshold;

  Future<void> startAuth() async {
    if (authInProgress) return;
    authInProgress = true;
    error = null;
    update();

    try {
      await BiometricService.instance.stopAuth();
      await Future.delayed(const Duration(milliseconds: 120));

      final ok = await BiometricService.instance.authenticate(
        reason: 'Verifikasi biometrik untuk membuka CSS'.tr,
      );

      if (ok) {
        goToDashboard();
      } else {
        failCount++;
        error = 'Autentikasi dibatalkan/gagal. Coba lagi.'.tr;
        update();
      }
    } finally {
      authInProgress = false;
      update();
    }
  }

  Future<void> onUsePin() async {
    final pass = await Get.dialog<bool>(
      const VerifyPinDialog(),
      barrierDismissible: false,
    );
    if (pass == true) {
      goToDashboard();
    } else {
      error = 'PIN salah/dibatalkan. Coba lagi.'.tr;
      update();
    }
  }

  void goToDashboard() {
    AppSession.lockCheckedThisRun = true;
    Get.offAll(() => const DashboardScreen());
  }

  Future<void> cekLocalLanguage() async {
    final stored = await storage.readString(StorageCore.localeApp);
    final device = Get.deviceLocale ?? const Locale('id', 'ID');

    String targetCode;
    Locale targetLocale;

    if (stored.isEmpty || stored == 'id_ID' || stored == 'en_US') {
      if (device.languageCode == 'id') {
        targetCode = 'id';
        targetLocale = const Locale('id', 'ID');
      } else {
        targetCode = 'en';
        targetLocale = const Locale('en', 'US');
      }
    } else if (stored == 'id') {
      targetCode = 'id';
      targetLocale = const Locale('id', 'ID');
    } else {
      targetCode = 'en';
      targetLocale = const Locale('en', 'US');
    }

    await storage.writeString(StorageCore.localeApp, targetCode);
    Get.updateLocale(targetLocale);
  }
}

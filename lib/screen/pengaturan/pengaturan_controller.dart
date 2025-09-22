import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/pengaturan/pin/pin_screen.dart';
import 'package:css_mobile/util/biometric_pin/biometric_service.dart';
import 'package:css_mobile/util/biometric_pin/pin_service.dart';
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
  bool biometricEnabled = false;
  bool hasPin = false;

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

    final bioRaw = await storage.readString(StorageCore.biometricLock);
    biometricEnabled = (bioRaw == '1');
    hasPin = await PinService.instance.hasPin();

    update();
  }

  void changeLanguage(String language) async {
    isLoading = true;
    update();
    await Future.delayed(const Duration(seconds: 1));

    if (language == "ID") {
      Get.updateLocale(const Locale("id", "ID"));
      await storage.writeString(StorageCore.localeApp, "id");
      lang = "id";
    } else {
      Get.updateLocale(const Locale("en", "US"));
      await storage.writeString(StorageCore.localeApp, "en");
      lang = "en";
    }
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
    isLoading = false;
    update();
  }

  void changeTheme(String theme) async {
    if (theme == "dark") {
      await storage.writeString(StorageCore.themeMode, "dark");
      ThemeMode.dark;
      Get.changeTheme(CustomTheme.dark);

      mode = "dark";
    } else {
      await storage.writeString(StorageCore.themeMode, "light");
      ThemeMode.light;
      Get.changeTheme(CustomTheme.light);

      mode = "light";
    }

    initData();
    update();
  }

  Future<void> toggleBiometric(bool value) async {
    if (value) {
      if (!await BiometricService.instance.isSupported()) {
        AppSnackBar.error(
            'Biometrik tidak tersedia. Device tidak mendukung atau belum mendaftarkan biometrik.'
                .tr,
            duration: 3);
        biometricEnabled = false;
        update();
        await storage.writeString(StorageCore.biometricLock, '0');
        return;
      }

      if (!await PinService.instance.hasPin()) {
        final setupPin = await Get.to<bool>(() => const PinScreen());
        if (setupPin != true) {
          biometricEnabled = false;
          update();
          return;
        }
      }

      final authenticate = await BiometricService.instance.authenticate(
        reason: 'Aktifkan kunci biometrik'.tr,
      );
      if (!hasPin && !authenticate) {
        AppSnackBar.success('PIN berhasil disimpan'.tr, duration: 3);
        biometricEnabled = false;
        update();
        await storage.writeString(StorageCore.biometricLock, '0');
        return;
      } else if (hasPin && !authenticate) {
        AppSnackBar.error('Gagal Autentikasi. Biometrik dibatalkan/gagal.'.tr,
            duration: 3);
        biometricEnabled = false;
        update();
        await storage.writeString(StorageCore.biometricLock, '0');
        return;
      }
      biometricEnabled = true;
      refreshPinStatus();
      update();
      await storage.writeString(StorageCore.biometricLock, '1');
      AppSnackBar.success(
          'Kunci biometrik aktif. Akan diminta saat aplikasi dibuka.'.tr,
          duration: 3);
    } else {
      biometricEnabled = false;
      update();
      await storage.writeString(StorageCore.biometricLock, '0');
      AppSnackBar.success('Kunci biometrik berhasil dimatikan.', duration: 3);
    }
  }

  Future<void> refreshPinStatus() async {
    hasPin = await PinService.instance.hasPin();
    update();
  }
}

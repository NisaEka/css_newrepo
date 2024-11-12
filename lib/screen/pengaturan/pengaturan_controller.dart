import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
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

    basicProfil = UserModel.fromJson(
      await storage.readData(StorageCore.basicProfile),
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
      debugPrint(value.toJson().toString());
      // if (value.code == 200) {
      await auth.logout();
      storage.deleteLogin();
      Get.offAll(const LoginScreen());
      // }
    });
    isLoading = false;
    update();
  }

  void changeLanguage(String language) async {
    UserModel user = UserModel.fromJson(await storage.readData(StorageCore.basicProfile));
    print("user : ${user.toJson()}");
    await profil
        .putProfileBasic(
      UserModel(
        language: language == "ID" ? 'INDONESIA' : 'ENGLISH',
        name: user.name,
        brand: user.brand,
        phone: user.phone,
        address: user.address,
        origin: user.origin,
        zipCode: user.zipCode,
      ),
    )
        .then((value) async {
      if (value.code == 200) {
        if (language == "ID") {
          Get.updateLocale(const Locale("id", "ID"));
          await storage.writeString(StorageCore.localeApp, "id");
          lang = "id";
        } else {
          Get.updateLocale(const Locale("en", "US"));
          await storage.writeString(StorageCore.localeApp, "en");
          lang = "en";
        }
      }
    });
    await profil.getBasicProfil().then((value) async {
      await storage.saveData(
        StorageCore.basicProfile,
        value.data?.user,
      );

      await storage.saveData(
          StorageCore.shipper,
          ShipperModel(
            name: value.data?.user?.brand,
            phone: value.data?.user?.phone,
            address: value.data?.user?.address,
            zipCode: value.data?.user?.zipCode,
            city: value.data?.user?.origin?.originName,
            origin: value.data?.user?.origin,
            country: value.data?.user?.language,
            region: value.data?.user?.region,
          ));
    });
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
      await auth.postEmailForgotPassword(basicProfil?.email ?? '').then(
            (value) => value.code == 201
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

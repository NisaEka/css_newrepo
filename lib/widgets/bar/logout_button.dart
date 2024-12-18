import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/auth/get_device_info_model.dart';
import 'package:css_mobile/data/repository/auth/auth_repository.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/widgets/dialog/default_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutButton extends StatelessWidget {
  final bool isLogin;
  final String? version;
  final bool showBottomBar;

  const LogoutButton({
    super.key,
    this.isLogin = false,
    this.version,
    this.showBottomBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      // height: showBottomBar ? 113 : null,
      decoration: showBottomBar
          ? BoxDecoration(
              color: AppConst.isLightTheme(context) ? whiteColor : bgDarkColor,
              border: Border(
                bottom: BorderSide(
                    color: AppConst.isLightTheme(context)
                        ? greyColor
                        : Colors.white),
                // top: BorderSide(color: AppConst.isLightTheme(context) ? Colors.black : Colors.white),
              ),
            )
          : null,
      child: Wrap(
        children: [
          ListTile(
            onTap: () => isLogin
                ? showDialog(
                    context: context,
                    builder: (context) => DefaultAlertDialog(
                      title: "Anda akan keluar".tr,
                      subtitle:
                          "Pastikan semua aktvitas sudah selesai. Terima kasih sudah menggunakan CSS Mobile"
                              .tr,
                      backButtonTitle: "Tidak",
                      confirmButtonTitle: "Keluar",
                      onBack: Get.back,
                      onConfirm: () => doLogout(),
                    ),
                  )
                : Get.to(() => const LoginScreen()),
            leading: Icon(
              isLogin ? Icons.logout_rounded : Icons.login_rounded,
              color: AppConst.isLightTheme(context) ? blueJNE : warningColor,
            ),
            title: Text(
              isLogin ? 'Keluar'.tr : 'Masuk'.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: Text(
              'v ${version.toString()}'.tr,
              style: TextStyle(color: CustomTheme().textColor(context)),
            ),
            shape: const Border(
              bottom: BorderSide(color: greyColor),
              top: BorderSide(color: greyColor),
            ),
            contentPadding: showBottomBar ? EdgeInsets.zero : null,
          ),
          // showBottomBar ? const BottomBar4(menu: 3) : const SizedBox()
        ],
      ),
    );
  }

  void doLogout() async {
    final auth = Get.find<AuthRepository>();
    final storage = Get.find<StorageCore>();
    final refreshToken = await StorageCore().readRefreshToken() ?? '';

    storage.deleteLogin();
    Get.offAll(() => const LoginScreen());

    try {
      await auth.logout(refreshToken);
      await auth.updateDeviceInfo(
        DeviceModel(
          fcmToken: await storage.readString(StorageCore.fcmToken),
          registrationId: "",
        ),
      );
    } catch (e, i) {
      AppLogger.e("error logout : $e");
      AppLogger.e("error logout : $i");
    }
  }
}

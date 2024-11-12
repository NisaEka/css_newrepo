import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/repository/auth/auth_repository.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'custombottombar4.dart';

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
                bottom: BorderSide(color: AppConst.isLightTheme(context) ? Colors.black : Colors.white),
                top: BorderSide(color: AppConst.isLightTheme(context) ? Colors.black : Colors.white),
              ),
            )
          : null,
      child: Wrap(
        children: [
          ListTile(
            onTap: () => isLogin ? doLogout() : Get.to(const LoginScreen()),
            leading: Icon(
              isLogin ? Icons.logout : Icons.login,
              color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
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
  }
}

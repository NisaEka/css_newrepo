import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/pengaturan/label/pengaturan_label_screen.dart';
import 'package:css_mobile/screen/pengaturan/pengaturan_controller.dart';
import 'package:css_mobile/screen/pengaturan/petugas/pengaturan_petugas_screen.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/items/setting_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengaturanScreen extends StatelessWidget {
  const PengaturanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PengaturanController>(
        init: PengaturanController(),
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) =>
                Get.off(const DashboardScreen()),
            child: Stack(
              children: [
                Scaffold(
                  appBar: CustomTopBar(
                    title: 'Pengaturan'.tr,
                    leading: CustomBackButton(
                      onPressed: () => Get.off(const DashboardScreen()),
                    ),
                  ),
                  body: _bodyContent(controller, context),
                  bottomNavigationBar: _logoutButton(controller, context),
                ),
                controller.isLoading ? const LoadingDialog() : const SizedBox(),
              ],
            ),
          );
        });
  }

  Widget _bodyContent(PengaturanController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ListView(
        children: [
          ListTile(
            title: Text(
              'Bahasa'.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            contentPadding: EdgeInsets.zero,
            trailing: SizedBox(
              width: 90,
              child: Row(
                children: [
                  CustomFilledButton(
                    color: c.lang == "id" ? blueJNE : whiteColor,
                    fontColor: c.lang == "id" ? whiteColor : greyColor,
                    borderColor:
                        c.lang == "id" ? Colors.transparent : greyColor,
                    title: 'ID',
                    width: 40,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    onPressed: () => c.changeLanguage("ID"),
                  ),
                  const SizedBox(width: 10),
                  CustomFilledButton(
                    color: c.lang == "en" ? blueJNE : whiteColor,
                    fontColor: c.lang == "en" ? whiteColor : greyColor,
                    borderColor:
                        c.lang == "en" ? Colors.transparent : greyColor,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    title: 'EN',
                    width: 40,
                    onPressed: () => c.changeLanguage("EN"),
                  ),
                ],
              ),
            ),
          ),
          c.menu.label == "Y" || c.menu.pengaturanLabel == "Y"
              ? SettingListItem(
                  title: 'Pengaturan Label'.tr,
                  icon: Icons.label_outline,
                  onTap: () => c.isLogin
                      ? Get.to(const PengaturanLabelScreen())
                      : showDialog(
                          context: context,
                          builder: (context) => const LoginAlertDialog(),
                        ),
                )
              : const SizedBox(),
          c.menu.petugas == "Y" || c.menu.pengaturanPetugas == "Y"
              ? SettingListItem(
                  title: 'Pengaturan Petugas'.tr,
                  icon: Icons.account_circle,
                  onTap: () => c.isLogin
                      ? Get.to(const PengaturanPetugasScreen())
                      : showDialog(
                          context: context,
                          builder: (context) => const LoginAlertDialog(),
                        ),
                )
              : const SizedBox(),
          c.isLogin && c.menu.katasandi == "Y"
              ? SettingListItem(
                  title: 'Ubah Kata Sandi'.tr,
                  icon: Icons.lock_open_outlined,
                  // onTap: () => Get.to(const InputEmailScreen(), arguments: {
                  //   'isChange': true,
                  //   'email': controller.basicProfil?.email,
                  // }),
                  onTap: () => c.sendEmail(),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _logoutButton(PengaturanController c, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: ListTile(
        onTap: () => c.isLogin ? c.doLogout() : Get.to(const LoginScreen()),
        leading: Icon(
          c.isLogin ? Icons.logout : Icons.login,
          color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
        ),
        title: Text(
          c.isLogin ? 'Keluar'.tr : 'Masuk'.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: Text('v ${c.version.toString()}'.tr),
        shape: const Border(
          bottom: BorderSide(color: greyColor),
          top: BorderSide(color: greyColor),
        ),
      ),
    );
  }
}

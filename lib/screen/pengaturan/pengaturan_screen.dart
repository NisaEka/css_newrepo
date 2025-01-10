import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/pengaturan/pengaturan_controller.dart';
import 'package:css_mobile/screen/pengaturan/tentang/tentang_screen.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/logout_button.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
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
            onPopInvokedWithResult: (bool didPop, Object? result) =>
                Get.off(() => const DashboardScreen()),
            child: Stack(
              children: [
                Scaffold(
                  appBar: CustomTopBar(
                    title: 'Pengaturan'.tr,
                    leading: CustomBackButton(
                      onPressed: () => Get.off(() => const DashboardScreen()),
                    ),
                  ),
                  body: _bodyContent(controller, context),
                  bottomNavigationBar: LogoutButton(
                    isLogin: controller.isLogin,
                    version: controller.version,
                  ),
                ),
                controller.isLoading ? const LoadingDialog() : const SizedBox(),
              ],
            ),
          );
        });
  }

  Widget _bodyContent(PengaturanController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          SettingListItem(
              title: 'Bahasa'.tr,
              leading: Icons.language_rounded,
              trailing: SizedBox(
                width: 90,
                child: Row(
                  children: [
                    CustomFilledButton(
                      color:
                          c.lang == "id" ? primaryColor(context) : whiteColor,
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
                      color:
                          c.lang == "en" ? primaryColor(context) : whiteColor,
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
              )),
          SettingListItem(
              title: 'Tema Aplikasi'.tr,
              leading: Icons.color_lens_rounded,
              trailing: SizedBox(
                width: 90,
                child: Row(
                  children: [
                    CustomFilledButton(
                      color:
                          c.mode == "dark" ? primaryColor(context) : whiteColor,
                      fontColor: c.mode == "dark" ? whiteColor : greyColor,
                      borderColor:
                          c.mode == "dark" ? Colors.transparent : greyColor,
                      prefixIcon: Icons.dark_mode_rounded,
                      width: 40,
                      margin: EdgeInsets.zero,
                      onPressed: () => c.changeTheme("dark"),
                    ),
                    const SizedBox(width: 10),
                    CustomFilledButton(
                      color: c.mode == "light"
                          ? primaryColor(context)
                          : whiteColor,
                      fontColor: c.mode == "light" ? whiteColor : greyColor,
                      borderColor:
                          c.mode == "light" ? Colors.transparent : greyColor,
                      margin: EdgeInsets.zero,
                      prefixIcon: Icons.light_mode_rounded,
                      width: 40,
                      onPressed: () => c.changeTheme("light"),
                    ),
                  ],
                ),
              )),
          SettingListItem(
              title: 'Tentang'.tr,
              leading: Icons.info_rounded,
              onTap: () => Get.to(() => const TentangScreen()))
        ],
      ),
    );
  }
}

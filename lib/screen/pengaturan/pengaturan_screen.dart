import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/pengaturan/edit_profil/edit_profil_screen.dart';
import 'package:css_mobile/screen/pengaturan/label/pengaturan_label_screen.dart';
import 'package:css_mobile/screen/pengaturan/pengaturan_controller.dart';
import 'package:css_mobile/screen/pengaturan/petugas/pengaturan_petugas_screen.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
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
          return Scaffold(
            appBar: CustomTopBar(title: 'Pengaturan'.tr),
            body: _bodyContent(controller, context),
            bottomNavigationBar: _logoutButton(controller),
          );
        });
  }

  Widget _bodyContent(PengaturanController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ListView(
        children: [
          ListTile(
            title: Text('Bahasa'.tr),
            contentPadding: EdgeInsets.zero,
            trailing: SizedBox(
              width: 90,
              child: Row(
                children: [
                  CustomFilledButton(
                    color: c.lang == "id" ? blueJNE : whiteColor,
                    fontColor: c.lang == "id" ? whiteColor : greyColor,
                    borderColor: c.lang == "id" ? Colors.transparent : greyColor,
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
                    borderColor: c.lang == "en" ? Colors.transparent : greyColor,
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
          /*controller.allow.label == "Y"
                      ?*/
          SettingListItem(
            title: 'Pengaturan Label'.tr,
            icon: Icons.label_outline,
            onTap: () => c.isLogin
                ? Get.to(const PengaturanLabelScreen())
                : showDialog(
                    context: context,
                    builder: (context) => const LoginAlertDialog(),
                  ),
          ),
          // : const SizedBox(),
          /*controller.allow.petugas == "Y"
                      ?*/
          SettingListItem(
            title: 'Pengaturan Petugas'.tr,
            icon: Icons.account_circle,
            onTap: () => c.isLogin
                ? Get.to(const PengaturanPetugasScreen())
                : showDialog(
                    context: context,
                    builder: (context) => const LoginAlertDialog(),
                  ),
          ),
          // : const SizedBox(),
          c.isLogin && c.allow.katasandi == "Y"
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

  Widget _logoutButton(PengaturanController c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: ListTile(
        onTap: () => c.isLogin ? c.doLogout() : Get.to(const LoginScreen()),
        leading: Icon(c.isLogin ? Icons.logout : Icons.login),
        title: Text(c.isLogin ? 'Keluar'.tr : 'Masuk'.tr),
        trailing: Text('v ${c.version.toString()}'.tr),
        shape: const Border(
          bottom: BorderSide(color: greyColor),
          top: BorderSide(color: greyColor),
        ),
      ),
    );
  }
}

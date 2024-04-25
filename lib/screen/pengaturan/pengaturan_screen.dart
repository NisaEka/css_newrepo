import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/auth/forgot_password/input_email_screen.dart';
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
            appBar: CustomTopBar(
              // backgroundColor: whiteColor,
              title: 'Pengaturan'.tr,
            ),
            body: Padding(
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
                            color: controller.lang == "id_ID" ? blueJNE : whiteColor,
                            fontColor: controller.lang == "id_ID" ? whiteColor : greyColor,
                            borderColor: controller.lang == "id_ID" ? Colors.transparent : greyColor,
                            title: 'ID',
                            width: 40,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            onPressed: () => controller.changeLanguage("ID"),
                          ),
                          const SizedBox(width: 10),
                          CustomFilledButton(
                            color: controller.lang == "en_US" ? blueJNE : whiteColor,
                            fontColor: controller.lang == "en_US" ? whiteColor : greyColor,
                            borderColor: controller.lang == "en_US" ? Colors.transparent : greyColor,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            title: 'EN',
                            width: 40,
                            onPressed: () => controller.changeLanguage("EN"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  controller.allow.label == "Y"
                      ? SettingListItem(
                          title: 'Pengaturan Label'.tr,
                          icon: Icons.label_outline,
                          onTap: () => controller.isLogin
                              ? Get.to(const PengaturanLabelScreen())
                              : showDialog(
                                  context: context,
                                  builder: (context) => const LoginAlertDialog(),
                                ),
                        )
                      : const SizedBox(),
                  controller.allow.petugas == "Y"
                      ? SettingListItem(
                          title: 'Pengaturan Petugas'.tr,
                          icon: Icons.account_circle,
                          onTap: () => controller.isLogin
                              ? Get.to(const PengaturanPetugasScreen())
                              : showDialog(
                                  context: context,
                                  builder: (context) => const LoginAlertDialog(),
                                ),
                        )
                      : const SizedBox(),
                  controller.isLogin && controller.allow.profil == "Y"
                      ? SettingListItem(
                          title: 'Edit Profil'.tr,
                          icon: Icons.person,
                          onTap: () => Get.to(const EditProfilScreen()),
                        )
                      : const SizedBox(),
                  controller.isLogin && controller.allow.katasandi == "Y"
                      ? SettingListItem(
                          title: 'Ubah Kata Sandi'.tr,
                          icon: Icons.lock_open_outlined,
                          // onTap: () => Get.to(const InputEmailScreen(), arguments: {
                          //   'isChange': true,
                          //   'email': controller.basicProfil?.email,
                          // }),
                          onTap: () => controller.sendEmail(),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: ListTile(
                onTap: () => controller.isLogin ? controller.doLogout() : Get.to(const LoginScreen()),
                leading: Icon(controller.isLogin ? Icons.logout : Icons.login),
                title: Text(controller.isLogin ? 'Keluar'.tr : 'Masuk'.tr),
                trailing: Text('v ${controller.version.toString()}'.tr),
                shape: const Border(
                  bottom: BorderSide(color: greyColor),
                  top: BorderSide(color: greyColor),
                ),
              ),
            ),
          );
        });
  }
}

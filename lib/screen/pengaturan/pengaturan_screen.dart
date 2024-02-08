import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/pengaturan/label/pengaturan_label_screen.dart';
import 'package:css_mobile/screen/pengaturan/pengaturan_controller.dart';
import 'package:css_mobile/screen/pengaturan/petugas/pengaturan_petugas_screen.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
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
              backgroundColor: whiteColor,
              title: 'Pengaturan'.tr,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Bahasa'.tr),
                    contentPadding: EdgeInsets.zero,
                    trailing: Container(
                      width: 90,
                      child: const Row(
                        children: [
                          CustomFilledButton(
                            color: blueJNE,
                            title: 'ID',
                            width: 40,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                          ),
                          SizedBox(width: 10),
                          CustomFilledButton(
                            color: whiteColor,
                            fontColor: greyColor,
                            borderColor: greyColor,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            title: 'EN',
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SettingListItem(
                    title: 'Pengaturan Label'.tr,
                    icon: Icons.label_outline,
                    onTap: () => Get.to(const PengaturanLabelScreen()),
                  ),
                  SettingListItem(
                    title: 'Pengaturan Petugas'.tr,
                    icon: Icons.label_outline,
                    onTap: () => Get.to(const PengaturanPetugasscreen()),
                  ),
                  SettingListItem(
                    title: 'Ubah Kata Sandi'.tr,
                    icon: Icons.lock_open_outlined,
                  )
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

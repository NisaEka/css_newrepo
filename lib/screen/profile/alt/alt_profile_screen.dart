import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
import 'package:css_mobile/screen/profile/alt/alt_profile_controller.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/akun_bank_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/alamat_return_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/data_umum_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/dokumen_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/no_akun_screen.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/items/setting_list_item.dart';
import 'package:css_mobile/widgets/profile/alt_user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AltProfileScreen extends StatelessWidget {
  const AltProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AltProfileController>(
        init: AltProfileController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              backgroundColor: whiteColor,
              title: 'Profil'.tr,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ListView(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AltUserInfoCard(
                          name: controller.basicProfil?.name ?? '-',
                          brand: controller.basicProfil?.brand ?? '-',
                          mail: controller.basicProfil?.email ?? '-',
                          type: controller.basicProfil?.userType?.capitalizeFirst ?? '-',
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all(color: blueJNE)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                ImageConstant.userPic,
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SettingListItem(
                    title: 'Fasilitasku'.tr,
                    icon: Icons.format_list_numbered_rounded,
                    // onTap: () => Get.to(const AkunBankScreen()),
                  ),
                  SettingListItem(
                    title: 'Lihat Akun'.tr,
                    icon: Icons.account_tree_rounded,
                    onTap: () => Get.to(const NoAkunScreen()),
                  ),
                  SettingListItem(
                    title: 'Data Umum'.tr,
                    icon: Icons.person_pin_outlined,
                    onTap: () => Get.to(const DataUmumScreen()),
                  ),
                  SettingListItem(
                    title: 'Alamat Pengembalian'.tr,
                    icon: Icons.cached_rounded,
                    onTap: () => Get.to(const AlamatReturnScreen()),
                  ),
                  SettingListItem(
                    title: 'Data Rekening'.tr,
                    icon: Icons.credit_card_rounded,
                    onTap: () => Get.to(const AkunBankScreen()),
                  ),
                  SettingListItem(
                    title: 'Dokumen'.tr,
                    icon: Icons.file_present_rounded,
                    onTap: () => Get.to(const DokumenScreen()),
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

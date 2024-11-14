import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/pengaturan/edit_profil/edit_profil_screen.dart';
import 'package:css_mobile/screen/profile/alt/alt_profile_controller.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/akun_bank_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/alamat_return_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/data_umum_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/dokumen_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/facility_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/no_akun_screen.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/custombottombar4.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/logout_button.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
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
          return PopScope(
            canPop: controller.pop,
            onPopInvokedWithResult: (didPop, result) => controller.onPop(),
            child: Stack(
              children: [
                Scaffold(
                  appBar: _appBarContent(),
                  body: _bodyContent(controller, context),
                  bottomNavigationBar: ValueListenableBuilder(
                      valueListenable: controller.bottom.visible,
                      builder: (context, bool value, child) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          // height: value ? 113 : kBottomNavigationBarHeight,
                          child: const BottomBar4(menu: 3),
                          // child: LogoutButton(
                          //   version: controller.version,
                          //   isLogin: controller.isLogin,
                          //   showBottomBar: true,
                          // ),
                        );
                      }),
                ),
                controller.isLoading ? const LoadingDialog() : const SizedBox(),
              ],
            ),
          );
        });
  }

  Widget _bodyContent(AltProfileController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ListView(
        controller: c.bottom.controller,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AltUserInfoCard(
                isLoading: c.basicProfil == null,
                name: c.basicProfil?.name ?? '-',
                brand: c.basicProfil?.brand ?? '-',
                mail: c.basicProfil?.email ?? '-',
                type: c.basicProfil?.userType?.capitalizeFirst ?? '-',
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: blueJNE)),
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
          Column(
            children: [
              c.menuModel.profil == "Y" && c.basicProfil?.userType == "PEMILIK"
                  ? SettingListItem(
                      title: 'Edit Profil'.tr,
                      leading: Icons.person,
                      onTap: () => Get.to(const EditProfilScreen()),
                    )
                  : const SizedBox(),
              c.menuModel.fasilitas == 'Y' &&
                      c.basicProfil?.userType == "PEMILIK"
                  ? SettingListItem(
                      title: 'Fasilitasku'.tr,
                      leading: Icons.format_list_numbered_rounded,
                      onTap: () => Get.to(const FacilityScreen()),
                    )
                  : const SizedBox(),
              c.menuModel.profil == "Y"
                  ? SettingListItem(
                      title: 'Lihat Akun'.tr,
                      leading: Icons.account_tree_rounded,
                      onTap: () => Get.to(const NoAkunScreen()),
                    )
                  : const SizedBox(),
              c.menuModel.profil == "Y"
                  ? SettingListItem(
                      title: 'Data Umum'.tr,
                      leading: Icons.person_pin_outlined,
                      onTap: () => Get.to(const DataUmumScreen()),
                    )
                  : const SizedBox(),
              c.menuModel.profil == "Y"
                  ? SettingListItem(
                      title: 'Alamat Pengembalian'.tr,
                      leading: Icons.cached_rounded,
                      onTap: () =>
                          c.isCcrfAction(const AlamatReturnScreen(), context),
                    )
                  : const SizedBox(),
              c.menuModel.profil == "Y"
                  ? SettingListItem(
                      title: 'Data Rekening'.tr,
                      leading: Icons.credit_card_rounded,
                      onTap: () =>
                          c.isCcrfAction(const AkunBankScreen(), context),
                    )
                  : const SizedBox(),
              c.menuModel.profil == "Y"
                  ? SettingListItem(
                      title: 'Dokumen'.tr,
                      leading: Icons.file_present_rounded,
                      onTap: () =>
                          c.isCcrfAction(const DokumenScreen(), context),
                    )
                  : const SizedBox(),
              LogoutButton(
                isLogin: c.isLogin,
                version: c.version,
                showBottomBar: true,
              )
            ],
          ),
          // : const SizedBox(),
        ],
      ),
    );
  }

  CustomTopBar _appBarContent() {
    return CustomTopBar(
      leading: CustomBackButton(
        onPressed: () => Get.offAll(const DashboardScreen()),
      ),
      title: 'Profil'.tr,
    );
  }
}

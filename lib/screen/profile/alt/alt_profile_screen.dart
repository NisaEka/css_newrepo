import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/auth/login/login_screen.dart';
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
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/items/setting_list_item.dart';
import 'package:css_mobile/widgets/profile/alt_user_info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            onPopInvoked: (didPop) => controller.onPop(),
            child: Scaffold(
              appBar: _appBarContent(),
              body: _bodyContent(controller, context),
              bottomNavigationBar: _logoutButton(controller, context),
            ),
          );
        });
  }

  Widget _logoutButton(AltProfileController c, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      // color: whiteColor,
      child: ListTile(
        onTap: () => c.isLogin ? c.doLogout() : Get.to(const LoginScreen()),
        leading: Icon(c.isLogin ? Icons.logout : Icons.login),
        title: Text(c.isLogin ? 'Keluar'.tr : 'Masuk'.tr),
        trailing: Text('v ${c.version.toString()}'.tr),
        shape: Border(
          bottom: BorderSide(color: AppConst.isLightTheme(context) ? Colors.black : Colors.white),
          top: BorderSide(color: AppConst.isLightTheme(context) ? Colors.black : Colors.white),
        ),
      ),
    );
  }

  Widget _bodyContent(AltProfileController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ListView(
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
          Column(
            children: [
              SettingListItem(
                title: 'Fasilitasku'.tr,
                icon: Icons.format_list_numbered_rounded,
                onTap: () => Get.to(const FacilityScreen()),
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
                onTap: () => c.isCcrf ? Get.to(const AlamatReturnScreen()) : Get.to(const FacilityScreen()),
              ),
              SettingListItem(
                title: 'Data Rekening'.tr,
                icon: Icons.credit_card_rounded,
                onTap: () => c.isCcrf ? Get.to(const AkunBankScreen()) : Get.to(const FacilityScreen()),
              ),
              SettingListItem(
                title: 'Dokumen'.tr,
                icon: Icons.file_present_rounded,
                onTap: () => c.isCcrf ? Get.to(const DokumenScreen()) : Get.to(const FacilityScreen()),
              ),
              SettingListItem(
                title: 'Edit Profil'.tr,
                icon: Icons.person,
                onTap: () => Get.to(const EditProfilScreen()),
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

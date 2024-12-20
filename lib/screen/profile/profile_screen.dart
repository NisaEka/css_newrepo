import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_screen.dart';
import 'package:css_mobile/screen/pengaturan/edit_profil/edit_profil_screen.dart';
import 'package:css_mobile/screen/pengaturan/label/pengaturan_label_screen.dart';
import 'package:css_mobile/screen/pengaturan/petugas/pengaturan_petugas_screen.dart';
import 'package:css_mobile/screen/profile/components/profile_user_info.dart';
import 'package:css_mobile/screen/profile/profile_controller.dart';
import 'package:css_mobile/screen/profile/profil_menu/akun_bank_screen.dart';
import 'package:css_mobile/screen/profile/profil_menu/alamat_return_screen.dart';
import 'package:css_mobile/screen/profile/profil_menu/data_umum_screen.dart';
import 'package:css_mobile/screen/profile/profil_menu/dokumen_screen.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/facility_screen.dart';
import 'package:css_mobile/screen/profile/profil_menu/no_akun_screen.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/custombottombar5.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/logout_button.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
import 'package:css_mobile/widgets/items/menu_icon.dart';
import 'package:css_mobile/widgets/items/setting_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return PopScope(
            canPop: controller.state.pop,
            onPopInvokedWithResult: (didPop, result) => controller.onPop(),
            child: Scaffold(
              appBar: CustomTopBar(
                  leading: CustomBackButton(
                    onPressed: () => Get.delete<DashboardController>()
                        .then((_) => Get.offAll(const DashboardScreen())),
                  ),
                  title: 'Profil'.tr),
              body: _bodyContent(controller, context),
              bottomNavigationBar: BottomBar5(
                menu: 2,
                allow: controller.state.menuModel,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniStartDocked,
              floatingActionButton: controller.state.menuModel.paketmuInput ==
                      "Y"
                  ? MenuIcon(
                      // icon: IconsConstant.add,
                      icon: ImageConstant.paketmuIcon,
                      margin: const EdgeInsets.only(left: 38, bottom: 29),
                      radius: 100,
                      background: (AppConst.isLightTheme(context)
                          ? (controller.state.isLogin
                              ? redJNE
                              : errorLightColor2)
                          : (controller.state.isLogin
                              ? warningColor
                              : warningLightColor2)),
                      showContainer: false,
                      onTap: () => controller.state.isLogin
                          ? Get.to(const InformasiPengirimScreen(),
                              arguments: {})
                          : showDialog(
                              context: context,
                              builder: (context) => const LoginAlertDialog(),
                            ),
                    )
                  : const SizedBox(),
            ),
          );
        });
  }

  Widget _bodyContent(ProfileController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: ListView(
        controller: c.state.bottom.controller,
        children: [
          ProfileUserInfo(
            basicProfile: c.state.basicProfile,
          ),
          Column(
            children: c.state.isLoading
                ? List.generate(
                    8,
                    (index) => const SettingListItem(isLoading: true),
                  )
                : [
                    c.state.menuModel.profil == "Y" &&
                            c.state.basicProfile?.userType == "PEMILIK"
                        ? SettingListItem(
                            title: 'Edit Profil'.tr,
                            leading: Icons.person_2_rounded,
                            onTap: () => Get.to(const EditProfilScreen()),
                          )
                        : const SizedBox(),
                    c.state.menuModel.fasilitas == 'Y' &&
                            c.state.basicProfile?.userType == "PEMILIK"
                        ? SettingListItem(
                            title: 'Fasilitasku'.tr,
                            leading: Icons.format_list_numbered_rounded,
                            onTap: () => Get.to(const FacilityScreen()),
                          )
                        : const SizedBox(),
                    c.state.menuModel.profil == "Y"
                        ? SettingListItem(
                            title: 'Lihat Akun'.tr,
                            leading: Icons.account_tree_rounded,
                            onTap: () => Get.to(const NoAkunScreen()),
                          )
                        : const SizedBox(),
                    c.state.menuModel.profil == "Y"
                        ? SettingListItem(
                            title: 'Data Umum'.tr,
                            leading: Icons.person_pin_rounded,
                            onTap: () => Get.to(const DataUmumScreen()),
                          )
                        : const SizedBox(),
                    c.state.menuModel.profil == "Y"
                        ? SettingListItem(
                            title: 'Alamat Pengembalian'.tr,
                            leading: Icons.cached_rounded,
                            onTap: () => c.isCcrfAction(
                                const AlamatReturnScreen(), context),
                          )
                        : const SizedBox(),
                    c.state.menuModel.profil == "Y"
                        ? SettingListItem(
                            title: 'Data Rekening'.tr,
                            leading: Icons.credit_card_rounded,
                            onTap: () =>
                                c.isCcrfAction(const AkunBankScreen(), context),
                          )
                        : const SizedBox(),
                    c.state.menuModel.profil == "Y"
                        ? SettingListItem(
                            title: 'Dokumen'.tr,
                            leading: Icons.file_present_rounded,
                            onTap: () =>
                                c.isCcrfAction(const DokumenScreen(), context),
                          )
                        : const SizedBox(),
                    c.state.menuModel.label == "Y" ||
                            c.state.menuModel.pengaturanLabel == "Y"
                        ? SettingListItem(
                            title: 'Pengaturan Label'.tr,
                            leading: Icons.label_rounded,
                            onTap: () => c.state.isLogin
                                ? Get.to(const PengaturanLabelScreen())
                                : showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const LoginAlertDialog(),
                                  ),
                          )
                        : const SizedBox(),
                    c.state.menuModel.petugas == "Y" ||
                            c.state.menuModel.pengaturanPetugas == "Y"
                        ? SettingListItem(
                            title: 'Pengaturan Petugas'.tr,
                            leading: Icons.supervisor_account_rounded,
                            onTap: () => c.state.isLogin
                                ? Get.to(const PengaturanPetugasScreen())
                                : showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const LoginAlertDialog(),
                                  ),
                          )
                        : const SizedBox(),
                    c.state.isLogin && c.state.menuModel.katasandi == "Y"
                        ? SettingListItem(
                            title: 'Ubah Kata Sandi'.tr,
                            leading: Icons.password_rounded,
                            onTap: () => c.sendEmail(),
                          )
                        : const SizedBox(),
                    LogoutButton(
                      isLogin: c.state.isLogin,
                      version: c.state.version,
                      showBottomBar: true,
                    )
                  ],
          ),
          // : const SizedBox(),
        ],
      ),
    );
  }
}

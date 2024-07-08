import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/screen/cek_ongkir/cek_ongkir_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_screen.dart';
import 'package:css_mobile/screen/profile/alt/alt_profile_screen.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
import 'package:css_mobile/widgets/items/bottom_menu_item2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar4 extends StatelessWidget {
  final int menu;
  final String? label;
  final void Function(int)? onTap;
  final bool isLogin;
  final AllowedMenu allowedMenu;

  const BottomBar4({
    super.key,
    required this.menu,
    this.label,
    this.onTap,
    required this.isLogin,
    required this.allowedMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppConst.isLightTheme(context) ? whiteColor : greyDarkColor2, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomMenuItem2(
            icon: Icons.home,
            title: "Beranda".tr,
            isSelected: menu == 0,
            color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
            onTap: () => Get.offAll(const DashboardScreen(), transition: Transition.leftToRight),
          ),
          BottomMenuItem2(
            icon: Icons.qr_code,
            title: "Lacak Kiriman".tr,
            isSelected: menu == 1,
            color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
            onTap: () => Get.to(const LacakKirimanScreen(), arguments: {}),
          ),
          (allowedMenu.paketmuInput == "Y" || allowedMenu.buatPesanan == "Y") || !isLogin
              ? FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: isLogin ? redJNE : errorLightColor2,
                  // onPressed: () => Get.to(const InputKirimanScreen()),
                  onPressed: () => isLogin
                      ? Get.to(const InformasiPengirimScreen(), arguments: {})
                      : showDialog(
                          context: context,
                          builder: (context) => const LoginAlertDialog(),
                        ),
                  child: Image.asset(
                    ImageConstant.paketmuIcon,
                    height: Get.width / 12,
                  ),
                )
              : const SizedBox(),
          BottomMenuItem2(
            icon: Icons.local_shipping,
            title: "Cek Ongkir".tr,
            isSelected: menu == 2,
            color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
            onTap: () => Get.to(const CekOngkirScreen(), arguments: {}),
          ),
          BottomMenuItem2(
            icon: Icons.person,
            title: "Profil".tr,
            isSelected: menu == 3,
            color: (AppConst.isLightTheme(context) ? blueJNE : redJNE).withOpacity(1),
            // onTap: () => Get.offAll(const ProfileScreen()),
            onTap: () => isLogin
                ? Get.offAll(const AltProfileScreen(), transition: Transition.rightToLeft)
                : showDialog(
                    context: context,
                    builder: (context) => const LoginAlertDialog(),
                  ),
          ),
        ],
      ),
    );
  }
}

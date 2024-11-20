import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_screen.dart';
import 'package:css_mobile/screen/profile/profile_screen.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar3 extends StatelessWidget {
  final int menu;
  final String? label;
  final void Function(int)? onTap;
  final bool isLogin;
  final AllowedMenu allowedMenu;

  const BottomBar3({
    super.key,
    required this.menu,
    this.label,
    this.onTap,
    required this.isLogin,
    required this.allowedMenu,
  });

  @override
  Widget build(BuildContext context) {
    List screens = [
      const DashboardScreen(),
      const LacakKirimanScreen(),
      const InformasiPengirimScreen(),
      const DashboardScreen(),
      const ProfileScreen(),
    ];

    return Builder(
        // init: HomeController(),
        builder: (controller) {
      return BottomNavigationBar(
        elevation: 10,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              size: 30,
            ),
            label: "Beranda".tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.qr_code,
              size: 30,
            ),
            label: "Lacak".tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
            label: "Input Transaksi".tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.notifications,
              size: 30,
            ),
            label: "Notifikasi".tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.person,
              size: 30,
            ),
            label: "Profil".tr,
          ),
        ],
        currentIndex: menu,
        selectedItemColor: AppConst.isLightTheme(context) ? blueJNE : redJNE,
        unselectedItemColor: greyColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        onTap: (index) {
          if (index == 0) {
            Get.offAll(screens[index], arguments: {
              "index": index,
              "nomor_resi": null,
            });
          } else {
            isLogin
                ? Get.to(screens[index], arguments: {
                    "index": index,
                    "nomor_resi": null,
                  })
                : showDialog(
                    context: context,
                    builder: (context) => const LoginAlertDialog(),
                  );
          }
        },
      );
    });
  }
}

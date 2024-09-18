import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/screen/dashboard/screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_screen.dart';
import 'package:css_mobile/screen/profile/alt/alt_profile_screen.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
import 'package:css_mobile/widgets/items/bottom_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  final int menu;
  final String? label;
  final void Function(int)? onTap;
  final bool isLogin;
  final AllowedMenu allowedMenu;

  const BottomBar({
    Key? key,
    required this.menu,
    this.label,
    this.onTap,
    required this.isLogin,
    required this.allowedMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // overflow: Overflow.visible,
      alignment: const FractionalOffset(.5, 1.0),
      children: [
        Container(
          height: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppConst.isLightTheme(context) ? whiteColor : greyDarkColor2,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomMenuItem(
                  icon: Icon(Icons.home, color: menu == 0 ? redJNE : blueJNE),
                  title: "Beranda".tr,
                  color: menu == 0 ? redJNE : blueJNE,
                  onTap: () => Get.offAll(const DashboardScreen()),
                ),
                const SizedBox(width: 30, height: 30),
                const SizedBox(width: 30, height: 30),
                BottomMenuItem(
                  icon: Icon(Icons.person,
                      color: isLogin
                          ? menu == 1
                              ? redJNE
                              : AppConst.isLightTheme(context)
                                  ? blueJNE
                                  : whiteColor
                          : AppConst.isLightTheme(context)
                              ? blueJNE.withOpacity(0.5)
                              : whiteColor.withOpacity(0.5)),
                  title: "Profil".tr,
                  color: isLogin
                      ? menu == 1
                          ? redJNE
                          : Theme.of(context).brightness == Brightness.light
                              ? blueJNE
                              : whiteColor
                      : Theme.of(context).brightness == Brightness.light
                          ? blueJNE.withOpacity(0.5)
                          : whiteColor.withOpacity(0.5),
                  // onTap: () => Get.offAll(const ProfileScreen()),
                  onTap: () => isLogin
                      ? Get.offAll(AltProfileScreen())
                      : showDialog(
                          context: context,
                          builder: (context) => const LoginAlertDialog(),
                        ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: allowedMenu.paketmuInput == "Y" || !isLogin
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
                  child: const Icon(
                    Icons.add,
                    color: whiteColor,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}

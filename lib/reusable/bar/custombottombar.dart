import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/reusable/items/bottom_menu_item.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/input_kiriman_screen.dart';
import 'package:css_mobile/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  final int menu;
  final String? label;
  final void Function(int)? onTap;

  const BottomBar({
    Key? key,
    required this.menu,
    this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // overflow: Overflow.visible,
      alignment: new FractionalOffset(.5, 1.0),
      children: [
        Container(
          height: 70.0,
          decoration: BoxDecoration(
              color: whiteColor,
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
                BottomMenuItem(icon: Icon(Icons.home, color: menu == 0 ? redJNE : blueJNE), title: "Beranda".tr, color: menu == 0 ? redJNE : blueJNE, onTap: () => Get.off(const DashboardScreen())),
                const SizedBox(width: 30, height: 30),
                const SizedBox(width: 30, height: 30),
                BottomMenuItem(icon: Icon(Icons.person, color: menu == 1 ? redJNE : blueJNE), title: "Profil".tr, color: menu == 1 ? redJNE : blueJNE, onTap: () => Get.off(const ProfileScreen())),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: redJNE,
            // onPressed: () => Get.to(const InputKirimanScreen()),
            onPressed: () => Get.to(const InformasiPengirimScreen()),
            child: const Icon(
              Icons.add,
              color: whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}

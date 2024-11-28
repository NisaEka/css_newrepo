import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/cek_ongkir/congkir_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_screen.dart';
import 'package:css_mobile/screen/profile/profile_screen.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
import 'package:css_mobile/widgets/items/bottom_menu_item2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar5 extends StatelessWidget {
  final int menu;
  final String? label;
  final void Function(int)? onTap;

  const BottomBar5({
    super.key,
    required this.menu,
    this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipPath(
                  clipper: NavBarClipper(),
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: blueJNE,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(width: 60), // Placeholder untuk FAB
                        BottomMenuItem2(
                          icon: Icons.home,
                          isSelected: menu == 0,
                          color: AppConst.isLightTheme(context)
                              ? whiteColor
                              : redJNE,
                          onTap: () => Get.offAll(const DashboardScreen(),
                              transition: Transition.leftToRight),
                        ),
                        BottomMenuItem2(
                          icon: Icons.local_shipping,
                          isSelected: menu == 1,
                          color: AppConst.isLightTheme(context)
                              ? whiteColor
                              : redJNE,
                          onTap: () =>
                              Get.to(const CekOngkirScreen(), arguments: {}),
                        ),
                        BottomMenuItem2(
                          icon: Icons.person,
                          isSelected: menu == 2,
                          color: (AppConst.isLightTheme(context)
                                  ? whiteColor
                                  : redJNE)
                              .withOpacity(1),
                          // onTap: () => Get.offAll(const ProfileScreen()),
                          onTap: () => controller.state.isLogin
                              ? Get.offAll(const ProfileScreen(),
                                  transition: Transition.rightToLeft)
                              : showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const LoginAlertDialog(),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              controller.state.menuItems
                      .where((e) => e.title == "Input Kirimanmu")
                      .isNotEmpty
                  ? Positioned(
                      bottom: 50, // Mengangkat posisi FAB dari navbar
                      left: 57, // Tetap di sisi kiri
                      child: FloatingActionButton(
                        shape: const CircleBorder(),
                        backgroundColor: controller.state.isLogin
                            ? redJNE
                            : errorLightColor2,
                        // onPressed: () => Get.to(const InputKirimanScreen()),
                        onPressed: () => controller.state.isLogin
                            ? Get.to(const InformasiPengirimScreen(),
                                arguments: {})
                            : showDialog(
                                context: context,
                                builder: (context) => const LoginAlertDialog(),
                              ),
                        child: Image.asset(
                          ImageConstant.paketmuIcon,
                          height: Get.width / 12,
                        ),
                      ))
                  : const SizedBox(),
            ],
          );
        });
  }
}

class NavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.cubicTo(size.width / 12, 0, size.width / 12, 2 * size.height / 5,
        2 * size.width / 12, 2 * size.height / 5);
    path.cubicTo(3 * size.width / 12, 2 * size.height / 5, 3 * size.width / 12,
        0, 4 * size.width / 12, 0);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

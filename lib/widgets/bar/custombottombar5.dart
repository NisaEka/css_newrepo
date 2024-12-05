import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_card_screen.dart';
import 'package:css_mobile/screen/profile/profile_screen.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
import 'package:css_mobile/widgets/items/bottom_menu_item2.dart';
import 'package:css_mobile/widgets/items/menu_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomBar5 extends StatelessWidget {
  final int menu;
  final String? label;
  final MenuModel? allow;
  final void Function(int)? onTap;

  const BottomBar5({
    super.key,
    required this.menu,
    this.label,
    this.onTap,
    required this.allow,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ClipPath(
              clipper: NavBarClipper(),
              child: Container(
                height: 50,
                width: Get.width * 0.9,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: AppConst.isLightTheme(context) ? blueJNE : infoColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 60), // Placeholder untuk FAB
                    BottomMenuItem2(
                      icon: SvgPicture.asset(
                        IconsConstant.home,
                        height: 35,
                        color: menu == 0
                            ? AppConst.isLightTheme(context)
                                ? redJNE
                                : warningColor
                            : whiteColor,
                      ),
                      isSelected: menu == 0,
                      onTap: () => Get.offAll(const DashboardScreen(),
                          transition: Transition.leftToRight),
                    ),
                    allow?.pantauPaketmu == "Y"
                        ? BottomMenuItem2(
                            icon: MenuIcon(
                              icon: IconsConstant.pantau,
                              size: 30,
                              showContainer: false,
                              iconColor: menu == 1
                                  ? AppConst.isLightTheme(context)
                                      ? redJNE
                                      : warningColor
                                  : whiteColor,
                              background: AppConst.isLightTheme(context)
                                  ? blueJNE
                                  : infoColor,
                            ),
                            isSelected: menu == 1,
                            onTap: () => Get.to(const PantauCardScreen(),
                                transition: Transition.rightToLeft,
                                arguments: {}),
                          )
                        : const SizedBox(),
                    BottomMenuItem2(
                      icon: Icon(
                        Icons.person,
                        color: menu == 2
                            ? AppConst.isLightTheme(context)
                                ? redJNE
                                : warningColor
                            : whiteColor,
                        size: 35,
                      ),
                      isSelected: menu == 2,
                      color: AppConst.isLightTheme(context)
                          ? redJNE
                          : warningColor,
                      // onTap: () => Get.offAll(const ProfileScreen()),
                      onTap: () => controller.state.isLogin
                          ? Get.offAll(const ProfileScreen(),
                              transition: Transition.rightToLeft)
                          : showDialog(
                              context: context,
                              builder: (context) => const LoginAlertDialog(),
                            ),
                    ),
                  ],
                ),
              ),
            ),
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

import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_screen.dart';
import 'package:css_mobile/screen/profile/profile_screen.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
import 'package:css_mobile/widgets/items/bottom_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar2 extends StatelessWidget {
  final int menu;
  final String? label;
  final void Function(int)? onTap;
  final bool isLogin;
  final AllowedMenu allowedMenu;

  const BottomBar2({
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
      alignment: const FractionalOffset(0.85, 0.6),
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: (allowedMenu.paketmuInput != "Y" && isLogin) ? 20 : 0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: AppConst.isLightTheme(context) ? whiteColor : greyDarkColor2,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BottomMenuItem(
                icon: Icon(
                  Icons.home,
                  color: menu == 0 ? redJNE : blueJNE,
                  size: 30,
                ),
                color: menu == 0 ? redJNE : blueJNE,
                onTap: () => Get.delete<DashboardController>()
                    .then((_) => Get.offAll(const DashboardScreen())),
              ),
              const SizedBox(width: 30, height: 30),
              const SizedBox(width: 30, height: 30),
              BottomMenuItem(
                icon: Icon(Icons.person,
                    size: 30,
                    color: isLogin
                        ? menu == 1
                            ? redJNE
                            : AppConst.isLightTheme(context)
                                ? blueJNE
                                : whiteColor
                        : AppConst.isLightTheme(context)
                            ? blueJNE.withOpacity(0.5)
                            : whiteColor.withOpacity(0.5)),
                color: isLogin
                    ? menu == 1
                        ? redJNE
                        : AppConst.isLightTheme(context)
                            ? blueJNE
                            : whiteColor
                    : AppConst.isLightTheme(context)
                        ? blueJNE.withOpacity(0.5)
                        : whiteColor.withOpacity(0.5),
                // onTap: () => Get.offAll(const ProfileScreen()),
                onTap: () => isLogin
                    ? Get.offAll(const ProfileScreen())
                    : showDialog(
                        context: context,
                        builder: (context) => const LoginAlertDialog(),
                      ),
              ),
            ],
          ),
        ),
        // Positioned(
        //   bottom: 50,
        //   child: Container(
        //     // padding: const EdgeInsets.all(40.0),
        //     height: 60,
        //     width: 60,
        //     decoration: BoxDecoration(
        //       color: isLogin ? redJNE : errorLightColor2,
        //       borderRadius: BorderRadius.circular(100),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.grey.withOpacity(0.5),
        //             // spreadRadius: 5,
        //             blurRadius: 7,
        //             offset: const Offset(2, 3),
        //           )
        //         ]
        //     ),
        //     alignment: Alignment.center,
        //     child: const Icon(
        //       Icons.add,
        //       color: whiteColor,
        //     ),
        //   ),
        // )
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
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
                  child: Container(
                    // padding: const EdgeInsets.all(40.0),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: isLogin ? redJNE : errorLightColor2,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: AppConst.isLightTheme(context)
                                ? Colors.grey.withOpacity(0.5)
                                : greyLightColor3.withOpacity(0.5),
                            // spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(2, 3),
                          )
                        ]),
                    alignment: Alignment.center,
                    child: Image.asset(
                      ImageConstant.paketmuIcon,
                      height: Get.width / 12,
                    ),
                    // child: SvgPicture.asset(
                    //   IconsConstant.paket,
                    //   height: 30,
                    //   color: whiteColor,
                    // )
                    // child: const Icon(
                    //   Icons.add,
                    //   color: whiteColor,
                    // ),
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}

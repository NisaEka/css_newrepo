import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/menu/other_menu_screen.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
import 'package:css_mobile/widgets/items/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardMenu2 extends StatelessWidget {
  const DashboardMenu2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return SizedBox(
            height: 120,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: controller.state.isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => const MenuItem(
                          isLoading: true,
                          menuIcon: Icon(
                            Icons.more_horiz,
                            size: 40,
                          ),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: controller.state.menuItems
                              .map((e) => MenuItem(
                                    menuTitle: e.title?.tr ?? '',
                                    menuImg: e.icon,
                                    data: e,
                                    isLoading: controller.state.isLoading,
                                    isActive: (e.isAuth ?? false)
                                        ? controller.state.isLogin
                                        : true,
                                    onTap: () => (e.isAuth == true &&
                                            !controller.state.isLogin)
                                        ? showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const LoginAlertDialog(),
                                          )
                                        : !controller.state.isLoading
                                            ? Get.toNamed(e.route.toString(),
                                                arguments: {})
                                            : null,
                                  ))
                              .toList(),
                        ),
                        MenuItem(
                          menuTitle: 'Lainnya'.tr,
                          isLoading: controller.state.isLoading,
                          onTap: () =>
                              Get.to(const OtherMenuScreen(), arguments: {
                            'isLogin': controller.state.isLogin,
                            'allowance': controller.state.allow,
                          })?.then(
                            (result) {
                              // controller.cekFavoritMenu();
                              // controller.cekAllowance();
                              controller.initData();
                            },
                          ),
                          menuIcon: Icon(
                            Icons.more_horiz,
                            color: AppConst.isLightTheme(context)
                                ? whiteColor
                                : infoColor,
                            size: 46,
                          ),
                        ),
                      ],
                    ),
            ),
          );
        });
  }
}

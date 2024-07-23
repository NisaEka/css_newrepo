import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/dashboard/menu_item_model.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
import 'package:css_mobile/widgets/items/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardMenu2 extends StatelessWidget {
  final bool isLogin;
  final List<Items> menu;
  final VoidCallback? getOtherMenu;
  final bool isLoading;

  const DashboardMenu2({
    super.key,
    required this.isLogin,
    required this.menu,
    this.getOtherMenu,
    this.isLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: isLoading
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
                    children: menu
                        .map((e) => MenuItem(
                              menuTitle: e.title?.tr ?? '',
                              menuImg: e.icon,
                              isLoading: isLoading,
                              isActive: (e.isAuth ?? false) ? isLogin : true,
                              onTap: () => (e.isAuth == true && !isLogin)
                                  ? showDialog(
                                      context: context,
                                      builder: (context) => const LoginAlertDialog(),
                                    )
                                  : !isLoading
                                      ? Get.toNamed(e.route.toString(), arguments: {})
                                      : null,
                            ))
                        .toList(),
                  ),
                  MenuItem(
                    menuTitle: 'Lainnya'.tr,
                    isLoading: isLoading,
                    onTap: getOtherMenu,
                    menuIcon: const Icon(
                      Icons.more_horiz,
                      color: whiteColor,
                      size: 46,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

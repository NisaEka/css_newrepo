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

  const DashboardMenu2({
    super.key,
    required this.isLogin,
    required this.menu,
    this.getOtherMenu,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: menu
                  .map((e) => MenuItem(
                        menuTitle: e.title?.tr ?? '',
                        menuImg: e.icon,
                        isActive: (e.isAuth ?? false) ? isLogin : true,
                        onTap: () => (e.isAuth == true && !isLogin)
                            ? showDialog(
                                context: context,
                                builder: (context) => const LoginAlertDialog(),
                              )
                            : Get.toNamed(e.route.toString(), arguments: {}),
                      ))
                  .toList(),
            ),
            MenuItem(
              menuTitle: 'Lainnya'.tr,
              onTap: getOtherMenu,
              menuIcon: const Icon(
                Icons.more_horiz,
                color: whiteColor,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

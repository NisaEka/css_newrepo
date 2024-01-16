import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/cek_ongkir/cek_ongkir_screen.dart';
import 'package:css_mobile/widgets/items/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardMenu2 extends StatelessWidget {
  const DashboardMenu2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MenuItem(
              menuTitle: 'Input Kirimanmu'.tr,
              menuImg: ImageConstant.paketmuIcon,
            ),
            MenuItem(
              menuTitle: 'Cek Ongkir'.tr,
              menuImg: ImageConstant.cekOngkirIcon,
              onTap: () => Get.to(const CekOngkirScreen()),
            ),
            MenuItem(
              menuTitle: 'Aggregasi Pembayaran'.tr,
              menuImg: ImageConstant.truckIcon,
            ),
            MenuItem(
              menuTitle: 'Minta Dijemput'.tr,
              menuImg: ImageConstant.truckIcon,
            ),
            MenuItem(
              menuTitle: 'Lainnya'.tr,
              menuIcon: const Icon(
                Icons.more_horiz,
                color: whiteColor,
                size: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}

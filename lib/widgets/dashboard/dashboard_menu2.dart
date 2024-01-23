import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/cek_ongkir/cek_ongkir_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_screen.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
import 'package:css_mobile/widgets/items/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardMenu2 extends StatelessWidget {
  const DashboardMenu2({super.key});

  Future<bool> isLogin() async {
    String token = await StorageCore().readToken() ?? '';
    bool login = token != null;
    return login;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MenuItem(
              menuTitle: 'Input Kirimanmu'.tr,
              menuImg: ImageConstant.paketmuIcon,
              isActive: isLogin() == true,
              onTap: () => isLogin() == true
                  ? Get.to(const InformasiPengirimScreen())
                  : showDialog(
                      context: context,
                      builder: (context) => const LoginAlertDialog(),
                    ),
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

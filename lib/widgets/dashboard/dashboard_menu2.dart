import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/bonus_kamu/bonus_kamu_screen.dart';
import 'package:css_mobile/screen/cek_ongkir/cek_ongkir_screen.dart';
import 'package:css_mobile/screen/paketmu/draft_transaksi/draft_transaksi_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/informasi_pengirim_screen.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_screen.dart';
import 'package:css_mobile/widgets/dialog/login_alert_dialog.dart';
import 'package:css_mobile/widgets/items/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardMenu2 extends StatelessWidget {
  final bool isLogin;

  const DashboardMenu2({super.key, required this.isLogin});

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
              isActive: isLogin,
              onTap: () => isLogin
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
              menuTitle: 'Draft Transaksi'.tr,
              menuImg: ImageConstant.paketmuIcon,
              onTap: () => Get.to(const DraftTransaksiScreen()),
            ),
            MenuItem(
              menuTitle: 'Riwayat kiriman'.tr,
              menuImg: ImageConstant.paketmuIcon,
              onTap: () => Get.to(const RiwayatKirimanScreen()),

            ),
            MenuItem(
              menuTitle: 'Lainnya'.tr,
              onTap: () => Get.to(const BonusKamuScreen()),
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

import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/add/add_eclaim_screen.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/input/input_laporanku_screen.dart';
import 'package:css_mobile/widgets/items/menu_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HubungiAkuDialog extends StatelessWidget {
  final String awb;
  final MenuModel allow;

  const HubungiAkuDialog({super.key, required this.awb, required this.allow});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      // padding: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: greyColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Text(
              'Konfirmasi'.tr,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: whiteColor),
            ),
          ),
          const SizedBox(height: 20),
          allow.hubungiLaporan == "Y" || allow.laporan == "Y"
              ? ListTile(
                  leading: const MenuIcon(
                    // icon: IconsConstant.ticket,
                    icon: ImageConstant.hubungiAkuIcon,
                    padding: EdgeInsets.all(1),
                    // isTransparent: true,
                    isActive: false,
                  ),
                  title: Text(
                    'Buat Tiket Laporan'.tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () => Get.to(
                    () => const InputLaporankuScreen(),
                    arguments: {'awb': awb},
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          allow.hubungiEclaim == "Y" || allow.eclaim == "Y"
              ? ListTile(
                  leading: const MenuIcon(
                    // icon: IconsConstant.eclaim,
                    icon: ImageConstant.hubungiAkuIcon,
                    padding: EdgeInsets.all(1),
                    // isTransparent: true,
                    isActive: false,
                  ),
                  title: Text(
                    'Pengajuan Eclaim'.tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () => Get.to(() => const AddEclaimScreen(),
                      arguments: {'awb': awb}),
                )
              : const SizedBox(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

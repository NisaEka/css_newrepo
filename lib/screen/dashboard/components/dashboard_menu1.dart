import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/cek_ongkir/screen.dart';
import 'package:css_mobile/widgets/items/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardMenu1 extends StatelessWidget {
  const DashboardMenu1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 2,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuItem(
                menuImg: ImageConstant.paketmuIcon,
                menuTitle: "Paketmu\n".tr,
              ),
              MenuItem(
                menuImg: ImageConstant.keuanganmuIcon,
                menuTitle: "Keuanganmu\n".tr,
              ),
              MenuItem(
                menuImg: ImageConstant.pantauPaketmuIcon,
                menuTitle: "Pantau\nPaketmu".tr,
              ),
              MenuItem(
                menuImg: ImageConstant.hubungiAkuIcon,
                menuTitle: "Hubungi\nAku".tr,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuItem(
                menuImg: ImageConstant.cekOngkirIcon,
                menuTitle: "Cek Ongkir\n".tr,
                onTap: () => Get.to(const CekOngkirScreen()),
              ),
              MenuItem(
                menuImg: ImageConstant.dukunganTeknisIcon,
                menuTitle: "Dukungan\nTeknis".tr,
              ),
              MenuItem(
                menuImg: ImageConstant.pengaturanIcon,
                menuTitle: "Pengaturan\n".tr,
              ),
              SizedBox(width: Get.width / 6, height: Get.width / 6)
            ],
          ),
        ],
      ),
    );
  }
}

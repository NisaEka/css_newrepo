 import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/reusable/bar/custombottombar.dart';
import 'package:css_mobile/reusable/items/menu_item.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                titleTextStyle: titleTextStyle,
                title: Text('Beranda'.tr),
                actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 260,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(color: blueJNE),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Selamat Datang".tr,
                                        style: sublistTitleTextStyle.copyWith(color: whiteColor),
                                      ),
                                      Text(
                                        "Joni".tr,
                                        style: listTitleTextStyle.copyWith(color: whiteColor),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        child: Icon(
                                          Icons.storefront_rounded,
                                          color: whiteColor,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Joni Store".tr,
                                            style: sublistTitleTextStyle.copyWith(color: whiteColor),
                                          ),
                                          Text(
                                            "Pemilik".tr,
                                            style: listTitleTextStyle.copyWith(color: whiteColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Masukan nomor resi untuk lacak kiriman',
                                    hintStyle: hintTextStyle,
                                    suffixIcon: const Icon(Icons.qr_code)),
                              )
                            ],
                          ),
                        ),
                        Card(
                          elevation: 1,
                          color: whiteColor,
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 150),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                        )
                      ],
                    )
                  ],
                ),
              ),
              bottomNavigationBar: BottomBar(
                menu: 0,
                onTap: (index) {
                  controller.selectedIndex.value = index;
                  controller.update();
                  Get.offAll(const DashboardScreen(), arguments: index);
                },
              ));
        });
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/cek_ongkir/cek_ongkir_screen.dart';
import 'package:css_mobile/widgets/bar/custombottombar.dart';
import 'package:css_mobile/widgets/items/menu_item.dart';
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
              backgroundColor: greyLightColor1,
              appBar: AppBar(
                titleTextStyle: titleTextStyle,
                // title: Text('Beranda'.tr),
                title: Image.asset(
                  ImageConstant.logoCSS_white,
                  height: 30,
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 160,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              color: blueJNE,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              )),
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
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(ImageConstant.logoJLC, height: 14),
                                        const Text(' 1.000 Point')
                                        // const Padding(
                                        //   padding: EdgeInsets.symmetric(horizontal: 8),
                                        //   child: Icon(
                                        //     Icons.storefront_rounded,
                                        //     color: whiteColor,
                                        //   ),
                                        // ),
                                        // Column(
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        //   children: [
                                        //     Text(
                                        //       "Joni Store".tr,
                                        //       style: sublistTitleTextStyle.copyWith(color: whiteColor),
                                        //     ),
                                        //     Text(
                                        //       "Pemilik".tr,
                                        //       style: listTitleTextStyle.copyWith(color: whiteColor),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Masukan nomor resi untuk lacak kiriman',
                                  hintStyle: hintTextStyle,
                                  suffixIcon: const Icon(
                                    Icons.qr_code,
                                    color: redJNE,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20, right: 20, top: 150),
                              height: 100,
                              width: Get.width - 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: infoLightColor1.withOpacity(0.8)),
                              child: CarouselSlider(
                                items: controller.bannerList,
                                options: CarouselOptions(
                                  autoPlay: true,
                                  viewportFraction: 1,
                                  enableInfiniteScroll: false,
                                  height: 100,
                                  // pauseAutoPlayOnTouch: true,
                                  onPageChanged: (index, reason) => controller.bannerIndex,
                                ),
                                disableGesture: true,
                                carouselController: controller.commercialCarousel,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
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
                            )
                          ],
                        ),
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

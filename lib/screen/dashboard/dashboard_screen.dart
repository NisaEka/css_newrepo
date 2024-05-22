import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/bonus_kamu/bonus_kamu_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/menu/other_menu_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/barcode_scan_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_screen.dart';
import 'package:css_mobile/screen/pengaturan/pengaturan_screen.dart';
import 'package:css_mobile/widgets/bar/custombottombar.dart';
import 'package:css_mobile/widgets/bar/custombottombar2.dart';
import 'package:css_mobile/widgets/dashboard/dashboard_carousel.dart';
import 'package:css_mobile/widgets/dashboard/dashboard_marquee.dart';
import 'package:css_mobile/widgets/dashboard/dashboard_menu2.dart';
import 'package:css_mobile/widgets/dashboard/jlcpoint_widget.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return PopScope(
          canPop: controller.pop,
          onPopInvoked: (didPop) => controller.onPop(),
          child: Scaffold(
            // backgroundColor: greyLightColor1,
            // appBar: AppBar(
            //   backgroundColor: AppConst.isLightTheme(context)
            //       ? blueJNE : primaryDarkColor,
            //   titleTextStyle: titleTextStyle,
            //   // title: Text('Beranda'.tr),
            //   title: Image.asset(
            //     ImageConstant.logoCSS_white,
            //     height: 30,
            //   ),
            //   leading: null,
            //   actions: [
            //     IconButton(
            //       onPressed: () {},
            //       icon: const Icon(Icons.notifications),
            //     ),
            //     IconButton(
            //       onPressed: () => Get.to(const PengaturanScreen()),
            //       icon: const Icon(Icons.settings),
            //     ),
            //   ],
            // ),
            // body: ListView(
            //   children: [
            //   ],
            // ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            // height: controller.isLogin && controller.allow.lacakPesanan == "Y" ? 160 : 120,
                            height: controller.isLogin ? 220 : 180,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              // color: blueJNE,
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  color: Theme.of(context).brightness == Brightness.light ? blueJNE : primaryDarkColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        ImageConstant.logoCSS_white,
                                        height: 30,
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.notifications,
                                              color: whiteColor,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => Get.to(const PengaturanScreen()),
                                            icon: const Icon(
                                              Icons.settings,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                controller.isLogin
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomLabelText(
                                            title: 'Selamat Datang'.tr,
                                            value: controller.userName ?? 'USERNAME',
                                            fontColor: whiteColor,
                                            isLoading: controller.isLoading,
                                          ),
                                          controller.isLogin || controller.allow.bonus != "Y"
                                              ? GestureDetector(
                                                  onTap: () => Get.to(const BonusKamuScreen()),
                                                  child: JLCPointWidget(
                                                    point: controller.jlcPoint ?? '0',
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      )
                                    : const SizedBox(),
                                const SizedBox(height: 15),
                                /*!controller.isLogin || controller.allow.lacakPesanan == "Y"
                                    ? */
                                TextField(
                                  controller: controller.nomorResi,
                                  decoration: InputDecoration(
                                    hintText: 'Masukan nomor resi untuk lacak kiriman'.tr,
                                    hintStyle: hintTextStyle,
                                    suffixIcon: GestureDetector(
                                      onTap: () => Get.to(const BarcodeScanScreen(), arguments: {
                                        "cek_resi": true,
                                      })?.then((result) {
                                        controller.nomorResi.clear();
                                        controller.update();
                                      }),
                                      child: const Icon(
                                        Icons.qr_code,
                                        color: redJNE,
                                      ),
                                    ),
                                  ),
                                  // readOnly: true,
                                  onSubmitted: (value) => Get.to(const LacakKirimanScreen(), arguments: {
                                    'nomor_resi': value,
                                  })?.then((value) {
                                    controller.nomorResi.clear();
                                    controller.update();
                                  }),
                                )
                                // : const SizedBox(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: DashboardCarousel(
                              isLogin: controller.isLogin,
                              bannerList: controller.bannerList,
                            ),
                          ),
                        ],
                      ),
                      DashboardMarquee(
                        marqueeText: controller.marqueeText ?? '',
                      ),
                      DashboardMenu2(
                        isLogin: controller.isLogin,
                        menu: controller.menuItems,
                        getOtherMenu: () => Get.to(const OtherMenuScreen())?.then(
                          (result) => controller.cekFavoritMenu(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomBar2(
              menu: 0,
              isLogin: controller.isLogin,
              allowedMenu: controller.allow,
              // onTap: (index) {
              //   controller.selectedIndex.value = index;
              //   controller.update();
              //   // Get.offAll(const DashboardScreen(), arguments: index);
              // },
            ),
          ),
        );
      },
    );
  }
}

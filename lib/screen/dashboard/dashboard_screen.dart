import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/bonus_kamu/bonus_kamu_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/menu/other_menu_screen.dart';
import 'package:css_mobile/screen/notification/notification_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/barcode_scan_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_screen.dart';
import 'package:css_mobile/screen/pengaturan/pengaturan_screen.dart';
import 'package:css_mobile/widgets/bar/custombottombar4.dart';
import 'package:css_mobile/widgets/dashboard/dashboard_carousel.dart';
import 'package:css_mobile/widgets/dashboard/dashboard_info.dart';
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
            body: _bodyContent(controller, context),
            bottomNavigationBar: BottomBar4(
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

  Widget _bodyContent(DashboardController c, BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    // height: controller.isLogin && controller.allow.lacakPesanan == "Y" ? 160 : 120,
                    height: c.isLogin ? 220 : 180,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      // color: blueJNE,
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          color: Theme.of(context).colorScheme.primary,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                ImageConstant.logoCSS,
                                height: 30,
                                color: whiteColor,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => Get.to(const NotificationScreen()),
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
                        c.isLogin
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomLabelText(
                                    title: 'Selamat Datang'.tr,
                                    value: c.userName ?? '',
                                    fontColor: whiteColor,
                                    isLoading: c.isLoading,
                                  ),
                                  c.isLogin && (c.allow.keuanganBonus == "Y" || c.allow.bonus == "Y")
                                      ? GestureDetector(
                                          onTap: () => Get.to(const BonusKamuScreen()),
                                          child: JLCPointWidget(
                                            point: c.jlcPoint ?? '0',
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(height: 15),
                        !c.isLogin || (c.allow.lacakPesanan == "Y" || c.allow.keuanganBonus == "Y")
                            ? TextField(
                                controller: c.nomorResi,
                                decoration: InputDecoration(
                                  hintText: 'Masukan nomor resi untuk lacak kiriman'.tr,
                                  hintStyle: hintTextStyle,
                                  suffixIcon: GestureDetector(
                                    onTap: () => Get.to(
                                      const BarcodeScanScreen(),
                                      arguments: {
                                        "cek_resi": true,
                                      },
                                    )?.then((result) {
                                      c.nomorResi.clear();
                                      c.update();
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
                                  c.nomorResi.clear();
                                  c.update();
                                }),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: DashboardCarousel(
                      isLogin: c.isLogin,
                      bannerList: c.bannerList,
                    ),
                  ),
                ],
              ),
              // DashboardMarquee(
              //   marqueeText: c.marqueeText ?? '',
              // ),
              c.isCcrf ? const SizedBox() : const DashboardInfo(),
              DashboardMenu2(
                isLogin: c.isLogin,
                isLoading: c.isLoading,
                menu: c.menuItems,
                getOtherMenu: () => Get.to(const OtherMenuScreen(), arguments: {
                  'isLogin': c.isLogin,
                  'allowance': c.allow,
                })?.then(
                  (result) {
                    c.cekFavoritMenu();
                    c.cekAllowance();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

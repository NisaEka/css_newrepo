import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_appbar.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_kiriman_counts.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/notification/notification_screen.dart';
import 'package:css_mobile/screen/pengaturan/pengaturan_screen.dart';
import 'package:css_mobile/widgets/bar/custombottombar4.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_carousel.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_info.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_menu2.dart';
import 'package:css_mobile/screen/dashboard/components/jlcpoint_widget.dart';
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
            bottomNavigationBar: const BottomBar4(menu: 0),
          ),
        );
      },
    );
  }

  Widget _bodyContent(DashboardController c, BuildContext context) {
    return CustomScrollView(
      slivers: [
        const DashboardAppbar(),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    // height: c.state.isLogin && c.state.allow.lacakPesanan == "Y" ? 160 : 120,
                    height: c.state.isLogin ? 160 : 120,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        c.state.isLogin
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomLabelText(
                                    title: 'Selamat Datang'.tr,
                                    value: c.state.userName ?? '',
                                    fontColor: whiteColor,
                                    isLoading: c.state.isLoading,
                                  ),
                                  JLCPointWidget(point: c.state.jlcPoint ?? '0')
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(height: 15),
                        !c.state.isLogin || (c.state.allow.lacakPesanan == "Y" || c.state.allow.keuanganBonus == "Y")
                            ? TextField(
                                controller: c.state.nomorResi,
                                cursorColor: CustomTheme().cursorColor(context),
                                decoration: InputDecoration(
                                  hintText: 'Masukan nomor resi untuk lacak kiriman'.tr,
                                  hintStyle: hintTextStyle,
                                  suffixIcon: GestureDetector(
                                    onTap: () => c.onLacakKiriman(true, ''),
                                    child: const Icon(
                                      Icons.qr_code,
                                      color: redJNE,
                                    ),
                                  ),
                                ),
                                onSubmitted: (value) => c.onLacakKiriman(false, value),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  DashboardCarousel(),
                ],
              ),
              const DashboardInfo(),
              const DashboardMenu2(),
              const DashboardKirimanCounts(),
              const SizedBox(height: 50),
            ],
          ),
        ),

      ],
    );
  }
}

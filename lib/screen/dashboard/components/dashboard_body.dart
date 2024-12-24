import 'package:css_mobile/screen/dashboard/components/dashboard_info.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_kiriman_count_items.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_news.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_promo.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_user_info.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_appbar.dart';
import 'dashboard_kiriman_cod_count_items.dart';
import 'dashboard_menu2.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (c) {
          return RefreshIndicator(
            onRefresh: () => c
                .initData()
                .then(
                  (_) => c.loadBanner(),
                )
                .then((_) => c.loadNews())
                .then((_) {
              c.loadPantauCountList();
              c.loadTransCountList(true);
            }),
            child: CustomScrollView(
              slivers: [
                DashboardAppbar(notifCount: c.state.unreadNotifList.length),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const DashboardUserInfo(),
                      c.state.isLogin
                          ? const DashboardInfo()
                          : const SizedBox(),
                      const DashboardMenu2(),
                      // CustomFilledButton(
                      //   color: Colors.blue,
                      //   onPressed: () => Get.to(const Ob1Screen()),
                      // ),
                      // CustomFilledButton(
                      //   color: Colors.blue,
                      //   onPressed: () => Get.to(
                      //     SuccessScreen(
                      //       // lottie: ImageConstant.packedLottie,
                      //       // iconMargin: 100,
                      //       // customInfo: PackageInfoItem(),
                      //       // iconHeight: Get.width * 0.6,
                      //       message: 'message',
                      //       secondButtonTitle: 'second button',
                      //       onSecondAction: () {},
                      //       firstButtonTitle: 'firstbutton',
                      //       onFirstAction: () {},
                      //       thirdButtonTitle: 'third button',
                      //       onThirdAction: () {
                      //
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // c.state.isLogin &&
                      //         (c.state.allow.keuanganAggregasi == "Y" ||
                      //             c.state.allow.monitoringAgg == "Y")
                      //     ? DashboardAggCountItem(
                      //         transSummary: c.state.aggSummary,
                      //         transChart: c.state.aggChart,
                      //         isLoadingAgg: c.state.isLoadingAgg,
                      //       )
                      //     : const SizedBox(),
                      c.state.isLogin &&
                              (c.state.allow.riwayatPesanan == "Y" ||
                                  c.state.allow.paketmuRiwayat == 'Y')
                          ? DashboardKirimanCountItem(
                              transSummary: c.state.transSummary,
                              kirimanKamu: c.state.kirimanKamu,
                              isLoadingKiriman: c.state.isLoadingKiriman,
                              onRefresh: () {
                                c.loadPantauCountList();
                                c.loadTransCountList(false);
                              },
                            )
                          : const SizedBox(),

                      c.state.isLogin &&
                              (c.state.allow.riwayatPesanan == "Y" ||
                                  c.state.allow.paketmuRiwayat == 'Y')
                          ? DashboardKirimanCODCountItem(
                              transSummary: c.state.transSummary,
                              kirimanKamu: c.state.kirimanKamuCOD,
                              isLoadingKiriman: c.state.isLoadingKirimanCOD,
                              onRefresh: () {
                                c.loadTransCountList(true);
                              },
                            )
                          : const SizedBox(),

                      const DashboardPromo(),
                      const DashboardNews(),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

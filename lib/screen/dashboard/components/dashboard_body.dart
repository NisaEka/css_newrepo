import 'package:css_mobile/screen/dashboard/components/dashboard_kiriman_count_items.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_news.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_promo.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_user_info.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_appbar.dart';
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
              c.loadTransCountList();
            }),
            child: CustomScrollView(
              slivers: [
                const DashboardAppbar(),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const DashboardUserInfo(),
                      const DashboardMenu2(),
                      // c.state.isLogin &&
                      //         (c.state.allow.keuanganAggregasi == "Y" ||
                      //             c.state.allow.monitoringAgg == "Y")
                      //     ? DashboardAggCountItem(
                      //         transSummary: c.state.aggSummary,
                      //         transChart: c.state.aggChart,
                      //         isLoadingAgg: c.state.isLoadingAgg,
                      //       )
                      //     : const SizedBox(),
                      c.state.isLogin
                          ? DashboardKirimanCountItem(
                              transSummary: c.state.transSummary,
                              kirimanKamu: c.state.kirimanKamu,
                              isLoadingKiriman: c.state.isLoadingKiriman,
                            )
                          : const SizedBox(),
                      // const SizedBox(height: 50),
                      // c.state.isLogin
                      //     ? DashboardCountItems(
                      //         title: 'Kiriman Kamu'.tr,
                      //         total: c.state.transSummary?.summary?.where((e) => e.status == 'Jumlah Transaksi').first.total?.toInt() ?? 0,
                      //       )
                      //     : const SizedBox(),
                      // c.state.isLogin,
                      //     ? const DashboardKirimanCounts()
                      //     : const SizedBox(),
                      // c.state.isLogin
                      //     ? const DashboardKirimanCod()
                      //     : const SizedBox(),
                      const DashboardPromo(),
                      const DashboardNews(),
                      const SizedBox(height: 50),
                      // CustomFilledButton(
                      //   color: Colors.blue,
                      //   onPressed: () => Get.to(const Ob1Screen()),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

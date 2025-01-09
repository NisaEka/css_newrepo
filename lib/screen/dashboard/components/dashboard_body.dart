import 'package:css_mobile/screen/dashboard/components/dashboard_aggregation_count_items.dart';
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
                  (_) => c.loadPromo(),
                )
                .then((_) => c.loadNews())
                .then((_) {
              c.loadPantauCountList();
              c.loadTransCountList(true);
              c.getAggregation();
              c.getAggregationMinus();
              c.getAggregation();
              c.getAggregationMinus();
            }),
            child: CustomScrollView(
              slivers: [
                DashboardAppbar(
                  notifCount: c.state.unreadNotifList.length,
                  onRefresh: (p0) => c.cekMessages(),
                ),
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
                      c.state.isLogin &&
                              (c.state.allow.riwayatPesanan == "Y" ||
                                  c.state.allow.paketmuRiwayat == 'Y')
                          ? DashboardAggregationCountItem(
                              aggregationPembayaran: c.state.aggregationModel,
                              aggregationMinus: c.state.aggregationMinus,
                              isLoading: c.state.isLoadAggregation,
                            )
                          : const SizedBox(),
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
                                  c.state.allow.paketmuRiwayat == 'Y') &&
                              (c.state.allow.accountCod == "Y")
                          ? DashboardKirimanCODCountItem(
                              transSummary: c.state.transSummary,
                              kirimanKamu: c.state.kirimanKamuCOD,
                              isLoadingKiriman: c.state.isLoadingKirimanCOD ||
                                  (c.state.transSummary?.summary?.isEmpty ??
                                      false),
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

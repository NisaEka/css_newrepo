import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_kiriman_count_items.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_news.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_promo.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_appbar.dart';
import 'dashboard_info.dart';
import 'dashboard_menu2.dart';
import 'jlcpoint_widget.dart';

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
                      Stack(
                        children: [
                          Container(
                            // height: c.state.isLogin && c.state.allow.lacakPesanan == "Y" ? 160 : 120,
                            height: !c.state.isLogin
                                ? 120
                                : !c.state.isCcrf
                                    ? 200
                                    : 180,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                c.state.isLogin
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomLabelText(
                                            title: 'Selamat Datang'.tr,
                                            value: c.state.userName ?? '',
                                            fontColor: whiteColor,
                                            isLoading: c.state.isLoading,
                                          ),
                                          JLCPointWidget(
                                              point: c.state.jlcPoint ?? '0')
                                        ],
                                      )
                                    : const SizedBox(),
                                SizedBox(height: c.state.isCcrf ? 15 : 0),
                                c.state.isLogin
                                    ? const DashboardInfo()
                                    : const SizedBox(),
                                !c.state.isLogin ||
                                        (c.state.allow.lacakPesanan == "Y" ||
                                            c.state.allow.keuanganBonus == "Y")
                                    ? TextField(
                                        controller: c.state.nomorResi,
                                        cursorColor:
                                            CustomTheme().cursorColor(context),
                                        decoration: InputDecoration(
                                          hintText:
                                              'Masukan nomor resi untuk lacak kiriman'
                                                  .tr,
                                          hintStyle: hintTextStyle,
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              c.onLacakKiriman(true, '');
                                            },
                                            child: const Icon(
                                              Icons.qr_code,
                                              color: redJNE,
                                            ),
                                          ),
                                        ),
                                        onSubmitted: (value) {
                                          if (value.isEmpty) {
                                            Get.showSnackbar(
                                              GetSnackBar(
                                                icon: const Icon(
                                                  Icons.warning,
                                                  color: whiteColor,
                                                ),
                                                message:
                                                    'Nomor resi tidak boleh kosong'
                                                        .tr,
                                                isDismissible: true,
                                                duration:
                                                    const Duration(seconds: 3),
                                                backgroundColor: errorColor,
                                              ),
                                            );
                                          } else if (value.length != 16) {
                                            Get.showSnackbar(
                                              GetSnackBar(
                                                icon: const Icon(
                                                  Icons.warning,
                                                  color: whiteColor,
                                                ),
                                                message:
                                                    'Nomor resi harus terdiri dari 16 karakter'
                                                        .tr,
                                                isDismissible: true,
                                                duration:
                                                    const Duration(seconds: 3),
                                                backgroundColor: errorColor,
                                              ),
                                            );
                                          } else {
                                            c.onLacakKiriman(false, value);
                                          }
                                        },
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          // DashboardCarousel(),
                        ],
                      ),
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

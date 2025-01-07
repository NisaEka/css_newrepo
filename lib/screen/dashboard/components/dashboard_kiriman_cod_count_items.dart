import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/dashboard_kiriman_kamu_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_summary_model.dart';
import 'package:css_mobile/screen/dashboard/components/dashboard_mini_count.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/items/line_chart_item.dart';
import 'package:css_mobile/widgets/items/transaction_card.dart';
import 'package:css_mobile/widgets/items/type_transaction_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardKirimanCODCountItem extends StatelessWidget {
  final TransactionSummaryModel? transSummary;
  final DashboardKirimanKamuModel kirimanKamu;
  final bool isLoadingKiriman;
  final VoidCallback? onRefresh;

  const DashboardKirimanCODCountItem({
    super.key,
    this.transSummary,
    required this.kirimanKamu,
    this.isLoadingKiriman = false,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              AppConst.isLightTheme(context) ? greyLightColor3 : greyDarkColor1,
        ),
        color:
            AppConst.isLightTheme(context) ? greyLightColor3 : greyDarkColor1,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppConst.isLightTheme(context) ? whiteColor : bgDarkColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Kiriman COD Kamu".tr,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer(
                      isLoading: isLoadingKiriman,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TransactionCard(
                            // title: "Jumlah Transaksi".tr,
                            // height: 140,
                            height: screenWidth < 400 ? Get.height * 0.24 : 140,
                            customTitle: DashboardMiniCount(
                              width: screenWidth < 400
                                  ? Get.width * 0.16
                                  : Get.width * 0.18,
                              margin: EdgeInsets.zero,
                              label: 'Jumlah Transaksi COD'.tr,
                              value: (transSummary?.totalKirimanCod?.totalCod)
                                  .toString(),
                              labelBgColor: blueJNE,
                              valueBgColor: warningColor,
                              fontSize: 5,
                            ),
                            lineChartCountValue: "Rp.",
                            count: kirimanKamu.totalKiriman.toCurrency(),
                            subtitle: '${"7 Hari Terakhir".tr}\n',
                            color: primaryColor(context),
                            icon: Icons.show_chart,
                            statusColor: whiteColor,
                            countValueChart: SizedBox(
                              width: 45,
                              height: 20,
                              child: kirimanKamu.lineChart.isNotEmpty
                                  ? LineChartItem(kirimanKamu.lineChart
                                      .map((e) => e.toDouble())
                                      .toList())
                                  : const SizedBox(),
                            ),
                          ),
                          TransactionCard(
                            height: screenWidth < 400 ? Get.height * 0.24 : 140,
                            customTitle: DashboardMiniCount(
                              width: Get.width * 0.19,
                              margin: EdgeInsets.zero,
                              label: 'Belum Terkumpul dari pembeli'.tr,
                              value: kirimanKamu.onProcess.toString(),
                              labelBgColor: blueJNE,
                              valueBgColor: errorColor,
                              fontSize: 5,
                            ),
                            countValue: "Rp.\n",
                            count: transSummary?.summary
                                    ?.where(
                                      (e) => e.status == 'Belum Terkumpul',
                                    )
                                    .first
                                    .codAmount
                                    ?.toInt()
                                    .toCurrency() ??
                                '0',
                            subtitle:
                                "${double.parse((kirimanKamu.suksesDiterimaPercentage).toStringAsFixed(2))}% ${'dari jumlah transaksi'.tr}",
                            color: primaryColor(context),
                            statusColor: Colors.green,
                            prefixChart: SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                value: (kirimanKamu.suksesDiterimaPercentage
                                        .toDouble() /
                                    100),
                                backgroundColor: Colors.grey[300],
                                color: Colors.green,
                                strokeWidth: 4,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TransactionCard(
                                height:
                                    screenWidth < 400 ? Get.height * 0.24 : 140,
                                customTitle: Column(
                                  children: [
                                    DashboardMiniCount(
                                      width: Get.width * 0.19,
                                      margin: EdgeInsets.zero,
                                      label: 'Terkumpul dari pembeli'.tr,
                                      value:
                                          kirimanKamu.suksesDiterima.toString(),
                                      labelBgColor: blueJNE,
                                      valueBgColor: successColor,
                                      fontSize: 5,
                                    ),
                                    const SizedBox(height: 7.5)
                                  ],
                                ),
                                countValue: "Rp.\n",
                                count: transSummary?.summary
                                        ?.where(
                                          (e) => e.status == 'Sukses Diterima',
                                        )
                                        .first
                                        .codAmount
                                        ?.toInt()
                                        .toCurrency() ??
                                    '0',
                                subtitle:
                                    "${double.parse((kirimanKamu.suksesDiterimaPercentage).toStringAsFixed(2))}% ${'dari jumlah transaksi'.tr}",
                                color: primaryColor(context),
                                statusColor: Colors.green,
                                suffixChart: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    value: (kirimanKamu.suksesDiterimaPercentage
                                            .toDouble() /
                                        100),
                                    backgroundColor: Colors.grey[300],
                                    color: Colors.green,
                                    strokeWidth: 4,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width / 2.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TypeTransactionCard(
                                prefixVal1: "Rp.",
                                value1: kirimanKamu.codOngkirAmount
                                    .toInt()
                                    .toCurrency(),
                                suffixVal2: "Kiriman".tr,
                                value2: kirimanKamu.totalCodOngkir
                                    .toInt()
                                    .toCurrency(),
                                description: "Dalam Peninjauan".tr,
                                lineColor: warningColor,
                                isLoading: isLoadingKiriman,
                              ),
                              isLoadingKiriman
                                  ? const SizedBox(height: 5)
                                  : const SizedBox(),
                              TypeTransactionCard(
                                prefixVal1: "Rp.",
                                value1: kirimanKamu.nonCodAmount
                                    .toInt()
                                    .toCurrency(),
                                suffixVal2: "Kiriman".tr,
                                value2: kirimanKamu.totalNonCod
                                    .toInt()
                                    .toCurrency(),
                                description: "Dibatalkan Oleh Kamu".tr,
                                lineColor: errorColor,
                                isLoading: isLoadingKiriman,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 2.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TypeTransactionCard(
                                prefixVal1: "Rp.",
                                value1: transSummary?.summary
                                        ?.where(
                                          (e) => e.status == "Sudah Kembali",
                                        )
                                        .first
                                        .codAmount
                                        ?.toInt()
                                        .toCurrency() ??
                                    '0',
                                suffixVal2: "Kiriman".tr,
                                value2: transSummary?.summary
                                        ?.where(
                                          (e) => e.status == "Sudah Kembali",
                                        )
                                        .first
                                        .totalCod
                                        ?.toInt()
                                        .toCurrency() ??
                                    '0',
                                description: "Sudah Kembali".tr,
                                lineColor: successColor,
                                isLoading: isLoadingKiriman,
                              ),
                              isLoadingKiriman
                                  ? const SizedBox(height: 5)
                                  : const SizedBox(),
                              TypeTransactionCard(
                                prefixVal1: "Rp.",
                                value1:
                                    kirimanKamu.codAmount.toInt().toCurrency(),
                                suffixVal2: "Kiriman".tr,
                                value2:
                                    kirimanKamu.totalCod.toInt().toCurrency(),
                                description: "Butuh di Cek".tr,
                                lineColor: infoColor,
                                isLoading: isLoadingKiriman,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRefresh,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.clock_solid,
                      size: 15,
                      color: AppConst.isLightTheme(context)
                          ? redJNE
                          : warningColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.centerLeft,
                      child: StreamBuilder<int>(
                        stream: Stream.periodic(
                            const Duration(seconds: 3), (count) => count),
                        builder: (context, snapshot) {
                          int currentSecond = snapshot.data ?? 0;
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              final slideAnimation = Tween<Offset>(
                                begin: currentSecond % 2 == 0
                                    ? const Offset(0, 1)
                                    : const Offset(0, 1),
                                end: Offset.zero,
                              ).animate(animation);
                              final fadeAnimation = Tween<double>(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(animation);
                              return SlideTransition(
                                position: slideAnimation,
                                child: FadeTransition(
                                  opacity: fadeAnimation,
                                  child: child,
                                ),
                              );
                            },
                            child: SizedBox(
                              width: double.infinity,
                              key: ValueKey<int>(currentSecond),
                              child: Text(
                                Constant
                                    .dashboardRefreshText[currentSecond %
                                        Constant.dashboardRefreshText.length]
                                    .tr,
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.normal),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

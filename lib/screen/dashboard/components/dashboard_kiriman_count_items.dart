import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/dashboard_kiriman_kamu_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_summary_model.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/widgets/dialog/circular_loading.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/items/line_chart_item.dart';
import 'package:css_mobile/widgets/items/ongoing_card.dart';
import 'package:css_mobile/widgets/items/transaction_card.dart';
import 'package:css_mobile/widgets/items/type_transaction_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardKirimanCountItem extends StatelessWidget {
  final TransactionSummaryModel? transSummary;
  final DashboardKirimanKamuModel kirimanKamu;
  final bool isLoadingKiriman;

  const DashboardKirimanCountItem({
    super.key,
    this.transSummary,
    required this.kirimanKamu,
    this.isLoadingKiriman = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                Text("Kiriman Kamu".tr,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 3),
                Column(
                  children: [
                    Shimmer(
                      isLoading: isLoadingKiriman,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TransactionCard(
                              title: "Jumlah Transaksi".tr,
                              count: kirimanKamu.totalPantau,
                              subtitle: "7 Hari Terakhir".tr,
                              color: Colors.blue,
                              icon: Icons.show_chart,
                              statusColor: whiteColor,
                              chart: SizedBox(
                                  width: 45,
                                  height: 20,
                                  child: kirimanKamu.pantauChart.isNotEmpty
                                      ? LineChartItem(kirimanKamu.pantauChart
                                          .map((e) => e.toDouble())
                                          .toList())
                                      : const CircularLoading())),
                          const SizedBox(height: 5),
                          // Dalam Perjalanan
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OngoingTransactionCard(
                                title: "Dalam Peninjauan".tr,
                                percentage: (kirimanKamu
                                        .dalamPeninjauanPercentage
                                        .toDouble() /
                                    100),
                                count: kirimanKamu.dalamPeninjauan,
                                subtitle:
                                    "${double.parse((kirimanKamu.dalamPeninjauanPercentage).toStringAsFixed(2))}% ${'dari jumlah transaksi'.tr}",
                                notificationLabel: "Masih dikamu".tr,
                                notificationCount: transSummary?.summary
                                        ?.where(
                                            (e) => e.status == "Masih di Kamu")
                                        .first
                                        .total
                                        ?.toInt() ??
                                    0,
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                          // Transaksi Terkini
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TransactionCard(
                                title: "Transaksi Terkirim".tr,
                                count: kirimanKamu.suksesDiterima,
                                subtitle:
                                    "${double.parse((kirimanKamu.suksesDiterimaPercentage).toStringAsFixed(2))}% ${'dari jumlah transaksi'.tr}",
                                color: Colors.blue,
                                statusColor: Colors.green,
                                chart: SizedBox(
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
                      children: [
                        TypeTransactionCard(
                          count: kirimanKamu.totalCod.toString(),
                          amount: kirimanKamu.codAmount.toInt().toCurrency(),
                          description: "Transaksi COD",
                          lineColor: redJNE,
                          isLoading: isLoadingKiriman,
                        ),
                        TypeTransactionCard(
                          count: kirimanKamu.totalCodOngkir.toString(),
                          amount:
                              kirimanKamu.codOngkirAmount.toInt().toCurrency(),
                          description: "Transaksi COD Ongkir",
                          lineColor: warningColor,
                          isLoading: isLoadingKiriman,
                        ),
                        TypeTransactionCard(
                          count: kirimanKamu.totalNonCod.toString(),
                          description: "Transaksi NON COD",
                          lineColor: Colors.green,
                          isLoading: isLoadingKiriman,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          // Real Time
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(CupertinoIcons.clock),
                const SizedBox(width: 8),
                Text(
                  "Real Time\n${'Sentuh untuk sinkronisasi manual'.tr}",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/transaction_summary_model.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
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

  const DashboardKirimanCountItem({
    super.key,
    this.transSummary,
  });

  @override
  Widget build(BuildContext context) {
    int total = transSummary?.summary
            ?.where((e) => e.status == "Jumlah Transaksi")
            .first
            .total
            ?.toInt() ??
        0;

    double percentage(double part) {
      double percent = ((part / total) * (100)) / 100;

      if (percent.isInfinite || percent.isNaN) {
        return 0;
      }
      return percent;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
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
                      isLoading: transSummary == null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TransactionCard(
                              title: "Jumlah Transaksi".tr,
                              count: total,
                              subtitle: "7 Hari Terakhir".tr,
                              color: Colors.blue,
                              icon: Icons.show_chart,
                              statusColor: whiteColor,
                              chart: const SizedBox(
                                  width: 45,
                                  height: 20,
                                  child: LineChartItem(
                                      [100, 30, 20, 50, 60, 80, 100]))),
                          const SizedBox(height: 5),
                          // Dalam Perjalanan
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OngoingTransactionCard(
                                title: "Dalam Peninjauan".tr,
                                percentage: transSummary?.summary
                                        ?.where((e) =>
                                            e.status == "Dalam Peninjauan")
                                        .first
                                        .total
                                        ?.toDouble() ??
                                    0,
                                count: transSummary?.summary
                                        ?.where((e) =>
                                            e.status == "Dalam Peninjauan")
                                        .first
                                        .total
                                        ?.toInt() ??
                                    0,
                                subtitle:
                                    "${percentage(transSummary?.summary?.where((e) => e.status == "Dalam Peninjauan").first.total?.toDouble() ?? 0)}% dari jumlah transaksi",
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
                                count: transSummary?.summary
                                        ?.where((e) =>
                                            e.status == "Sukses Diterima")
                                        .first
                                        .total
                                        ?.toInt() ??
                                    0,
                                subtitle:
                                    "${percentage(transSummary?.summary?.where((e) => e.status == "Sukses Diterima").first.total?.toDouble() ?? 0)}% dari jumlah transaksi",
                                color: Colors.blue,
                                statusColor: Colors.green,
                                chart: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    value: percentage(transSummary?.summary
                                            ?.where((e) =>
                                                e.status == "Sukses Diterima")
                                            .first
                                            .total
                                            ?.toDouble() ??
                                        0),
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
                          count: transSummary?.totalKirimanCod?.totalCod
                                  .toString() ??
                              '',
                          amount: transSummary?.totalKirimanCod?.codAmount
                                  ?.toInt()
                                  .toCurrency()
                                  .toString() ??
                              '',
                          description: "Transaksi COD",
                          lineColor: redJNE,
                          isLoading: transSummary == null,
                        ),
                        TypeTransactionCard(
                          count: transSummary?.totalKirimanCod?.totalCodOngkir
                                  .toString() ??
                              '',
                          amount: transSummary?.totalKirimanCod?.codOngkirAmount
                              ?.toInt()
                              .toCurrency()
                              .toString(),
                          description: "Transaksi COD Ongkir",
                          lineColor: warningColor,
                          isLoading: transSummary == null,
                        ),
                        TypeTransactionCard(
                          count: transSummary?.totalKirimanCod?.totalNonCod
                                  ?.toInt()
                                  .toCurrency()
                                  .toString() ??
                              '',
                          description: "Transaksi NON COD",
                          lineColor: Colors.green,
                          isLoading: transSummary == null,
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

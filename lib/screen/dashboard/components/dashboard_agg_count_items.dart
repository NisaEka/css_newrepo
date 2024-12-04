import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/transaction_summary_model.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/items/line_chart_item.dart';
import 'package:css_mobile/widgets/items/transaction_card.dart';
import 'package:css_mobile/widgets/items/type_transaction_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardAggCountItem extends StatelessWidget {
  final TransactionSummaryModel? transSummary;
  final bool isLoading;

  const DashboardAggCountItem({
    super.key,
    this.transSummary,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    int total = transSummary?.summary
            ?.where((e) => e.status == "Jumlah Transaksi")
            .first
            .totalCod
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
                Text("Aggregasi Pembayaran".tr,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 3),
                Column(
                  children: [
                    Shimmer(
                      isLoading: isLoading,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TransactionCard(
                              title: "Jumlah Transaksi".tr,
                              count: total,
                              subtitle: "7 Hari Terakhir",
                              color: Colors.blue,
                              icon: Icons.show_chart,
                              statusColor: whiteColor,
                              chart: const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: LineChartItem([10, 30, 20, 50]))),
                          const SizedBox(height: 5),
                          // Dalam Perjalanan
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TransactionCard(
                                title: "Belum di Transfer",
                                count: transSummary?.summary
                                        ?.where((e) =>
                                            e.status == "Belum di Transfer")
                                        .first
                                        .totalCod
                                        ?.toInt() ??
                                    0,
                                subtitle:
                                    "${percentage(transSummary?.summary?.where((e) => e.status == "Belum di Transfer").first.totalCod?.toDouble() ?? 0)}% dari jumlah transaksi",
                                color: Colors.blue,
                                statusColor: Colors.red,
                                chart: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    value: percentage(transSummary?.summary
                                            ?.where((e) =>
                                                e.status == "Belum di Transfer")
                                            .first
                                            .totalCod
                                            ?.toDouble() ??
                                        0),
                                    backgroundColor: Colors.grey[300],
                                    color: Colors.red,
                                    strokeWidth: 4,
                                  ),
                                ),
                              ),
                              // OngoingTransactionCard(
                              //   title: "Belum di Transfer".tr,
                              //   percentage: transSummary?.summary?.where((e) => e.status == "Belum di Transfer").first.totalCod?.toDouble() ?? 0,
                              //   count: transSummary?.summary?.where((e) => e.status == "Belum di Transfer").first.totalCod?.toInt() ?? 0,
                              //   subtitle:
                              //       "${percentage(transSummary?.summary?.where((e) => e.status == "Belum di Transfer").first.totalCod?.toDouble() ?? 0)}% dari jumlah transaksi",
                              // ),
                              const SizedBox(height: 5),
                            ],
                          ),
                          // Transaksi Terkini
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TransactionCard(
                                title: "Sudah di Transfer",
                                count: transSummary?.summary
                                        ?.where((e) =>
                                            e.status == "Sudah di Transfer")
                                        .first
                                        .totalCod
                                        ?.toInt() ??
                                    0,
                                subtitle:
                                    "${percentage(transSummary?.summary?.where((e) => e.status == "Sudah di Transfer").first.totalCod?.toDouble() ?? 0)}% dari jumlah transaksi",
                                color: Colors.blue,
                                statusColor: Colors.green,
                                chart: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    value: percentage(transSummary?.summary
                                            ?.where((e) =>
                                                e.status == "Sudah di Transfer")
                                            .first
                                            .totalCod
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
                          isLoading: isLoading,
                        ),
                        // TypeTransactionCard(
                        //   count: transSummary?.totalKirimanCod?.totalCodOngkir.toString() ?? '',
                        //   amount: transSummary?.totalKirimanCod?.codOngkirAmount?.toInt().toCurrency().toString(),
                        //   description: "Transaksi COD Ongkir",
                        //   lineColor: warningColor,
                        //   isLoading: isLoading,
                        // ),
                        // TypeTransactionCard(
                        //   count: transSummary?.totalKirimanCod?.totalNonCod?.toInt().toCurrency().toString() ?? '',
                        //   description: "Transaksi NON COD",
                        //   lineColor: Colors.green,
                        //   isLoading: isLoading,
                        // ),
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
                  "Real Time\nSentuh untuk sinkronisasi manual",
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

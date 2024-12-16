import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/dashboard_kiriman_kamu_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_summary_model.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/widgets/dialog/circular_loading.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/items/line_chart_item.dart';
import 'package:css_mobile/widgets/items/transaction_card.dart';
import 'package:css_mobile/widgets/items/type_transaction_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardKirimanCountItem extends StatelessWidget {
  final TransactionSummaryModel? transSummary;
  final DashboardKirimanKamuModel kirimanKamu;
  final bool isLoadingKiriman;
  final VoidCallback? onRefresh;

  const DashboardKirimanCountItem({
    super.key,
    this.transSummary,
    required this.kirimanKamu,
    this.isLoadingKiriman = false,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    List<String> messages = [
      "Realtime".tr,
      "Sentuh untuk sinkronisasi manual".tr,
    ];
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
                Text("Kiriman Kamu".tr,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
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
                              subtitle: '${"7 Hari Terakhir".tr}\n',
                              color: blueJNE,
                              icon: Icons.show_chart,
                              statusColor: whiteColor,
                              suffixChart: SizedBox(
                                  width: 45,
                                  height: 20,
                                  child: kirimanKamu.pantauChart.isNotEmpty
                                      ? LineChartItem(kirimanKamu.pantauChart
                                          .map((e) => e.toDouble())
                                          .toList())
                                      : const CircularLoading())),
                          // Dalam Perjalanan
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TransactionCard(
                                title: "Dalam Peninjauan".tr,
                                count: kirimanKamu.dalamPeninjauan,
                                subtitle:
                                    "${double.parse((kirimanKamu.dalamPeninjauanPercentage).toStringAsFixed(2))}% ${'dari jumlah transaksi'.tr}",
                                color: redJNE,
                                innerPadding: 2,
                                isLoading: isLoadingKiriman,
                                notificationLabel: "Masih dikamu".tr,
                                notificationCount: transSummary?.summary
                                        ?.where(
                                            (e) => e.status == "Masih di Kamu")
                                        .first
                                        .total
                                        ?.toInt() ??
                                    0,
                                prefixChart: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    value: (kirimanKamu
                                            .dalamPeninjauanPercentage
                                            .toDouble() /
                                        100),
                                    backgroundColor: Colors.grey[300],
                                    color: redJNE,
                                    strokeWidth: 4,
                                  ),
                                ),
                              ),
                              // OngoingTransactionCard(
                              //   title: "Dalam Peninjauan".tr,
                              //   percentage: (kirimanKamu.dalamPeninjauanPercentage.toDouble() / 100),
                              //   count: kirimanKamu.dalamPeninjauan,
                              //   subtitle:
                              //       "${double.parse((kirimanKamu.dalamPeninjauanPercentage).toStringAsFixed(2))}% ${'dari jumlah transaksi'.tr}",
                              //   notificationLabel: "Masih dikamu".tr,
                              //   notificationCount: transSummary?.summary?.where((e) => e.status == "Masih di Kamu").first.total?.toInt() ?? 0,
                              // ),
                              const SizedBox(height: 16),
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
                                color: blueJNE,
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
                const SizedBox(height: 8),
              ],
            ),
          ),
          // Real Time
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
                            duration: const Duration(
                                milliseconds: 300), // Durasi transisi
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
                                messages[currentSecond % messages.length],
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

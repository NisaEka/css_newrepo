import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/widgets/items/ongoing_card.dart';
import 'package:css_mobile/widgets/items/transaction_card.dart';
import 'package:css_mobile/widgets/items/type_transaction_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardCountItems extends StatelessWidget {
  final String title;
  final int total;
  final int totalCOD;

  const DashboardCountItems({
    super.key,
    required this.title,
    required this.total,
    required this.totalCOD,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: greyLightColor3),
              color: greyLightColor3,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppConst.isLightTheme(context)
                        ? whiteColor
                        : bgDarkColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleMedium),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Jumlah Transaksi
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TransactionCard(
                                    title: "Jumlah Transaksi",
                                    count: total,
                                    subtitle: "7 Hari Terakhir",
                                    color: Colors.blue,
                                    icon: Icons.show_chart,
                                    statusColor: whiteColor,
                                    chart: const Icon(
                                      Icons.show_chart,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  TypeTransactionCard(
                                    count: totalCOD.toString(),
                                    amount: "Rp. 2.000.000",
                                    description: "Transaksi COD",
                                    lineColor: Colors.red,
                                  ),
                                ],
                              ),
                              // Dalam Perjalanan
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OngoingTransactionCard(
                                    title: "Dalam Peninjauan",
                                    percentage: 0.90,
                                    count: 10,
                                    subtitle: "100% dari jumlah transaksi",
                                    notificationLabel: "Masih dikamu",
                                    notificationCount: 10,
                                  ),
                                  SizedBox(height: 5),
                                  TypeTransactionCard(
                                    count: "50",
                                    amount: "Rp. 2.00.000",
                                    description: "Transaksi COD Ongkir",
                                    lineColor: warningColor,
                                  ),
                                ],
                              ),
                              // Transaksi Terkini
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TransactionCard(
                                    title: "Transaksi Terkini",
                                    count: 50,
                                    subtitle: "25% dari jumlah transaksi",
                                    color: Colors.blue,
                                    statusColor: Colors.green,
                                    chart: SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: CircularProgressIndicator(
                                        value: 0.90,
                                        backgroundColor: Colors.grey[300],
                                        color: Colors.green,
                                        strokeWidth: 4,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const TypeTransactionCard(
                                    count: "50",
                                    amount: "Rp. 2.000.000",
                                    description: "Transaksi NON COD",
                                    lineColor: Colors.green,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const TransactionCard(
                      //         title: "Jumlah Transaksi",
                      //         count: 200,
                      //         subtitle: "7 Hari Terakhir",
                      //         color: Colors.blue,
                      //         icon: Icons.show_chart,
                      //         statusColor: whiteColor,
                      //         chart: Icon(
                      //           Icons.show_chart,
                      //           color: Colors.green,
                      //         )
                      //     ),
                      //     const SizedBox(width: 5),
                      //     const OngoingTransactionCard(
                      //       title: "Dalam Peninjauan",
                      //       percentage: 0.90,
                      //       count: 10,
                      //       subtitle: "100% dari jumlah transaksi",
                      //       notificationLabel: "Masih dikamu",
                      //       notificationCount: 10,
                      //     ),
                      //     const SizedBox(width: 5),
                      //     TransactionCard(
                      //       title: "Transaksi Terkini",
                      //       count: 50,
                      //       subtitle: "25% dari jumlah transaksi",
                      //       color: Colors.blue,
                      //       statusColor: Colors.green,
                      //       chart: CircularProgressIndicator(
                      //         value: 0.90,
                      //         backgroundColor: Colors.grey[300],
                      //         color: Colors.green,
                      //         strokeWidth: 5,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     TypeTransactionCard(
                      //       count: "100",
                      //       amount: "Rp. 2.000.000",
                      //       description: "Transaksi COD",
                      //       lineColor: Colors.red,
                      //     ),
                      //     SizedBox(width: 60),
                      //     TypeTransactionCard(
                      //       count: "100",
                      //       amount: "Rp. 2.000.000",
                      //       description: "Transaksi COD",
                      //       lineColor: warningColor,
                      //     ),
                      //     SizedBox(width: 40),
                      //     TypeTransactionCard(
                      //         count: "100",
                      //         amount: "Rp. 2.000.000",
                      //         description: "Transaksi COD",
                      //         lineColor: Colors.green
                      //     ),
                      //   ],
                      // ),
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
        });
  }
// Jumlah Transaksi & Transaksi Terkirim
// Widget _transactionCard({
//   required String title,
//   required String value,
//   required String subtitle,
//   required Color color,
//   required IconData icon,
// }) {
//   return Container(
//     padding: EdgeInsets.all(8),
//     width: Get.width * 0.3,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(8),
//       border: Border.all(color: greyLightColor3),
//       color: whiteColor,
//     ),
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: blueJNE,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                       Icons.circle,
//                       color: whiteColor,
//                       size: 10
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 8
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 12),
//         Row(
//           children: [
//             Text(
//               value.toString(),
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Spacer(),
//             Icon(
//               icon,
//               color: Colors.green,
//             ),
//           ],
//         ),
//         SizedBox(height: 8),
//         Text(
//           subtitle,
//           style: TextStyle(
//             color: Colors.grey[600],
//             fontSize: 8
//           ),
//         ),
//       ],
//     ),
//   );
// }
}

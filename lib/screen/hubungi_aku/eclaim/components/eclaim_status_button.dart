import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/eclaim_controller.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EclaimStatusButton extends StatelessWidget {
  const EclaimStatusButton({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    return GetBuilder<EclaimController>(
        init: EclaimController(),
        builder: (c) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Total Pengajuan
                Container(
                  width: screenWidth * 0.4,
                  decoration: BoxDecoration(
                    color: blueJNE,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Pengajuan',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: bold,
                                    color: Colors.black)),
                            const SizedBox(height: 7),
                            Text(
                              c.state.countModel?.totalCount.toString() ?? '0',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 7),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, bottom: 4, top: 2),
                        child: Text(
                          'Rp. ${c.state.countModel?.totalAmount?.toCurrency().toString() ?? '0'}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Diterima
                Container(
                  width: screenWidth * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 18,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      c.state.countModel?.acceptedCount
                                              .toString() ??
                                          '0',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      'Diterima',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, bottom: 4, top: 2),
                        child: Text(
                          'Rp. ${c.state.countModel?.acceptedAmount?.toCurrency().toString() ?? '0'}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Ditolak
                Container(
                  width: screenWidth * 0.2,
                  decoration: BoxDecoration(
                    color: redJNE,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.cancel_outlined,
                              color: redJNE,
                              size: 18,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      c.state.countModel?.rejectedCount
                                              .toString() ??
                                          '0',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Text(
                                      'Ditolak',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, bottom: 4, top: 2),
                        child: Text(
                          'Rp. ${c.state.countModel?.rejectedAmount?.toCurrency().toString() ?? '0'}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

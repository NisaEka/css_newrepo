import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/eclaim_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EclaimStatusButton extends StatelessWidget {
  const EclaimStatusButton({super.key});

  @override
  Widget build(BuildContext context) {
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
                    decoration: BoxDecoration(
                      color: blueJNE,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 30, top: 16, bottom: 16),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Pengajuan',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: bold,
                                    color: Colors.black
                                ),
                              ),
                              const SizedBox(height: 6),
                               Text(
                                c.state.total.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),
                              ),
                              const SizedBox(height: 6),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 3, top: 3),
                          child: Text(
                                'Rp. 1.000.000',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: whiteColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                // Diterima
                Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                              decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                      size: 18,
                                    )
                                  ],
                                ),
                                const Text(
                                  "1",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Diterima',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: bold,
                                      color: Colors.black
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, bottom: 3, top: 3),
                            child: Text(
                              'Rp. 500.000',
                              style: TextStyle(
                                fontSize: 8,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                // Ditolak
                Container(
                      decoration: BoxDecoration(
                        color: redJNE,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                              decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.cancel_outlined,
                                      color: redJNE,
                                      size: 18,
                                    ),
                                  ],
                                ),
                                const Text(
                                  "1",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Ditolak',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: bold,
                                      color: Colors.black
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, bottom: 3, top: 3),
                            child: Text(
                              'Rp. 500.000',
                              style: TextStyle(
                                fontSize: 8,
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


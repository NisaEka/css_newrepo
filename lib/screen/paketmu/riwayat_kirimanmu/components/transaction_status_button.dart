import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionStatusButton extends StatelessWidget {
  const TransactionStatusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiwayatKirimanController>(
        init: RiwayatKirimanController(),
        builder: (c) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: blueJNE,
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    c.state.selectedKiriman = 0;
                    c.state.transType = '';
                    c.update();
                    c.state.pagingController.refresh();
                  },
                  child: Container(
                    width: Get.width / 5,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          c.state.selectedKiriman == 0 ? blueJNE : whiteColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      // border: const Border(
                      //   right: BorderSide(color: greyDarkColor1),
                      // ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          c.state.total.toString(),
                          style: listTitleTextStyle.copyWith(
                            color: c.state.selectedKiriman == 0
                                ? whiteColor
                                : blueJNE,
                          ),
                        ),
                        Text(
                          'Kiriman'.tr,
                          style: sublistTitleTextStyle.copyWith(
                            color: c.state.selectedKiriman == 0
                                ? whiteColor
                                : greyColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    c.state.selectedKiriman = 1;
                    c.state.transType = 'COD';
                    c.update();
                    c.state.pagingController.refresh();
                  },
                  child: Container(
                    width: Get.width / 5,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          c.state.selectedKiriman == 1 ? blueJNE : whiteColor,
                      // border: const Border(
                      //   right: BorderSide(color: greyDarkColor1),
                      //   left: BorderSide(color: greyDarkColor1),
                      // ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          c.state.cod.toString(),
                          style: listTitleTextStyle.copyWith(
                            color: c.state.selectedKiriman == 1
                                ? whiteColor
                                : blueJNE,
                          ),
                        ),
                        Text(
                          'COD'.tr,
                          style: sublistTitleTextStyle.copyWith(
                            color: c.state.selectedKiriman == 1
                                ? whiteColor
                                : greyColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    c.state.selectedKiriman = 2;
                    c.state.transType = 'NON COD';
                    c.update();
                    c.state.pagingController.refresh();
                  },
                  child: Container(
                    width: Get.width / 5,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          c.state.selectedKiriman == 2 ? blueJNE : whiteColor,
                      // border: const Border(
                      //   right: BorderSide(color: greyDarkColor1),
                      // ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          c.state.noncod.toString(),
                          style: listTitleTextStyle.copyWith(
                            color: c.state.selectedKiriman == 2
                                ? whiteColor
                                : blueJNE,
                          ),
                        ),
                        Text(
                          'NON COD'.tr,
                          style: sublistTitleTextStyle.copyWith(
                            color: c.state.selectedKiriman == 2
                                ? whiteColor
                                : greyColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    c.state.selectedKiriman = 3;
                    c.state.transType = 'COD ONGKIR';
                    c.update();
                    c.state.pagingController.refresh();
                  },
                  child: Container(
                    width: Get.width / 4.5,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          c.state.selectedKiriman == 3 ? blueJNE : whiteColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          c.state.codOngkir.toString(),
                          style: listTitleTextStyle.copyWith(
                            color: c.state.selectedKiriman == 3
                                ? whiteColor
                                : blueJNE,
                          ),
                        ),
                        Text(
                          'COD ONGKIR'.tr,
                          style: sublistTitleTextStyle.copyWith(
                            color: c.state.selectedKiriman == 3
                                ? whiteColor
                                : greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

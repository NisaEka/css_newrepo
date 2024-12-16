import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PantauStatusButton extends StatelessWidget {
  const PantauStatusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PantauPaketmuController>(
        init: PantauPaketmuController(),
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
                    width: Get.width * 0.28,
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
                          c.state.cod.toString(),
                          style: listTitleTextStyle.copyWith(
                            color: c.state.selectedKiriman == 0
                                ? whiteColor
                                : blueJNE,
                          ),
                        ),
                        Text(
                          'COD'.tr,
                          style: listTitleTextStyle.copyWith(
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
                    width: Get.width * 0.28,
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
                          c.state.codOngkir.toString(),
                          style: listTitleTextStyle.copyWith(
                            color: c.state.selectedKiriman == 1
                                ? whiteColor
                                : blueJNE,
                          ),
                        ),
                        Text(
                          'COD ONGKIR'.tr,
                          style: listTitleTextStyle.copyWith(
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
                    width: Get.width * 0.28,
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
                          style: listTitleTextStyle.copyWith(
                            color: c.state.selectedKiriman == 2
                                ? whiteColor
                                : greyColor,
                          ),
                        )
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

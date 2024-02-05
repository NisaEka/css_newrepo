import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/items/riwayat_kiriman_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RiwayatKirimanScreen extends StatelessWidget {
  const RiwayatKirimanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiwayatKirimanController>(
        init: RiwayatKirimanController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Riwayat Kiriman'.tr,
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Column(
                children: [
                  CustomSearchField(
                    hintText: 'Cari'.tr,
                    prefixIcon: SvgPicture.asset(
                      IconsConstant.search,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.selectedKiriman = 0;
                          controller.update();
                        },
                        child: Container(
                          width: Get.width / 4,
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: controller.selectedKiriman == 0 ? blueJNE : whiteColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            border: Border.all(color: greyDarkColor1),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '10.000',
                                style: listTitleTextStyle.copyWith(
                                  color: controller.selectedKiriman == 0 ? whiteColor : blueJNE,
                                ),
                              ),
                              Text(
                                'Kiriman'.tr,
                                style: sublistTitleTextStyle.copyWith(
                                  color: controller.selectedKiriman == 0 ? whiteColor : greyColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.selectedKiriman = 1;
                          controller.update();
                        },
                        child: Container(
                          width: Get.width / 4,
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: controller.selectedKiriman == 1 ? blueJNE : whiteColor,
                            border: const Border.symmetric(
                              horizontal: BorderSide(color: greyDarkColor1),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '7.000',
                                style: listTitleTextStyle.copyWith(
                                  color: controller.selectedKiriman == 1 ? whiteColor : blueJNE,
                                ),
                              ),
                              Text(
                                'COD'.tr,
                                style: sublistTitleTextStyle.copyWith(
                                  color: controller.selectedKiriman == 1 ? whiteColor : greyColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.selectedKiriman = 2;
                          controller.update();
                        },
                        child: Container(
                          width: Get.width / 4,
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: controller.selectedKiriman == 2 ? blueJNE : whiteColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            border: Border.all(color: greyDarkColor1),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '3.000',
                                style: listTitleTextStyle.copyWith(
                                  color: controller.selectedKiriman == 2 ? whiteColor : blueJNE,
                                ),
                              ),
                              Text(
                                'NON COD'.tr,
                                style: sublistTitleTextStyle.copyWith(
                                  color: controller.selectedKiriman == 2 ? whiteColor : greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          controller.selectedDateFilter != null || controller.selectedStatusKiriman != null || controller.selectedPetugasEntry != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: greyColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      controller.selectedDateFilter = null;
                                      controller.selectedPetugasEntry = null;
                                      controller.selectedStatusKiriman = null;
                                      controller.update();
                                    },
                                    icon: const Icon(Icons.close_rounded),
                                    color: blueJNE,
                                  ),
                                )
                              : const SizedBox(),
                          CustomFilledButton(
                            color: controller.selectedDateFilter != null ? blueJNE : whiteColor,
                            title: 'Pilih Tanggal'.tr,
                            width: Get.width / 3,
                            fontColor: controller.selectedDateFilter != null ? whiteColor : greyDarkColor1,
                            borderColor: greyDarkColor1,
                            fontStyle: subTitleTextStyle,
                            radius: 15,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                          ),
                          CustomFilledButton(
                            color: controller.selectedStatusKiriman != null ? blueJNE : whiteColor,
                            title: 'Status Kiriman'.tr,
                            width: Get.width / 3,
                            fontColor: controller.selectedStatusKiriman != null ? whiteColor : greyDarkColor1,
                            borderColor: greyDarkColor1,
                            fontStyle: subTitleTextStyle,
                            radius: 15,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                          ),
                          CustomFilledButton(
                            color: controller.selectedPetugasEntry != null ? blueJNE : whiteColor,
                            title: 'Petugas Entry'.tr,
                            width: Get.width / 3,
                            fontColor: controller.selectedPetugasEntry != null ? whiteColor : greyDarkColor1,
                            borderColor: greyDarkColor1,
                            fontStyle: subTitleTextStyle,
                            radius: 15,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        RiwayatKirimanListItem(
                          tanggalEntry: DateTime.now().toString(),
                          orderID: '123',
                          noResi: 'R123',
                          petugas: 'Joni',
                          penerima: 'sarah',
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

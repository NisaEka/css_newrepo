import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
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
              action: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: controller.isFiltered ? redJNE : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.bottomSheet(
                        enableDrag: true,
                        isDismissible: false,
                        // isScrollControlled: true,
                        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Filter',
                                      style: appTitleTextStyle.copyWith(
                                        color: blueJNE,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (!controller.isFiltered) {
                                          controller.resetFilter();
                                        }
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                  ],
                                ),
                                // const Divider(color: greyColor),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverToBoxAdapter(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomFormLabel(label: 'Tanggal Entry'.tr),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CustomTextFormField(
                                                  controller: controller.startDateField,
                                                  readOnly: true,
                                                  width: Get.width / 2.3,
                                                  hintText: 'Dari'.tr,
                                                  // label: ,
                                                  onTap: () => controller.selectDate(context).then((value) {
                                                    setState(() {
                                                      controller.startDate = value;
                                                      controller.startDateField.text = value.toString().toDateTimeFormat();
                                                      controller.endDate = DateTime.now();
                                                      controller.endDateField.text = DateTime.now().toString().toDateTimeFormat();
                                                      controller.update();
                                                    });
                                                  }),
                                                  // hintText: 'Dari Tanggal',
                                                ),
                                                CustomTextFormField(
                                                  controller: controller.endDateField,
                                                  readOnly: true,
                                                  width: Get.width / 2.3,
                                                  hintText: 'Hingga'.tr,
                                                  onTap: () => controller.selectDate(context).then((value) {
                                                    setState(() {
                                                      controller.endDate = value;
                                                      controller.endDateField.text = value.toString().toDateTimeFormat();
                                                      controller.update();
                                                    });
                                                  }),
                                                ),
                                              ],
                                            ),
                                            CustomFormLabel(label: 'Status Kiriman'.tr),
                                            SizedBox(height: 10),
                                            // CustomFormLabel(label: 'Petugas Entry'),
                                          ],
                                        ),
                                      ),
                                      SliverPadding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        sliver: SliverGrid(
                                          delegate: SliverChildBuilderDelegate(
                                            (context, index) => GestureDetector(
                                              onTap: () => setState(() {
                                                controller.selectedStatusKiriman = controller.listStatusKiriman[index];
                                                controller.update();
                                              }),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color:
                                                      controller.selectedStatusKiriman == controller.listStatusKiriman[index] ? blueJNE : whiteColor,
                                                  border: Border.all(
                                                    color: controller.selectedStatusKiriman != controller.listStatusKiriman[index]
                                                        ? blueJNE
                                                        : whiteColor,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  controller.listStatusKiriman[index].tr,
                                                  textAlign: TextAlign.center,
                                                  style: listTitleTextStyle.copyWith(
                                                      color: controller.selectedStatusKiriman == controller.listStatusKiriman[index]
                                                          ? whiteColor
                                                          : blueJNE),
                                                ),
                                              ),
                                            ),
                                            childCount: controller.listStatusKiriman.length,
                                          ),
                                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 140,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 16,
                                            childAspectRatio: 2,
                                            // mainAxisExtent: 100
                                          ),
                                        ),
                                      ),
                                      SliverToBoxAdapter(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10),
                                            // const CustomFormLabel(label: 'Petugas Entry'),
                                            CustomDropDownField(
                                              items: [],
                                              label: 'Petugas Entry'.tr,
                                              hintText: 'Petugas Entry'.tr,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    controller.isFiltered
                                        ? CustomFilledButton(
                                            color: whiteColor,
                                            fontColor: blueJNE,
                                            borderColor: blueJNE,
                                            width: Get.width / 2.5,
                                            title: 'Reset Filter'.tr,
                                            onPressed: () => controller.resetFilter(),
                                          )
                                        : const SizedBox(),
                                    CustomFilledButton(
                                      color: controller.startDate != null ||
                                              controller.endDate != null ||
                                              controller.selectedPetugasEntry != null ||
                                              controller.selectedStatusKiriman != null
                                          ? blueJNE
                                          : greyColor,
                                      width: controller.isFiltered ? Get.width / 2.5 : Get.width - 40,
                                      title: 'Terapkan'.tr,
                                      onPressed: () {
                                        if (controller.startDate != null ||
                                            controller.endDate != null ||
                                            controller.selectedPetugasEntry != null ||
                                            controller.selectedStatusKiriman != null) {
                                          controller.isFiltered = true;
                                          controller.update();
                                          Get.back();
                                        }
                                      },
                                    ),
                                  ],
                                )
                                // SingleChildScrollView(
                                //   scrollDirection: Axis.horizontal,
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //     children: [
                                //       controller.selectedDateFilter != null ||
                                //               controller.selectedStatusKiriman != null ||
                                //               controller.selectedPetugasEntry != null
                                //           ? Container(
                                //               decoration: BoxDecoration(
                                //                 color: greyColor,
                                //                 borderRadius: BorderRadius.circular(8),
                                //               ),
                                //               child: IconButton(
                                //                 onPressed: () {
                                //                   controller.selectedDateFilter = null;
                                //                   controller.selectedPetugasEntry = null;
                                //                   controller.selectedStatusKiriman = null;
                                //                 },
                                //                 icon: const Icon(Icons.close_rounded),
                                //                 color: blueJNE,
                                //               ),
                                //             )
                                //           : const SizedBox(),
                                //       CustomFilledButton(
                                //         color: controller.selectedDateFilter != null ? blueJNE : whiteColor,
                                //         title: 'Pilih Tanggal'.tr,
                                //         width: Get.width / 3,
                                //         fontColor: controller.selectedDateFilter != null ? whiteColor : greyDarkColor1,
                                //         borderColor: greyDarkColor1,
                                //         fontStyle: subTitleTextStyle,
                                //         radius: 15,
                                //         margin: const EdgeInsets.symmetric(horizontal: 5),
                                //       ),
                                //       CustomFilledButton(
                                //         color: controller.selectedStatusKiriman != null ? blueJNE : whiteColor,
                                //         title: 'Status Kiriman'.tr,
                                //         width: Get.width / 3,
                                //         fontColor: controller.selectedStatusKiriman != null ? whiteColor : greyDarkColor1,
                                //         borderColor: greyDarkColor1,
                                //         fontStyle: subTitleTextStyle,
                                //         radius: 15,
                                //         margin: const EdgeInsets.symmetric(horizontal: 5),
                                //       ),
                                //       CustomFilledButton(
                                //         color: controller.selectedPetugasEntry != null ? blueJNE : whiteColor,
                                //         title: 'Petugas Entry'.tr,
                                //         width: Get.width / 3,
                                //         fontColor: controller.selectedPetugasEntry != null ? whiteColor : greyDarkColor1,
                                //         borderColor: greyDarkColor1,
                                //         fontStyle: subTitleTextStyle,
                                //         radius: 15,
                                //         margin: const EdgeInsets.symmetric(horizontal: 5),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        }),
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                    icon: const Icon(Icons.filter_alt_outlined),
                    color: controller.isFiltered ? whiteColor : redJNE,
                    tooltip: 'filter',
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Column(
                children: [
                  CustomSearchField(
                    hintText: 'Cari Transaksi'.tr,
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
                  // const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: [
                        // Text(DateTime.parse('2024-02-06 15:02').toString()),
                        RiwayatKirimanListItem(
                          tanggalEntry: DateTime.now().toString(),
                          orderID: '123',
                          noResi: 'R123',
                          petugas: 'Joni',
                          penerima: 'sarah',
                          status: 'Dibatalkan oleh kamu'.tr,
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

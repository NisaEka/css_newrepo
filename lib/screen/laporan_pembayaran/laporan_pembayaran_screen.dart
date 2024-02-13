import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/laporan_pembayaran/laporan_pembayaran_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/lappembayaran_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LaporanPembayaranScreen extends StatelessWidget {
  const LaporanPembayaranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaporanPembayaranController>(
        init: LaporanPembayaranController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Laporan Agregasi Pembayaran'.tr,
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
                                            CustomFormLabel(label: 'Tanggal Pembayaran'.tr),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CustomTextFormField(
                                                  controller: controller.startDateField,
                                                  readOnly: true,
                                                  width: Get.width / 2.3,
                                                  hintText: 'Tanggal Awal'.tr,
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
                                                  hintText: 'Tanggal Awal'.tr,
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
                                      color: controller.startDate != null || controller.endDate != null ? blueJNE : greyColor,
                                      width: controller.isFiltered ? Get.width / 2.5 : Get.width - 40,
                                      title: 'Terapkan'.tr,
                                      onPressed: () {
                                        if (controller.startDate != null || controller.endDate != null) {
                                          controller.isFiltered = true;
                                          controller.update();
                                          Get.back();
                                        }
                                      },
                                    ),
                                  ],
                                )
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
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: [
                  const LapPembayaranBox(),
                  CustomSearchField(
                    controller: TextEditingController(),
                    hintText: 'Cari Data Agregasi'.tr,
                    suffixIcon: SvgPicture.asset(
                      IconsConstant.search,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

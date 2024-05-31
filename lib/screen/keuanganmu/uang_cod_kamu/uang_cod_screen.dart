import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/keuanganmu/uang_cod_kamu/uang_cod_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/lappembayaran_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UangCODScreen extends StatelessWidget {
  const UangCODScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UangCODController>(
        init: UangCODController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Uang_COD Kamu'.tr.splitMapJoin(
                    '_',
                    onMatch: (p0) => ' ',
                  ),
              action: [
                _filterContent(controller),
              ],
            ),
            body: _bodyContent(controller, context),
          );
        });
  }

  Widget _filterContent(UangCODController c) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: c.isFiltered ? redJNE : Colors.transparent,
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
                decoration: BoxDecoration(
                  color: AppConst.isDarkTheme(context) ? greyDarkColor2 : greyLightColor2,
                  borderRadius: BorderRadius.circular(10),
                ),
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
                            color: AppConst.isDarkTheme(context) ? redJNE : blueJNE,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (!c.isFiltered) {
                              c.resetFilter();
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
                                CustomFormLabel(label: 'Tanggal Pencarian'.tr),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextFormField(
                                      controller: c.startDateField,
                                      readOnly: true,
                                      width: Get.width / 2.3,
                                      hintText: 'Tanggal Awal'.tr,
                                      // label: ,
                                      onTap: () => c.selectDate(context).then((value) {
                                        setState(() {
                                          c.startDate = value;
                                          c.startDateField.text = value.toString().toDateTimeFormat();
                                          c.endDate = DateTime.now();
                                          c.endDateField.text = DateTime.now().toString().toDateTimeFormat();
                                          c.update();
                                        });
                                      }),
                                      // hintText: 'Dari Tanggal',
                                    ),
                                    CustomTextFormField(
                                      controller: c.endDateField,
                                      readOnly: true,
                                      width: Get.width / 2.3,
                                      hintText: 'Tanggal Akhir'.tr,
                                      onTap: () => c.selectDate(context).then((value) {
                                        setState(() {
                                          c.endDate = value;
                                          c.endDateField.text = value.toString().toDateTimeFormat();
                                          c.update();
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
                        c.isFiltered
                            ? CustomFilledButton(
                                color: whiteColor,
                                fontColor: blueJNE,
                                borderColor: blueJNE,
                                width: Get.width / 2.5,
                                title: 'Reset Filter'.tr,
                                onPressed: () => c.resetFilter(),
                              )
                            : const SizedBox(),
                        CustomFilledButton(
                          color: c.startDate != null || c.endDate != null ? blueJNE : greyColor,
                          width: c.isFiltered ? Get.width / 2.5 : Get.width - 40,
                          title: 'Terapkan'.tr,
                          onPressed: () {
                            if (c.startDate != null || c.endDate != null) {
                              c.isFiltered = true;
                              c.update();
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
        color: c.isFiltered ? whiteColor : redJNE,
        tooltip: 'filter',
      ),
    );
  }

  Widget _bodyContent(UangCODController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          PaymentBox(
            title: "COD Terkumpul Dari Pelanggan".tr,
            value: "Rp. 3.172.648",
          ),
          Expanded(
            child: ListView(
              children: const [],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/eclaim_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customradiobutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class EclaimFilterButton extends HookWidget {
  const EclaimFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EclaimController>(
        init: EclaimController(),
        builder: (c) {
          return FilterButton(
            filterContent: StatefulBuilder(
              builder: (context, setState) {
                return Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomFormLabel(label: 'Tanggal Entry'.tr),
                            const SizedBox(height: 10),
                            Customradiobutton(
                              title: "Semua Tanggal".tr,
                              value: '0',
                              groupValue: c.state.dateFilter,
                              onChanged: (value) =>
                                  setState(() => c.selectDateFilter(0)),
                              onTap: () =>
                                  setState(() => c.selectDateFilter(0)),
                            ),
                            Customradiobutton(
                              title: "1 Bulan Terakhir".tr,
                              value: '1',
                              groupValue: c.state.dateFilter,
                              onChanged: (value) =>
                                  setState(() => c.selectDateFilter(1)),
                              onTap: () =>
                                  setState(() => c.selectDateFilter(1)),
                            ),
                            Customradiobutton(
                              title: "1 Minggu Terakhir".tr,
                              value: '2',
                              groupValue: c.state.dateFilter,
                              onChanged: (value) =>
                                  setState(() => c.selectDateFilter(2)),
                              onTap: () =>
                                  setState(() => c.selectDateFilter(2)),
                            ),
                            Customradiobutton(
                              title: "Hari Ini".tr,
                              value: '3',
                              groupValue: c.state.dateFilter,
                              onChanged: (value) =>
                                  setState(() => c.selectDateFilter(3)),
                              onTap: () =>
                                  setState(() => c.selectDateFilter(3)),
                            ),
                            Customradiobutton(
                              title: "Pilih Tanggal Sendiri".tr,
                              value: '4',
                              groupValue: c.state.dateFilter,
                              onChanged: (value) =>
                                  setState(() => c.selectDateFilter(4)),
                              onTap: () =>
                                  setState(() => c.selectDateFilter(4)),
                            ),
                            //Pilih Tanggal Sendiri
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  controller: c.state.startDateField,
                                  readOnly: true,
                                  width: Get.width / 2.3,
                                  hintText: 'Tanggal Awal'.tr,
                                  onTap: () =>
                                      c.selectDate(context).then((value) {
                                    setState(() {
                                      c.state.startDate = value;
                                      c.state.startDateField.text =
                                          value.toString().toDateTimeFormat();
                                      c.state.endDate = DateTime.now();
                                      c.state.endDateField.text = DateTime.now()
                                          .toString()
                                          .toDateTimeFormat();
                                      c.update();
                                    });
                                  }),
                                  // hintText: 'Dari Tanggal',
                                ),
                                CustomTextFormField(
                                  controller: c.state.endDateField,
                                  readOnly: true,
                                  width: Get.width / 2.3,
                                  hintText: 'Tanggal Akhir'.tr,
                                  onTap: () =>
                                      c.selectDate(context).then((value) {
                                    setState(() {
                                      c.state.endDate = value;
                                      c.state.endDateField.text =
                                          value.toString().toDateTimeFormat();
                                      c.update();
                                    });
                                  }),
                                ),
                              ],
                            ),
                            // CustomFormLabel(label: 'Status Kiriman'.tr),
                            // const SizedBox(height: 10),
                            // CustomFormLabel(label: 'Petugas Entry'),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            // const CustomFormLabel(label: 'Petugas Entry'),
                            CustomDropDownField(
                              label: 'Status Claim'.tr,
                              value: c.state.selectedStatusClaim,
                              hintText: 'Status Claim'.tr,
                              items: [
                                DropdownMenuItem(
                                  value: 'Total',
                                  child: Text(
                                    'Total'.tr.toUpperCase(),
                                    style: subTitleTextStyle,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Diterima',
                                  child: Text(
                                    'Diterima'.tr.toUpperCase(),
                                    style: subTitleTextStyle,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Ditolak',
                                  child: Text(
                                    'Ditolak'.tr.toUpperCase(),
                                    style: subTitleTextStyle,
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                c.state.selectedStatusClaim = value ?? '';
                                c.update();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            isFiltered: c.state.isFiltered,
            // isApplyFilter: c.state.startDate != null || c.state.endDate != null,
            onResetFilter: () {
              // c.resetFilter();
              c.selectDateFilter(3);
              c.applyFilter();
              Get.back();
            },
            onApplyFilter: () {
              c.applyFilter();
              Get.back();
            },
            onCloseFilter: () {
              if (!c.state.isFiltered) {
                c.resetFilter();
              } else {
                Get.back();
              }
            },
          );
        });
  }
}

import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customradiobutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class TransactionFilterButton extends HookWidget {
  const TransactionFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiwayatKirimanController>(
        init: RiwayatKirimanController(),
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
                            CustomFormLabel(label: 'Status Kiriman'.tr),
                            const SizedBox(height: 10),
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
                                if (c.state.selectedStatusKiriman !=
                                    c.state.listStatusKiriman[index]) {
                                  c.state.selectedStatusKiriman =
                                      c.state.listStatusKiriman[index];
                                } else {
                                  c.state.selectedStatusKiriman = null;
                                }
                                c.update();
                              }),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: c.state.selectedStatusKiriman ==
                                          c.state.listStatusKiriman[index]
                                      ? blueJNE
                                      : whiteColor,
                                  border: Border.all(
                                    color: c.state.selectedStatusKiriman !=
                                            c.state.listStatusKiriman[index]
                                        ? blueJNE
                                        : whiteColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  c.state.listStatusKiriman[index].tr,
                                  textAlign: TextAlign.center,
                                  style: listTitleTextStyle.copyWith(
                                      color: c.state.selectedStatusKiriman ==
                                              c.state.listStatusKiriman[index]
                                          ? whiteColor
                                          : blueJNE),
                                ),
                              ),
                            ),
                            childCount: c.state.listStatusKiriman.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
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
                              items: c.state.listOfficerEntry
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e.name ?? ''),
                                    ),
                                  )
                                  .toList(),
                              label: 'Petugas Entry'.tr,
                              hintText: 'Petugas Entry'.tr,
                              readOnly: c.state.basic?.userType != "PEMILIK",
                              selectedItem: c.state.selectedPetugasEntry?.name,
                              value: c.state.selectedPetugasEntry,
                              onChanged: (value) {
                                setState(() {
                                  c.state.selectedPetugasEntry = value;
                                  c.update();
                                });
                              },
                            )
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

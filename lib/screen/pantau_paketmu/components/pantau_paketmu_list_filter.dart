import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customradiobutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/officer_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class PantauPaketmuListFilter extends HookWidget {
  const PantauPaketmuListFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PantauPaketmuController>(
        init: PantauPaketmuController(),
        builder: (controller) {
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
                            Obx(() => Customradiobutton(
                                  title: "1 Bulan Terakhir".tr,
                                  value: '1',
                                  groupValue: controller.state.dateFilter.value,
                                  onChanged: (value) =>
                                      controller.selectDateFilter(1),
                                  onTap: () => controller.selectDateFilter(1),
                                )),
                            Obx(() => Customradiobutton(
                                  title: "1 Minggu Terakhir".tr,
                                  value: '2',
                                  groupValue: controller.state.dateFilter.value,
                                  onChanged: (value) =>
                                      controller.selectDateFilter(2),
                                  onTap: () => controller.selectDateFilter(2),
                                )),
                            Obx(() => Customradiobutton(
                                  title: "Hari Ini".tr,
                                  value: '3',
                                  groupValue: controller.state.dateFilter.value,
                                  onChanged: (value) =>
                                      controller.selectDateFilter(3),
                                  onTap: () => controller.selectDateFilter(3),
                                )),
                            Obx(() => Customradiobutton(
                                  title: "Pilih Tanggal Sendiri".tr,
                                  value: '4',
                                  groupValue: controller.state.dateFilter.value,
                                  onChanged: (value) =>
                                      controller.selectDateFilter(4),
                                  onTap: () => controller.selectDateFilter(4),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  controller: controller.state.startDateField,
                                  readOnly: true,
                                  width: Get.width / 3,
                                  hintText: 'Tanggal Awal'.tr,
                                  onTap: () => controller
                                              .state.dateFilter.value ==
                                          '4'
                                      ? controller.selectDate().then((value) {
                                          if (value != null) {
                                            if (controller
                                                        .state.endDate.value !=
                                                    null &&
                                                value.isAfter(controller
                                                    .state.endDate.value!)) {
                                              AppSnackBar.error(
                                                  'Start date cannot be after end date');
                                              return;
                                            }
                                            controller.state.startDate.value =
                                                DateTime(
                                                    value.year,
                                                    value.month,
                                                    value.day,
                                                    0,
                                                    0,
                                                    0);
                                            controller
                                                    .state.startDateField.text =
                                                controller.state.startDate
                                                    .toString()
                                                    .toShortDateFormat();
                                          }
                                        })
                                      : null,
                                ),
                                CustomTextFormField(
                                  controller: controller.state.endDateField,
                                  readOnly: true,
                                  width: Get.width / 3,
                                  hintText: 'Tanggal Akhir'.tr,
                                  onTap: () => controller
                                              .state.dateFilter.value ==
                                          '4'
                                      ? controller.selectDate().then((value) {
                                          if (value != null) {
                                            controller.state.endDate.value =
                                                DateTime(
                                                    value.year,
                                                    value.month,
                                                    value.day,
                                                    23,
                                                    59,
                                                    59);
                                          }
                                          controller.state.endDateField.text =
                                              controller.state.endDate
                                                  .toString()
                                                  .toShortDateFormat();
                                        })
                                      : null,
                                ),
                              ],
                            ),
                            CustomFormLabel(label: 'Status Kiriman'.tr),
                            const SizedBox(height: 10),
                            // CustomDropDownField<String>(
                            //   items: controller.state.listStatusKiriman
                            //       .map(
                            //         (e) => DropdownMenuItem(
                            //       value: e,
                            //       child: Text(e.toUpperCase()),
                            //     ),
                            //   )
                            //       .toList(),
                            //   label: 'Status Kiriman'.tr,
                            //   hintText: 'Status Kiriman'.tr,
                            //   value: controller.state.selectedStatusKiriman,
                            //   onChanged: (value) {
                            //     controller.state.selectedStatusKiriman = value ?? '';
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      // Status kiriman
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            // Skipping the first index by starting from index 1
                            int adjustedIndex = index;

                            return GestureDetector(
                              onTap: () => setState(() {
                                if (controller.state.selectedStatusKiriman !=
                                    controller.state
                                        .listStatusKiriman[adjustedIndex]) {
                                  controller.state.selectedStatusKiriman =
                                      controller.state
                                          .listStatusKiriman[adjustedIndex];
                                } else {
                                  controller.state.selectedStatusKiriman =
                                      "Total Kiriman";
                                }
                                controller.update();
                              }),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: controller
                                              .state.selectedStatusKiriman ==
                                          controller.state
                                              .listStatusKiriman[adjustedIndex]
                                      ? blueJNE
                                      : whiteColor,
                                  border: Border.all(
                                    color: controller
                                                .state.selectedStatusKiriman !=
                                            controller.state.listStatusKiriman[
                                                adjustedIndex]
                                        ? blueJNE
                                        : whiteColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  controller.state
                                      .listStatusKiriman[adjustedIndex].tr,
                                  textAlign: TextAlign.center,
                                  style: listTitleTextStyle.copyWith(
                                      color: controller.state
                                                  .selectedStatusKiriman ==
                                              controller
                                                      .state.listStatusKiriman[
                                                  adjustedIndex]
                                          ? whiteColor
                                          : blueJNE),
                                ),
                              ),
                            );
                          },
                              childCount:
                                  controller.state.listStatusKiriman.length),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 140,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 16,
                            childAspectRatio: 2.5,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            // Tipe Kiriman
                            CustomDropDownField(
                              items: controller.state.listTipeKiriman
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e.toUpperCase()),
                                    ),
                                  )
                                  .toList(),
                              label: 'Tipe Kiriman'.tr,
                              hintText: 'Tipe Kiriman'.tr,
                              value: controller.state.selectedTipeKiriman,
                              onChanged: (value) {
                                controller.state.selectedTipeKiriman =
                                    value as String;
                                if (value == 'cod') {
                                  controller.state.selectedKiriman = 0;
                                } else if (value == 'cod ongkir') {
                                  controller.state.selectedKiriman = 1;
                                } else {
                                  controller.state.selectedKiriman = 2;
                                }
                                controller.update();
                              },
                            ),
                            OfficerDropdown(
                              label: 'Petugas Entry'.tr,
                              value: controller.state.selectedPetugasEntry,
                              onChanged: (value) {
                                controller.state.selectedPetugasEntry = value;
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
            isFiltered: controller.state.isFiltered,
            isApplyFilter:
                (controller.state.selectedStatusKiriman != "Total Kiriman"),
            onResetFilter: () {
              controller.resetFilter();
              Get.back();
            },
            onApplyFilter: () {
              controller.applyFilter(isDetail: true);
              Get.back();
            },
            onCloseFilter: () {
              Get.back();
            },
          );
        });
  }
}

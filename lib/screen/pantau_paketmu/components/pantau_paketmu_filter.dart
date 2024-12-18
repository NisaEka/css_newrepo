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
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class PantauPaketmuFilter extends HookWidget {
  const PantauPaketmuFilter({super.key});

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
                              },
                            ),
                            CustomDropDownField(
                              items: controller.state.listOfficerEntry
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              label: 'Petugas Entry'.tr,
                              hintText: 'Petugas Entry'.tr,
                              value: controller.state.selectedPetugasEntry,
                              onChanged: (value) {
                                controller.state.selectedPetugasEntry =
                                    value as String;
                              },
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
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => GestureDetector(
                              onTap: () => setState(() {
                                if (controller.state.selectedStatusKiriman !=
                                    controller.state.listStatusKiriman[index]) {
                                  controller.state.selectedStatusKiriman =
                                      controller.state.listStatusKiriman[index];
                                } else {
                                  controller.state.selectedStatusKiriman = null;
                                }
                                controller.update();
                              }),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      controller.state.selectedStatusKiriman ==
                                              controller.state
                                                  .listStatusKiriman[index]
                                          ? blueJNE
                                          : whiteColor,
                                  border: Border.all(
                                    color: controller
                                                .state.selectedStatusKiriman !=
                                            controller
                                                .state.listStatusKiriman[index]
                                        ? blueJNE
                                        : whiteColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  controller.state.listStatusKiriman[index].tr,
                                  textAlign: TextAlign.center,
                                  style: listTitleTextStyle.copyWith(
                                      color: controller.state
                                                  .selectedStatusKiriman ==
                                              controller.state
                                                  .listStatusKiriman[index]
                                          ? whiteColor
                                          : blueJNE),
                                ),
                              ),
                            ),
                            childCount:
                                controller.state.listStatusKiriman.length,
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
                    ],
                  ),
                );
              },
            ),
            isFiltered: controller.state.isFiltered.value,
            isApplyFilter:
                (controller.state.selectedStatusKiriman != "Total Kiriman"),
            onResetFilter: () {
              controller.resetFilter();
              Get.back();
            },
            onApplyFilter: () {
              controller.applyFilter();
              Get.back();
            },
            onCloseFilter: () {
              Get.back();
            },
          );
        });
  }
}

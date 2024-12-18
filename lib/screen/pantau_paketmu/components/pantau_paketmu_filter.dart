import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customradiobutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PantauPaketmuFilter extends StatelessWidget {
  final PantauPaketmuController controller;

  const PantauPaketmuFilter({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
                      onChanged: (value) => controller.selectDateFilter(1),
                      onTap: () => controller.selectDateFilter(1),
                    )),
                Obx(() => Customradiobutton(
                      title: "1 Minggu Terakhir".tr,
                      value: '2',
                      groupValue: controller.state.dateFilter.value,
                      onChanged: (value) => controller.selectDateFilter(2),
                      onTap: () => controller.selectDateFilter(2),
                    )),
                Obx(() => Customradiobutton(
                      title: "Hari Ini".tr,
                      value: '3',
                      groupValue: controller.state.dateFilter.value,
                      onChanged: (value) => controller.selectDateFilter(3),
                      onTap: () => controller.selectDateFilter(3),
                    )),
                Obx(() => Customradiobutton(
                      title: "Pilih Tanggal Sendiri".tr,
                      value: '4',
                      groupValue: controller.state.dateFilter.value,
                      onChanged: (value) => controller.selectDateFilter(4),
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
                      onTap: () => controller.state.dateFilter.value == '4'
                          ? controller.selectDate().then((value) {
                              if (value != null) {
                                if (controller.state.endDate.value != null &&
                                    value.isAfter(
                                        controller.state.endDate.value!)) {
                                  AppSnackBar.error(
                                      'Start date cannot be after end date');
                                  return;
                                }
                                controller.state.startDate.value = DateTime(
                                    value.year,
                                    value.month,
                                    value.day,
                                    0,
                                    0,
                                    0);
                                controller.state.startDateField.text =
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
                      onTap: () => controller.state.dateFilter.value == '4'
                          ? controller.selectDate().then((value) {
                              if (value != null) {
                                controller.state.endDate.value = DateTime(
                                    value.year,
                                    value.month,
                                    value.day,
                                    23,
                                    59,
                                    59);
                              }
                              controller.state.endDateField.text = controller
                                  .state.endDate
                                  .toString()
                                  .toShortDateFormat();
                            })
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomDropDownField<String>(
                  items: controller.state.listStatusKiriman
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toUpperCase()),
                        ),
                      )
                      .toList(),
                  label: 'Status Kiriman'.tr,
                  hintText: 'Status Kiriman'.tr,
                  value: controller.state.selectedStatusKiriman.value,
                  onChanged: (value) {
                    controller.state.selectedStatusKiriman.value = value ?? '';
                  },
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
                  value: controller.state.selectedTipeKiriman.value,
                  onChanged: (value) {
                    controller.state.selectedTipeKiriman.value =
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
                  value: controller.state.selectedPetugasEntry.value,
                  onChanged: (value) {
                    controller.state.selectedPetugasEntry.value =
                        value as String;
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

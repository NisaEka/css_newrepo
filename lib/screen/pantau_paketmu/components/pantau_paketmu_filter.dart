import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/dates_filter_content.dart';
import 'package:css_mobile/widgets/forms/officer_dropdown.dart';
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
                      DateFilterField(
                        startDate: controller.state.startDate,
                        endDate: controller.state.endDate,
                        selectedDateFilter: controller.state.dateFilter,
                        onChanged: (value) {
                          controller.state.startDate = value.startDate;
                          controller.state.endDate = value.endDate;
                          controller.state.dateFilter = value.dateFilter;
                          controller.update();
                        },
                      ),
                      SliverToBoxAdapter(
                        child: CustomFormLabel(
                          label: 'Status Kiriman'.tr,
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 10),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            return GestureDetector(
                              onTap: () => setState(() {
                                if (controller.state.selectedStatusKiriman !=
                                    controller.state.listStatusKiriman[index]) {
                                  controller.state.selectedStatusKiriman =
                                      controller.state.listStatusKiriman[index];
                                } else {
                                  controller.state.selectedStatusKiriman =
                                      "Total Kiriman";
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
                                          ? primaryColor(context)
                                          : whiteColor,
                                  border: Border.all(
                                    color: controller
                                                .state.selectedStatusKiriman !=
                                            controller
                                                .state.listStatusKiriman[index]
                                        ? primaryColor(context)
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
                                          : primaryColor(context)),
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
                            const SizedBox(height: 8),
                            // Tipe Kiriman
                            CustomDropDownField(
                              items: controller.state.listTipeKiriman
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e.toUpperCase().tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
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
                            CustomFormLabel(label: 'Petugas Entry'.tr),
                            OfficerDropdown(
                              label: 'Petugas Entry'.tr,
                              readOnly:
                                  controller.state.basic?.userType != "PEMILIK",
                              selectedItem:
                                  controller.state.selectedPetugasEntry?.name,
                              value: controller.state.selectedPetugasEntry,
                              onChanged: (value) {
                                setState(() {
                                  controller.state.selectedPetugasEntry = value;
                                  controller.update();
                                });
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

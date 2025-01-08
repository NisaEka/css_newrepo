import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_controller.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/dates_filter_content.dart';
import 'package:css_mobile/widgets/forms/officer_dropdown.dart';
import 'package:css_mobile/widgets/forms/status_filter_field.dart';
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
                      DateFilterField(
                        startDate: c.state.startDate,
                        endDate: c.state.endDate,
                        selectedDateFilter: c.state.dateFilter,
                        onChanged: (value) {
                          c.state.startDate = value.startDate;
                          c.state.endDate = value.endDate;
                          c.state.dateFilter = value.dateFilter;
                          c.update();
                        },
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: CustomFormLabel(label: 'Status Kiriman'.tr),
                        ),
                      ),
                      StatusFilterField(
                        statuses: c.state.listStatusKiriman,
                        selectedStatus: c.state.selectedStatusKiriman,
                        onChanged: (value) {
                          c.state.selectedStatusKiriman = value;
                          c.update();
                        },
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CustomFormLabel(label: 'Petugas Entry'.tr),
                            ),
                            OfficerDropdown(
                              label: 'Petugas Entry'.tr,
                              readOnly: c.state.basic?.userType != "PEMILIK",
                              selectedItem: c.state.selectedPetugasEntry?.name,
                              value: c.state.selectedPetugasEntry,
                              onChanged: (value) {
                                setState(() {
                                  c.state.selectedPetugasEntry = value;
                                  c.update();
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
            isFiltered: c.state.isFiltered,
            onResetFilter: () {
              c.resetFilter();
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

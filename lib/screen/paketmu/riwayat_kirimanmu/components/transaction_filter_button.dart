import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_controller.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
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
                        selectedDateFilter: c.state.dateFilter,
                        onChanged: (value) {
                          c.state.startDate = value.startDate;
                          c.state.endDate = value.endDate;
                          c.state.dateFilter = value.dateFilter;
                          c.update();
                        },
                      ),
                      StatusFilterField(
                        statuses: c.state.listStatusKiriman,
                        onChanged: (value) {
                          c.state.selectedStatusKiriman = value;
                          c.update();
                        },
                      ),

                      // SliverPadding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 10),
                      //   sliver: SliverGrid(
                      //     delegate: SliverChildBuilderDelegate(
                      //       (context, index) => GestureDetector(
                      //         onTap: () => setState(() {
                      //           if (c.state.selectedStatusKiriman != c.state.listStatusKiriman[index]) {
                      //             c.state.selectedStatusKiriman = c.state.listStatusKiriman[index];
                      //           } else {
                      //             c.state.selectedStatusKiriman = null;
                      //           }
                      //           c.update();
                      //         }),
                      //         child: Container(
                      //           alignment: Alignment.center,
                      //           decoration: BoxDecoration(
                      //             color: c.state.selectedStatusKiriman == c.state.listStatusKiriman[index] ? primaryColor(context) : whiteColor,
                      //             border: Border.all(
                      //               color: c.state.selectedStatusKiriman != c.state.listStatusKiriman[index] ? primaryColor(context) : whiteColor,
                      //             ),
                      //             borderRadius: BorderRadius.circular(5),
                      //           ),
                      //           child: Text(
                      //             c.state.listStatusKiriman[index].tr,
                      //             textAlign: TextAlign.center,
                      //             style: listTitleTextStyle.copyWith(
                      //                 color: c.state.selectedStatusKiriman == c.state.listStatusKiriman[index] ? whiteColor : primaryColor(context)),
                      //           ),
                      //         ),
                      //       ),
                      //       childCount: c.state.listStatusKiriman.length,
                      //     ),
                      //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      //       maxCrossAxisExtent: 140,
                      //       mainAxisSpacing: 5,
                      //       crossAxisSpacing: 16,
                      //       childAspectRatio: 2,
                      //       // mainAxisExtent: 100
                      //     ),
                      //   ),
                      // ),
                      SliverToBoxAdapter(
                        child: OfficerDropdown(
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
                      ),
                    ],
                  ),
                );
              },
            ),
            isFiltered: c.state.isFiltered,
            // isApplyFilter: c.state.startDate != null || c.state.endDate != null,
            onResetFilter: () {
              c.resetFilter();
              // if (c.state.listOfficerEntry.length > 1) {
              //   c.state.selectedPetugasEntry = null;
              //   c.update();
              // }
              // c.selectDateFilter(3);
              // c.applyFilter();
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

import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/eclaim_controller.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/dates_filter_content.dart';
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
                      DateFilterField(
                        selectedDateFilter: c.state.dateFilter,
                        startDate: c.state.startDate,
                        endDate: c.state.endDate,
                        onChanged: (value) {
                          c.state.startDate = value.startDate;
                          c.state.endDate = value.endDate;
                          c.state.dateFilter = value.dateFilter;
                          c.update();
                        },
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(height: 10),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color:
                                                AppConst.isLightTheme(context)
                                                    ? greyDarkColor2
                                                    : whiteColor),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Diterima',
                                  child: Text(
                                    'Diterima'.tr.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color:
                                                AppConst.isLightTheme(context)
                                                    ? greyDarkColor2
                                                    : whiteColor),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Ditolak',
                                  child: Text(
                                    'Ditolak'.tr.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color:
                                                AppConst.isLightTheme(context)
                                                    ? greyDarkColor2
                                                    : whiteColor),
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
              c.state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
              c.state.endDate =
                  DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
              c.update();
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

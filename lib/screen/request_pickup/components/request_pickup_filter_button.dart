import 'dart:convert';

import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_controller.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/dates_filter_content.dart';
import 'package:css_mobile/widgets/forms/pickup_destination_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class RequstPickupFilterButton extends HookWidget {
  const RequstPickupFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestPickupController>(
        init: RequestPickupController(),
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
                            CustomFormLabel(label: 'Status Kiriman'.tr),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => GestureDetector(
                              onTap: () => setState(() {
                                if (c.state.listStatusKiriman[index] ==
                                    Constant.allStatus) {
                                  c.state.filterStatus = Constant.allStatus;
                                } else if (c.state.filterStatus !=
                                    c.state.listStatusKiriman[index]) {
                                  c.state.filterStatus =
                                      c.state.listStatusKiriman[index];
                                }
                                c.update();
                              }),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: c.state.filterStatus ==
                                          c.state.listStatusKiriman[index]
                                      ? primaryColor(context)
                                      : whiteColor,
                                  border: Border.all(
                                    color: c.state.filterStatus !=
                                            c.state.listStatusKiriman[index]
                                        ? primaryColor(context)
                                        : whiteColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  c.state.listStatusKiriman[index].tr,
                                  textAlign: TextAlign.center,
                                  style: listTitleTextStyle.copyWith(
                                      color: c.state.filterStatus ==
                                              c.state.listStatusKiriman[index]
                                          ? whiteColor
                                          : primaryColor(context)),
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
                            childAspectRatio: 1.8,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: CustomFormLabel(label: 'Tipe Kiriman'.tr),
                            ),
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => GestureDetector(
                              onTap: () => setState(() {
                                if (c.state.selectedDeliveryType !=
                                    c.state.listDeliveryType[index]) {
                                  c.state.selectedDeliveryType =
                                      c.state.listDeliveryType[index];
                                } else {
                                  c.state.selectedDeliveryType = null;
                                }
                                c.update();
                              }),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: c.state.selectedDeliveryType ==
                                          c.state.listDeliveryType[index]
                                      ? primaryColor(context)
                                      : whiteColor,
                                  border: Border.all(
                                    color: c.state.selectedDeliveryType !=
                                            c.state.listDeliveryType[index]
                                        ? primaryColor(context)
                                        : whiteColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  c.state.listDeliveryType[index].tr,
                                  textAlign: TextAlign.center,
                                  style: listTitleTextStyle.copyWith(
                                      color: c.state.selectedDeliveryType ==
                                              c.state.listDeliveryType[index]
                                          ? whiteColor
                                          : primaryColor(context)),
                                ),
                              ),
                            ),
                            childCount: c.state.listDeliveryType.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 140,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 16,
                            childAspectRatio: 2,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child:
                                  CustomFormLabel(label: 'Kota Pengiriman'.tr),
                            ),
                            PickupDestinationDropdown(
                              onChanged: (value) {
                                AppLogger.i(
                                    "value kota pengiriman ${jsonEncode(value)}");
                                c.state.selectedOrigin = value;
                                c.update();
                              },
                              value: c.state.selectedOrigin,
                              isRequired: false,
                              readOnly: false,
                              label: "Kota Pengiriman".tr,
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: AppConst.isLightTheme(context)
                                    ? greyDarkColor1
                                    : greyLightColor1,
                              ),
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
              c.resetFilter(false);
              c.state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
              c.state.endDate =
                  DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

              c.applyFilter();
              Get.back();
            },
            onApplyFilter: () {
              c.applyFilter();
              Get.back();
            },
            onCloseFilter: () {
              AppLogger.i("isFiltered ${c.state.isFiltered}");
              if (!c.state.isFiltered) {
                c.resetFilter(true);
              } else {
                Get.back();
              }
            },
          );
        });
  }
}

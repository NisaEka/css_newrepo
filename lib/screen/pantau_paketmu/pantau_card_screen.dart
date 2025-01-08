import 'package:collection/collection.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/pantau_paketmu/components/pantau_list_item.dart';
import 'package:css_mobile/screen/pantau_paketmu/components/pantau_paketmu_filter.dart';
import 'package:css_mobile/screen/pantau_paketmu/components/pantau_status_button.dart';
import 'package:css_mobile/screen/pantau_paketmu/components/pantau_total_kiriman.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PantauCardScreen extends StatelessWidget {
  const PantauCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PantauPaketmuController>(
        init: PantauPaketmuController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Pantau Paketmu'.tr,
              leading: CustomBackButton(
                onPressed: () =>
                    Get.delete<DashboardController>().then((_) => Get.back()),
              ),
              action: const [
                PantauPaketmuFilter(),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () => controller.initData(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PantauStatusButton(),
                    // const SizedBox(height: 5),
                    // Total Kiriman
                    PantauTotalKiriman(
                        isLoading: controller.state.isLoading ||
                            controller.state.countList.isEmpty),
                    Expanded(
                      child: ListView(
                        children: controller.state.countList.isEmpty ||
                                controller.state.isLoading
                            ? List.generate(
                                8,
                                (index) => const PantauItems(
                                  isLoading: true,
                                ),
                              )
                            : controller.state.selectedStatusKiriman == null ||
                                    controller.state.selectedStatusKiriman ==
                                        "Total Kiriman"
                                ? controller.state.countList
                                    .mapIndexed((index, item) => (index != 0
                                        ? PantauItems(
                                            item: item,
                                            index: index,
                                            isLoading: false)
                                        : const SizedBox()))
                                    .toList()
                                : controller.state.filteredCountList
                                    .mapIndexed((index, item) {
                                    return PantauItems(
                                      item: item,
                                      index: index,
                                      isLoading: false,
                                    );
                                  }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

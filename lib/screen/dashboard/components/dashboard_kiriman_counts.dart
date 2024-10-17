import 'package:collection/collection.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/dashboard/count_card_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/widgets/items/count_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardKirimanCounts extends StatelessWidget {
  const DashboardKirimanCounts({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Kiriman Kamu'.tr, style: Theme.of(context).textTheme.titleLarge),
                    // const DateDropdownFilterButton(),
                  ],
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.state.isLoading || controller.state.transCountList.isEmpty
                          ? ImageConstant.dashboardCountIcons
                              .mapIndexed(
                                (i, e) => CountCardItem(
                                  data: CountCardModel(),
                                  isLoading: controller.state.isLoading,
                                  index: i,
                                ),
                              )
                              .toList()
                          : controller.state.transCountList
                              .mapIndexed(
                                (i, e) => CountCardItem(
                                  data: e,
                                  isLoading: controller.state.isLoading,
                                  index: i,
                                ),
                              )
                              .toList(),
                    )),
              ],
            ),
          );
        });
  }
}

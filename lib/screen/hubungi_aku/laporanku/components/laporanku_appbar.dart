import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'laporanku_filter.dart';

class LaporankuAppbar extends CustomTopBar {
  const LaporankuAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(150),
      child: GetBuilder<LaporankuController>(
          init: LaporankuController(),
          builder: (c) {
            return CustomTopBar(
              title: "Laporanku".tr,
              action: [
                FilterButton(
                  filterContent: StatefulBuilder(
                    builder: (context, setState) {
                      return FilterComponent(setState);
                    },
                  ),
                  isFiltered: c.state.isFiltered,
                  isApplyFilter: c.state.startDate != null || c.state.endDate != null,
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
                      Get.back();
                    } else {
                      Get.back();
                    }
                  },
                ),
              ],
            );
          }),
    );
  }
}

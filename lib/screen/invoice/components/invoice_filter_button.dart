import 'package:css_mobile/screen/invoice/invoice_controller.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/forms/dates_filter_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class InvoiceFilterButton extends HookWidget {
  const InvoiceFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceController>(
        init: InvoiceController(),
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
                      const SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            isFiltered: c.state.isFiltered,
            onResetFilter: () {
              c.state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
              c.state.endDate =
                  DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
              c.state.dateFilter = '3';

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

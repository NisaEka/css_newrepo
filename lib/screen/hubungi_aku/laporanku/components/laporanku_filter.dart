import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_controller.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/dates_filter_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterComponent extends StatelessWidget {
  final StateSetter setState;

  const FilterComponent(this.setState, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaporankuController>(
        init: LaporankuController(),
        builder: (c) {
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
                      const SizedBox(height: 10),
                      CustomDropDownFormField(
                        label: "Status",
                        items: c.state.statusList
                            .map((e) => DropdownMenuItem(
                                  value: e["value"].toString(),
                                  child: Text(e["name"].toString()),
                                ))
                            .toList(),
                        value: c.state.status,
                        onChanged: (value) {
                          c.state.status = value;
                          c.update();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

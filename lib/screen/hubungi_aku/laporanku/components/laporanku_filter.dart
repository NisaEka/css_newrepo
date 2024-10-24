import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customradiobutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
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
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Customradiobutton(
                        title: "Semua Tanggal".tr,
                        value: '0',
                        groupValue: c.state.dateFilter,
                        onChanged: (value) => setState(() => c.selectDateFilter(0)),
                        onTap: () => setState(() => c.selectDateFilter(0)),
                      ),
                      Customradiobutton(
                        title: "1 Bulan Terakhir".tr,
                        value: '1',
                        groupValue: c.state.dateFilter,
                        onChanged: (value) => setState(() => c.selectDateFilter(1)),
                        onTap: () => setState(() => c.selectDateFilter(1)),
                      ),
                      Customradiobutton(
                        title: "1 Minggu Terakhir".tr,
                        value: '2',
                        groupValue: c.state.dateFilter,
                        onChanged: (value) => setState(() => c.selectDateFilter(2)),
                        onTap: () => setState(() => c.selectDateFilter(2)),
                      ),
                      Customradiobutton(
                        title: "Hari Ini".tr,
                        value: '3',
                        groupValue: c.state.dateFilter,
                        onChanged: (value) => setState(() => c.selectDateFilter(3)),
                        onTap: () => setState(() => c.selectDateFilter(3)),
                      ),
                      Customradiobutton(
                        title: "Pilih Tanggal Sendiri".tr,
                        value: '4',
                        groupValue: c.state.dateFilter,
                        onChanged: (value) => setState(() => c.selectDateFilter(4)),
                        onTap: () => setState(() => c.selectDateFilter(4)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            controller: c.state.startDateField,
                            readOnly: true,
                            width: Get.width / 3,
                            hintText: 'Tanggal Awal'.tr,
                            onTap: () => c.state.dateFilter == '4'
                                ? c.selectDate(context).then((value) {
                                    setState(() {
                                      c.state.startDate = value;
                                      c.state.startDateField.text = value.toString().toShortDateFormat();
                                      c.state.endDate = DateTime.now();
                                      c.state.endDateField.text = DateTime.now().toString().toShortDateFormat();
                                      c.update();
                                    });
                                  })
                                : null,
                            // hintText: 'Dari Tanggal',
                          ),
                          CustomTextFormField(
                            controller: c.state.endDateField,
                            readOnly: true,
                            width: Get.width / 3,
                            hintText: 'Tanggal Akhir'.tr,
                            onTap: () => c.state.dateFilter == '4'
                                ? c.selectDate(context).then((value) {
                                    setState(() {
                                      c.state.endDate = value;
                                      c.state.endDateField.text = value.toString().toShortDateFormat();
                                      c.update();
                                    });
                                  })
                                : null,
                          ),
                        ],
                      ),
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

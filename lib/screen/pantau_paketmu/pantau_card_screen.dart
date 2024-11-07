import 'package:css_mobile/screen/pantau_paketmu/components/pantau_count_cod.dart';
import 'package:css_mobile/screen/pantau_paketmu/components/pantau_count_cod_ongkir.dart';
import 'package:css_mobile/screen/pantau_paketmu/components/pantau_count_non_cod.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customradiobutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:css_mobile/util/ext/string_ext.dart';

class PantauCardScreen extends StatelessWidget {
  const PantauCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PantauPaketmuController>(
        init: PantauPaketmuController(),
        builder: (controller) {
          return Scaffold(
            appBar: _appBarContent(controller),
            body: RefreshIndicator(
              onRefresh: () async {
                await controller.resetFilter();
              },
              child: controller.state.isLoading
                  ? const LoadingDialog()
                  : Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListView(
                        children: [
                          PantauCountCod(title: 'COD'.tr),
                          PantauCountCodOngkir(
                            title: 'COD ONGKIR'.tr,
                          ),
                          PantauCountNonCod(
                            title: 'NON COD'.tr,
                          ),
                        ],
                      )),
            ),
          );
        });
  }

  CustomTopBar _appBarContent(PantauPaketmuController c) {
    return CustomTopBar(
      title: "Pantau Paketmu".tr,
      action: [
        FilterButton(
          filterContent: StatefulBuilder(
            builder: (context, setState) {
              return _filterContent(context, c, setState);
            },
          ),
          isFiltered: c.state.isFiltered,
          isApplyFilter: (c.state.selectedStatusKiriman != "Total Kiriman"),
          onResetFilter: () => c.resetFilter(),
          onApplyFilter: () {
            c.applyFilter();
            Get.back();
          },
          onCloseFilter: () {
            Get.back();
          },
        ),
      ],
    );
  }

  Widget _filterContent(
      BuildContext context, PantauPaketmuController c, StateSetter setState) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                // Set the start date to 00:00
                                c.state.startDate = DateTime(value?.year ?? 0,
                                    value?.month ?? 0, value?.day ?? 0, 0, 0);
                                c.state.startDateField.text = c.state.startDate
                                    .toString()
                                    .toShortDateFormat();
                                // Set the end date to the current date at 23:59
                                c.state.endDate = DateTime.now()
                                    .copyWith(hour: 23, minute: 59, second: 59);
                                c.state.endDateField.text = c.state.endDate
                                    .toString()
                                    .toShortDateFormat();
                                c.update();
                              });
                            })
                          : null,
                    ),
                    CustomTextFormField(
                      controller: c.state.endDateField,
                      readOnly: true,
                      width: Get.width / 3,
                      hintText: 'Tanggal Akhir'.tr,
                      onTap: () => c.state.dateFilter == '4'
                          ? c.selectDate(context).then((value) {
                              setState(() {
                                // Set the end date to 23:59
                                if (value != null) {
                                  c.state.endDate = DateTime(value.year,
                                      value.month, value.day, 23, 59, 59);
                                }
                                c.state.endDateField.text = c.state.endDate
                                    .toString()
                                    .toShortDateFormat();
                                c.update();
                              });
                            })
                          : null,
                    ),
                  ],
                ),
                // CustomDropDownField(
                //   items: c.state.listOfficerEntry
                //       .map(
                //         (e) => DropdownMenuItem(
                //           value: e,
                //           child: Text(e),
                //         ),
                //       )
                //       .toList(),
                //   label: 'Petugas Entry'.tr,
                //   hintText: 'Petugas Entry'.tr,
                //   value: c.state.selectedPetugasEntry,
                //   onChanged: (value) {
                //     setState(() {
                //       c.state.selectedPetugasEntry = value;
                //       c.update();
                //     });
                //   },
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

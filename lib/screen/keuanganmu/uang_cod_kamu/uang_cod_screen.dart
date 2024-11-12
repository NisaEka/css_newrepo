import 'package:css_mobile/screen/keuanganmu/uang_cod_kamu/uang_cod_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customradiobutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/lappembayaran_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UangCODScreen extends StatelessWidget {
  const UangCODScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UangCODController>(
        init: UangCODController(),
        builder: (controller) {
          return Scaffold(
            appBar: _appBarContent(controller, context),
            body: _bodyContent(controller, context),
          );
        });
  }

  Widget _filterContent(
      UangCODController c, BuildContext context, StateSetter setState) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFormLabel(label: 'Tanggal Pencarian'.tr),
                Customradiobutton(
                  title: "Semua Tanggal".tr,
                  value: '0',
                  groupValue: c.dateFilter,
                  onChanged: (value) => setState(() => c.selectDateFilter(0)),
                  onTap: () => setState(() => c.selectDateFilter(0)),
                ),
                Customradiobutton(
                  title: "1 Bulan Terakhir".tr,
                  value: '1',
                  groupValue: c.dateFilter,
                  onChanged: (value) => setState(() => c.selectDateFilter(1)),
                  onTap: () => setState(() => c.selectDateFilter(1)),
                ),
                Customradiobutton(
                  title: "1 Minggu Terakhir".tr,
                  value: '2',
                  groupValue: c.dateFilter,
                  onChanged: (value) => setState(() => c.selectDateFilter(2)),
                  onTap: () => setState(() => c.selectDateFilter(2)),
                ),
                Customradiobutton(
                  title: "Hari Ini".tr,
                  value: '3',
                  groupValue: c.dateFilter,
                  onChanged: (value) => setState(() => c.selectDateFilter(3)),
                  onTap: () => setState(() => c.selectDateFilter(3)),
                ),
                Customradiobutton(
                  title: "Pilih Tanggal Sendiri".tr,
                  value: '4',
                  groupValue: c.dateFilter,
                  onChanged: (value) => setState(() => c.selectDateFilter(4)),
                  onTap: () => setState(() => c.selectDateFilter(4)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextFormField(
                      controller: c.startDateField,
                      readOnly: true,
                      width: Get.width / 2.3,
                      hintText: 'Tanggal Awal'.tr,
                      // label: ,
                      onTap: () => c.selectDate(context).then((value) {
                        setState(() {
                          c.startDate = value;
                          c.startDateField.text =
                              value.toString().toDateTimeFormat();
                          c.endDate = DateTime.now();
                          c.endDateField.text =
                              DateTime.now().toString().toDateTimeFormat();
                          c.update();
                        });
                      }),
                      // hintText: 'Dari Tanggal',
                    ),
                    CustomTextFormField(
                      controller: c.endDateField,
                      readOnly: true,
                      width: Get.width / 2.3,
                      hintText: 'Tanggal Akhir'.tr,
                      onTap: () => c.selectDate(context).then((value) {
                        setState(() {
                          c.endDate = value;
                          c.endDateField.text =
                              value.toString().toDateTimeFormat();
                          c.update();
                        });
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyContent(UangCODController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          PaymentBox(
            title: "COD Terkumpul Dari Pelanggan".tr,
            value: "Rp. 3.172.648",
          ),
          Expanded(
            child: ListView(
              children: const [],
            ),
          )
        ],
      ),
    );
  }

  CustomTopBar _appBarContent(UangCODController c, BuildContext context) {
    return CustomTopBar(
      title: 'Uang_COD Kamu'.tr.splitMapJoin(
            '_',
            onMatch: (p0) => ' ',
          ),
      action: [
        FilterButton(
          filterContent: StatefulBuilder(
            builder: (context, setState) {
              return _filterContent(c, context, setState);
            },
          ),
          isFiltered: c.isFiltered,
          isApplyFilter: c.startDate != null || c.endDate != null,
          onResetFilter: () => c.resetFilter(),
          onApplyFilter: () => c.applyFilter(),
          onCloseFilter: () {
            if (!c.isFiltered) {
              c.resetFilter();
            } else {
              Get.back();
            }
          },
        ),
        // _filterContent(controller),
      ],
    );
  }
}

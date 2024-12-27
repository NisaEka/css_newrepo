import 'package:css_mobile/screen/keuanganmu/uang_cod_kamu/uang_cod_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/forms/dates_filter_content.dart';
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
          DateFilterField(
            label: "Tanggal Pencarian".tr,
            onChanged: (value) {
              c.startDate = value.first;
              c.endDate = value.last;
              c.update();
            },
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

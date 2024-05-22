import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/screen/keuanganmu/minus/detail/doc/aggregation_minus_doc_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggminus_box.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggregation_minus_detail_box.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggregation_minus_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AggregationMinusDocScreen extends StatelessWidget {
  const AggregationMinusDocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AggregationMinusDocController(),
        builder: (controller) {
          return Scaffold(
              appBar: _aggregationMinusDocAppBar(),
              body: _aggregationMinusDocBody(context, controller));
        });
  }

  PreferredSizeWidget _aggregationMinusDocAppBar() {
    return CustomTopBar(
      title: 'Laporan Aggregasi Minus'.tr,
    );
  }

  Widget _aggregationMinusDocBody(BuildContext context, AggregationMinusDocController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          AggregationMinusDocBox(
            documentNumber: controller.docArgs,
          ),
          CustomSearchField(
            controller: TextEditingController(),
            hintText: 'Cari Data Aggregasi Minus'.tr,
            prefixIcon: SvgPicture.asset(
              IconsConstant.search,
              color: Theme.of(context).brightness == Brightness.light
                  ? whiteColor
                  : blueJNE,
            ),
          ),
          Expanded(
            child: ListView(
              children: controller.aggregations.map((aggregation) {
                return AggregationMinusDocItem(
                  data: aggregation
                );
              }).toList()
            ),
          )
        ],
      )
    );
  }
}

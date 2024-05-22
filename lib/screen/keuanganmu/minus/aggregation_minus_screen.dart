import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:css_mobile/screen/keuanganmu/minus/aggregation_minus_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggminus_box.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggregation_minus_item.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/report_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AggregationMinusScreen extends StatelessWidget {
  const AggregationMinusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AggregasiMinusController>(
        init: AggregasiMinusController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Laporan Aggregasi Minus'.tr,
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Column(
                children: [
                  const AggMinusBox(),
                  CustomSearchField(
                    controller: TextEditingController(),
                    hintText: 'Cari Data Aggregasi Minus'.tr,
                    prefixIcon: SvgPicture.asset(
                      IconsConstant.search,
                      color: Theme.of(context).brightness == Brightness.light ? whiteColor : blueJNE,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: controller.aggregations.map((aggregation) {
                        return _aggregationItem(aggregation);
                      }).toList()
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _aggregationItem(AggregationMinusModel aggregation) {
    return AggregationMinusItem(
      data: aggregation
    );
  }

}
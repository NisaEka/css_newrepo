import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/screen/keuanganmu/minus/detail/cnote/aggregation_minus_cnote_screen.dart';
import 'package:css_mobile/screen/keuanganmu/minus/detail/doc/aggregation_minus_doc_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggminus_box.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggregation_minus_box.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggregation_minus_doc_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AggregationMinusDocScreen extends StatelessWidget {

  const AggregationMinusDocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AggregationMinusDocController>(
      init: AggregationMinusDocController(),
      builder: (controller) {
        return Scaffold(
          appBar: _aggregationMinusDocAppBar(),
          body: _aggregationMinusDocBody(context, controller),
        );
      }
    );
  }

  PreferredSizeWidget _aggregationMinusDocAppBar() {
    return CustomTopBar(
      title: 'Laporan Aggregasi Minus'.tr,
    );
  }

  Widget _aggregationMinusDocBody(BuildContext context, AggregationMinusDocController controller) {
    return Column(
      children: [
        _topBox(controller.docArgs),
        _searchBox(context),
        _listData(controller)
      ],
    );
  }


  Widget _topBox(String docId) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16
      ),
      child: AggregationMinusBox(
        title: "Document No".tr,
        value: docId,
      ),
    );
  }

  Widget _searchBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16
      ),
      child: CustomSearchField(
        controller: TextEditingController(),
        hintText: 'Cari berdasarkan no resi'.tr,
        prefixIcon: SvgPicture.asset(
          IconsConstant.search,
          color: Theme.of(context).brightness == Brightness.light
              ? whiteColor
              : blueJNE,
        ),
      ),
    );
  }

  Widget _listData(AggregationMinusDocController controller) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: controller.aggregations.map((aggregation) {
          return AggregationMinusDocItem(
            data: aggregation,
            onTap: () => {
              Get.to(AggregationMinusCnoteScreen(data: aggregation))
            },
          );
        }).toList(),
      ),
    );
  }

}

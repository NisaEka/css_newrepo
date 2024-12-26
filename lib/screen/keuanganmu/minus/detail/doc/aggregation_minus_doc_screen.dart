import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_doc_model.dart';
import 'package:css_mobile/screen/keuanganmu/minus/detail/cnote/aggregation_minus_cnote_screen.dart';
import 'package:css_mobile/screen/keuanganmu/minus/detail/doc/aggregation_minus_doc_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggregation_minus_box.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggregation_minus_doc_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AggregationMinusDocScreen extends StatelessWidget {
  const AggregationMinusDocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AggregationMinusDocController>(
        init: AggregationMinusDocController(),
        builder: (controller) {
          return Scaffold(
            appBar: _aggregationMinusDocAppBar(),
            body: _bodyContent(context, controller),
          );
        });
  }

  PreferredSizeWidget _aggregationMinusDocAppBar() {
    return CustomTopBar(
      title: 'Laporan Aggregasi Minus'.tr,
    );
  }

  Widget _bodyContent(
      BuildContext context, AggregationMinusDocController controller) {
    return Column(
      children: [
        _topBox(controller.docArgs),
        _searchBox(context, controller),
        _listData(controller)
      ],
    );
  }

  Widget _topBox(String docId) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: AggregationMinusBox(
        title: "Document No".tr,
        value: docId,
      ),
    );
  }

  Widget _searchBox(
      BuildContext context, AggregationMinusDocController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 30, right: 30),
      child: CustomSearchField(
        margin: const EdgeInsets.symmetric(vertical: 0),
        controller: controller.searchField,
        hintText: 'Cari berdasarkan no resi'.tr,
        prefixIcon: SvgPicture.asset(
          IconsConstant.search,
          color: Theme.of(context).brightness == Brightness.light
              ? whiteColor
              : blueJNE,
        ),
        onChanged: (value) {
          controller.searchField.text = value;
          controller.update();
          controller.pagingController.refresh();
        },
        onClear: () {
          controller.searchField.clear();
          controller.pagingController.refresh();
        },
      ),
    );
  }

  Widget _listData(AggregationMinusDocController controller) {
    return Expanded(
        child: RefreshIndicator(
      onRefresh: () => Future.sync(() => controller.pagingController.refresh()),
      child: PagedListView<int, AggregationMinusDocModel>(
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate<AggregationMinusDocModel>(
            transitionDuration: const Duration(milliseconds: 500),
            itemBuilder: (context, aggregation, index) =>
                AggregationMinusDocItem(
                  data: aggregation,
                  onTap: () => {
                    Get.to(() => AggregationMinusCnoteScreen(data: aggregation))
                  },
                ),
            firstPageErrorIndicatorBuilder: (context) => const DataEmpty(),
            noItemsFoundIndicatorBuilder: (context) => const DataEmpty()),
      ),
    ));
  }
}

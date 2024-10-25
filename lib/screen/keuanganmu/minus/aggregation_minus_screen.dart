import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:css_mobile/screen/keuanganmu/minus/aggregation_minus_controller.dart';
import 'package:css_mobile/screen/keuanganmu/minus/detail/doc/aggregation_minus_doc_screen.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggminus_box.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggregation_minus_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AggregationMinusScreen extends StatefulWidget {
  const AggregationMinusScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AggregationMinusScreenState();
}

class _AggregationMinusScreenState extends State<AggregationMinusScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AggregasiMinusController>(
        init: AggregasiMinusController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Laporan Aggregasi Minus'.tr,
            ),
            body: _bodyContent(controller, context),
          );
        });
  }

  Widget _bodyContent(AggregasiMinusController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: [
          const AggMinusBox(),
          CustomSearchField(
            controller: c.searchField,
            hintText: 'Cari Data Aggregasi Minus'.tr,
            prefixIcon: SvgPicture.asset(
              IconsConstant.search,
              color: AppConst.isLightTheme(context) ? whiteColor : blueJNE,
            ),
            onChanged: (value) {
              c.searchField.text = value;
              c.update();
              c.pagingController.refresh();
            },
            onClear: () {
              c.searchField.clear();
              c.pagingController.refresh();
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(() => c.pagingController.refresh()),
              child: PagedListView<int, AggregationMinusModel>(
                pagingController: c.pagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<AggregationMinusModel>(
                  transitionDuration: const Duration(milliseconds: 500),
                  itemBuilder: (context, item, index) => _aggregationItem(item),
                  firstPageErrorIndicatorBuilder: (context) =>
                      const DataEmpty(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _aggregationItem(AggregationMinusModel aggregation) {
    return AggregationMinusItem(
        data: aggregation,
        onTap: () => {
              Get.to(const AggregationMinusDocScreen(),
                  arguments: {"doc": aggregation.aggMinDoc})
            });
  }
}

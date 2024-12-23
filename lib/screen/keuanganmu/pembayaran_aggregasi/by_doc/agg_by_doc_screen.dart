import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_detail_model.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/by_cnote/agg_by_cnote_screen.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/by_doc/agg_by_doc_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/report_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../const/app_const.dart';
import '../../../../const/textstyle.dart';

class AggByDocScreen extends StatelessWidget {
  const AggByDocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AggByDocController>(
        init: AggByDocController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Laporan Pembayaran Aggregasi'.tr,
            ),
            body: _bodyContent(controller, context),
          );
        });
  }

  Widget _bodyContent(AggByDocController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PaymentBox(
          //   title: "Document No".tr,
          //   value: c.aggregationID,
          // ),
          Text(
            c.aggregationID,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: AppConst.isLightTheme(context) ? blueJNE : warningColor,
                fontWeight: bold),
          ),
          Text(
            "Document No".tr,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 16),
          CustomSearchField(
            margin: const EdgeInsets.only(top: 0),
            controller: c.searchField,
            hintText: 'Cari Data Agregasi'.tr,
            prefixIcon: SvgPicture.asset(
              IconsConstant.search,
              color: Theme.of(context).brightness == Brightness.light
                  ? infoColor
                  : blueJNE,
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
              onRefresh: () => Future.sync(
                () => c.pagingController.refresh(),
              ),
              child: PagedListView<int, AggregationDetailModel>(
                pagingController: c.pagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<AggregationDetailModel>(
                  transitionDuration: const Duration(milliseconds: 500),
                  itemBuilder: (context, item, index) => ReportListItem(
                    det: item,
                    isShowDetail: false,
                    onTap: () => Get.to(
                      const AggByCnoteScreen(),
                      arguments: {
                        "cnote_data": item,
                      },
                    ),
                  ),
                  firstPageErrorIndicatorBuilder: (context) =>
                      const DataEmpty(),
                  firstPageProgressIndicatorBuilder: (context) => Column(
                    children: List.generate(
                      3,
                      (index) => const ReportListItem(
                        isLoading: true,
                      ),
                    ),
                  ),
                  noItemsFoundIndicatorBuilder: (context) => const DataEmpty(),
                  noMoreItemsIndicatorBuilder: (context) => const Center(
                    child: Divider(
                      indent: 100,
                      endIndent: 100,
                      thickness: 2,
                      color: blueJNE,
                    ),
                  ),
                  newPageProgressIndicatorBuilder: (context) =>
                      const LoadingDialog(
                    background: Colors.transparent,
                    height: 50,
                    size: 30,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

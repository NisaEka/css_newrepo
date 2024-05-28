import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/by_cnote/agg_by_cnote_screen.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/by_doc/agg_by_doc_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/lappembayaran_box.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/report_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          PaymentBox(
            title: "Document No".tr,
            value: "# JNEPWD2400000662",
          ),
          CustomSearchField(
            controller: c.searchField,
            hintText: 'Cari Data Agregasi'.tr,
            prefixIcon: SvgPicture.asset(
              IconsConstant.search,
              color: Theme.of(context).brightness == Brightness.light ? whiteColor : blueJNE,
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
          ReportListItem(
            isShowDetail: false,
            onTap: () => Get.to(const AggByCnoteScreen()),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () => c.pagingController.refresh(),
              ),
              child: PagedListView<int, dynamic>(
                pagingController: c.pagingController,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  transitionDuration: const Duration(milliseconds: 500),
                  itemBuilder: (context, item, index) => ReportListItem(
                    status: item.statusGv,
                    data: item,
                    isShowDetail: false,
                    onTap: () => Get.to(const AggByCnoteScreen()),
                  ),
                  firstPageErrorIndicatorBuilder: (context) => const DataEmpty(),
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
                  newPageProgressIndicatorBuilder: (context) => const LoadingDialog(
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

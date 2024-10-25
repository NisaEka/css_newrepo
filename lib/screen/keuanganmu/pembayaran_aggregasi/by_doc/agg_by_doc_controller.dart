import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_detail_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AggByDocController extends BaseController {
  String aggregationID = Get.arguments['aggregationID'];

  final searchField = TextEditingController();
  final PagingController<int, AggregationDetailModel> pagingController =
      PagingController<int, AggregationDetailModel>(firstPageKey: 1);

  bool isLoading = false;
  static const pageSize = 10;
  GetAggregationDetailModel? data;

  @override
  void onInit() {
    super.onInit();
    // Future.wait([initData()]);
    pagingController.addPageRequestListener((pageKey) {
      getAggregation(pageKey);
    });
    update();
  }

  Future<void> getAggregation(int page) async {
    isLoading = true;
    try {
      final agg =
          await aggregation.getAggregationByDoc(page, pageSize, aggregationID);
      data = agg;
      update();
      final isLastPage = (agg.payload?.length ?? 0) < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(agg.payload ?? []);
        // transactionList.addAll(pagingController.itemList ?? []);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(agg.payload ?? [], nextPageKey);
        // transactionList.addAll(pagingController.itemList ?? []);
      }
    } catch (e, i) {
      e.printError();
      i.printError();
      pagingController.error = e;
    }

    isLoading = false;
    update();
  }
}

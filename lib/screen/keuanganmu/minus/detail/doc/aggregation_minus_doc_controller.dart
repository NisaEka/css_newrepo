import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_doc_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AggregationMinusDocController extends BaseController {
  String docArgs = Get.arguments["doc"];

  final searchField = TextEditingController();

  bool showLoadingIndicator = false;
  bool showProhibitedContent = false;
  bool showMainContent = false;
  bool showErrorContent = false;

  final PagingController<int, AggregationMinusDocModel> pagingController =
      PagingController(firstPageKey: 1);
  static const pageSize = 20;

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      getAggregationMinusesByDoc(pageKey);
    });
  }

  Future<void> getAggregationMinusesByDoc(int page) async {
    showLoadingIndicator = true;
    try {
      final aggregations = await aggregation.getAggregationMinusDoc(
          docArgs,
          QueryModel(
            page: page,
            limit: pageSize,
            search: searchField.text,
          ));

      final payload = aggregations.data ?? List.empty();
      final isLastPage = payload.length < pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(payload);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(payload, nextPageKey);
      }
    } catch (e) {
      showErrorContent = true;
      update();
    }

    showLoadingIndicator = false;
    update();
  }
}

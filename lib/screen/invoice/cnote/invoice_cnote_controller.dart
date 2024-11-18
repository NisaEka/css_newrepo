import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InvoiceCnoteController extends BaseController {
  String invoiceNumber = Get.arguments["invoice_number"];

  // final DefaultPageFilterModel _defaultPageFilterModel =
  //     DefaultPageFilterModel();
  final QueryParamModel _queryParamModel = QueryParamModel();

  final PagingController<int, InvoiceCnoteModel> pagingController =
      PagingController(firstPageKey: Constant.defaultPage);

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _getInvoiceCnotes(pageKey);
    });
  }

  void _getInvoiceCnotes(int page) async {
    try {
      _queryParamModel.setPage(page);
      final response = await invoiceRepository.getInvoiceCnotes(
          invoiceNumber, _queryParamModel);

      final payload = response.data ?? List.empty();
      // final isLastPage = payload.length < (_queryParamModel.limit ?? 0);
      final isLastPage = response.meta!.currentPage == response.meta!.lastPage;

      if (isLastPage) {
        pagingController.appendLastPage(payload);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(payload, nextPageKey);
      }
    } catch (e) {
      AppLogger.e('error getInvoiceCnotes $e');
    }
  }

  void requireRetry() {
    _getInvoiceCnotes(Constant.defaultPage);
  }

  void refreshInvoices() {
    pagingController.refresh();
  }
}

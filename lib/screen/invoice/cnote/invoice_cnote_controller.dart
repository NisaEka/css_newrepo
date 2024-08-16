import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/default_page_filter_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_model.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InvoiceCnoteController extends BaseController {

  String invoiceNumber = Get.arguments["invoice_number"];

  final DefaultPageFilterModel _defaultPageFilterModel = DefaultPageFilterModel();

  final PagingController<int, InvoiceCnoteModel> pagingController = PagingController(firstPageKey: Constant.defaultPage);

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _getInvoiceCnotes(pageKey);
    });
  }

  void _getInvoiceCnotes(int page) async {
    try {
      _defaultPageFilterModel.setPage(page);
      final response = await invoiceRepository.getInvoiceCnotes(invoiceNumber, _defaultPageFilterModel);

      final payload = response.payload ?? List.empty();
      final isLastPage = payload.length < _defaultPageFilterModel.limit;

      if (isLastPage) {
        pagingController.appendLastPage(payload);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(payload, nextPageKey);
      }
    } catch (e) {
      e.printError();
    }
  }

  void requireRetry() {
    _getInvoiceCnotes(Constant.defaultPage);
  }

  void refreshInvoices() {
    pagingController.refresh();
  }

}
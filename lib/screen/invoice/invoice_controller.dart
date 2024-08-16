import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/advance_filter_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InvoiceController extends BaseController {

  AdvanceFilterModel _advanceFilterModel = AdvanceFilterModel();

  final PagingController<int, InvoiceModel> pagingController = PagingController(firstPageKey: Constant.defaultPage);

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _getInvoices(pageKey);
    });
  }

  void _getInvoices(int page) async {
    try {
      _advanceFilterModel.setPage(page);
      final response = await invoiceRepository.getInvoices(_advanceFilterModel);

      final payload = response.payload ?? List.empty();
      final isLastPage = payload.length < _advanceFilterModel.limit;

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
    _getInvoices(Constant.defaultPage);
  }

  void refreshInvoices() {
    pagingController.refresh();
  }

}
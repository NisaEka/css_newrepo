import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InvoiceController extends BaseController {

  bool _showLoadingIndicator = false;
  bool get showLoadingIndicator => _showLoadingIndicator;

  bool _showMainContent = false;
  bool get showMainContent => _showMainContent;

  bool _showErrorContent = false;
  bool get showErrorContent => _showErrorContent;

  bool _showEmptyContent = false;
  bool get showEmptyContent => _showEmptyContent;

  final PagingController<int, InvoiceModel> pagingController = PagingController(firstPageKey: Constant.defaultPage);

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _getInvoices(pageKey);
    });
  }

  void _getInvoices(int page) {

  }

  void requireRetry() {

  }

}
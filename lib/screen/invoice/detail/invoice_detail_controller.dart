import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/invoice/invoice_detail_model.dart';
import 'package:get/get.dart';

class InvoiceDetailController extends BaseController {

  String invoiceNumber = Get.arguments["invoice_number"];

  bool _showLoadingIndicator = false;
  bool get showLoadingIndicator => _showLoadingIndicator;

  bool _showMainContent = false;
  bool get showMainContent => _showMainContent;

  bool _showErrorContent = false;
  bool get showErrorContent => _showErrorContent;

  bool _showEmptyContent = false;
  bool get showEmptyContent => _showEmptyContent;

  InvoiceDetailModel? _invoiceDetailModel;
  InvoiceDetailModel? get invoiceDetailModel => _invoiceDetailModel;

  @override
  void onInit() {
    super.onInit();
    Future.wait([_getInvoiceDetail()]);
  }

  Future<void> _getInvoiceDetail() async {
    _showLoadingIndicator = true;
    update();

    try {
      final invoice = await invoiceRepository.getInvoiceByNumber(invoiceNumber);

      if (invoice.payload != null) {
        _invoiceDetailModel = invoice.payload;

        _showMainContent = true;
        update();
      } else {
        _showEmptyContent = true;
        update();
      }

    } catch (error) {
      _showErrorContent = true;
      update();

      error.printError();
    }

    _showLoadingIndicator = false;
    update();
  }

  void refreshInvoice() {
    _getInvoiceDetail();
  }

}
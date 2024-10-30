import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_detail_model.dart';
import 'package:get/get.dart';

class InvoiceCnoteDetailController extends BaseController {
  String invoiceNumber = Get.arguments["invoice_number"];
  String awb = Get.arguments["awb"];

  bool _showLoadingIndicator = false;
  bool get showLoadingIndicator => _showLoadingIndicator;

  bool _showMainContent = false;
  bool get showMainContent => _showMainContent;

  bool _showErrorContent = false;
  bool get showErrorContent => _showErrorContent;

  bool _showEmptyContent = false;
  bool get showEmptyContent => _showEmptyContent;

  InvoiceCnoteDetailModel? _invoiceCnoteDetailModel;
  InvoiceCnoteDetailModel? get invoiceCnoteDetailModel =>
      _invoiceCnoteDetailModel;

  @override
  void onInit() {
    super.onInit();
    Future.wait([_getInvoiceCnoteDetail()]);
  }

  Future<void> _getInvoiceCnoteDetail() async {
    _showLoadingIndicator = true;
    update();

    try {
      final invoice =
          await invoiceRepository.getInvoiceCnoteByAwb(invoiceNumber, awb);

      if (invoice.data != null) {
        _invoiceCnoteDetailModel = invoice.data;

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
    _getInvoiceCnoteDetail();
  }
}

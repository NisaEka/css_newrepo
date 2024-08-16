import 'package:css_mobile/data/model/advance_filter_model.dart';
import 'package:css_mobile/data/model/default_page_filter_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_detail_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_detail_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';

abstract class InvoiceRepository {
  Future<DefaultResponseModel<num>> getInvoiceCount(AdvanceFilterModel advanceFilter);
  Future<DefaultResponseModel<List<InvoiceModel>>> getInvoices(AdvanceFilterModel advanceFilter);
  Future<DefaultResponseModel<InvoiceDetailModel>> getInvoiceByNumber(String invoiceNumber);
  Future<DefaultResponseModel<List<InvoiceCnoteModel>>> getInvoiceCnotes(String invoiceNumber, DefaultPageFilterModel filter);
  Future<DefaultResponseModel<InvoiceCnoteDetailModel>> getInvoiceCnoteByAwb(String invoiceNumber, String awb);
}
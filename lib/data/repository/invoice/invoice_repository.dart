import 'package:css_mobile/data/model/advance_filter_model.dart';
import 'package:css_mobile/data/model/default_page_filter_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_detail_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_detail_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/data/model/response_model.dart';

abstract class InvoiceRepository {
  Future<ResponseModel<num>> getInvoiceCount(AdvanceFilterModel advanceFilter);
  Future<ResponseModel<List<InvoiceModel>>> getInvoices(AdvanceFilterModel advanceFilter);
  Future<ResponseModel<InvoiceDetailModel>> getInvoiceByNumber(String invoiceNumber);
  Future<ResponseModel<List<InvoiceCnoteModel>>> getInvoiceCnotes(String invoiceNumber, DefaultPageFilterModel filter);
  Future<ResponseModel<InvoiceCnoteDetailModel>> getInvoiceCnoteByAwb(String invoiceNumber, String awb);
}
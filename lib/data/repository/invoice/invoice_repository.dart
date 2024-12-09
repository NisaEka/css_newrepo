import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_detail_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_detail_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/data/model/query_model.dart';

abstract class InvoiceRepository {
  Future<BaseResponse<num>> getInvoiceCount(QueryModel queryParam);
  Future<BaseResponse<List<InvoiceModel>>> getInvoices(QueryModel queryParam);
  Future<BaseResponse<InvoiceDetailModel>> getInvoiceByNumber(
      String invoiceNumber);
  Future<BaseResponse<List<InvoiceCnoteModel>>> getInvoiceCnotes(
      String invoiceNumber, QueryModel queryParam);
  Future<BaseResponse<InvoiceCnoteDetailModel>> getInvoiceCnoteByAwb(
      String invoiceNumber, String awb);
}

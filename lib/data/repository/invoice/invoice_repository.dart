import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_detail_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_detail_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';

abstract class InvoiceRepository {
  Future<BaseResponse<num>> getInvoiceCount(QueryParamModel queryParam);
  Future<BaseResponse<List<InvoiceModel>>> getInvoices(
      QueryParamModel queryParam);
  Future<BaseResponse<InvoiceDetailModel>> getInvoiceByNumber(
      String invoiceNumber);
  Future<BaseResponse<List<InvoiceCnoteModel>>> getInvoiceCnotes(
      String invoiceNumber, QueryParamModel queryParam);
  Future<BaseResponse<InvoiceCnoteDetailModel>> getInvoiceCnoteByAwb(
      String invoiceNumber, String awb);
}

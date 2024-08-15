import 'package:css_mobile/data/model/advance_filter_model.dart';
import 'package:css_mobile/data/model/default_page_filter_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_detail_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_detail_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/invoice/invoice_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class InvoiceImpl extends InvoiceRepository {

  final network = Get.find<NetworkCore>();

  @override
  Future<DefaultResponseModel<List<InvoiceModel>>> getInvoices(AdvanceFilterModel advanceFilter) async {
    try {
      var response = await network.dio.get("/invoice", queryParameters: advanceFilter.toJson());
      List<InvoiceModel> invoices = [];

      response.data["payload"].forEach((invoice) {
        invoices.add(InvoiceModel.fromJson(invoice));
      });

      return DefaultResponseModel.fromJson(response.data, invoices);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }

  @override
  Future<DefaultResponseModel<InvoiceDetailModel>> getInvoiceByNumber(String invoiceNumber) async {
    try {
      var response = await network.dio.get("/invoice/$invoiceNumber");
      InvoiceDetailModel invoice = InvoiceDetailModel.fromJson(response.data["payload"]);
      return DefaultResponseModel.fromJson(response.data, invoice);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, null);
    }
  }

  @override
  Future<DefaultResponseModel<InvoiceCnoteDetailModel>> getInvoiceCnoteByAwb(String invoiceNumber, String awb) async {
    try {
      var response = await network.dio.get("/invoice/$invoiceNumber/cnote/$awb");
      InvoiceCnoteDetailModel invoice = InvoiceCnoteDetailModel.fromJson(response.data["payload"]);
      return DefaultResponseModel.fromJson(response.data, invoice);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, null);
    }
  }

  @override
  Future<DefaultResponseModel<List<InvoiceCnoteModel>>> getInvoiceCnotes(String invoiceNumber, DefaultPageFilterModel filter) async {
    try {
      var response = await network.dio.get("/invoice/$invoiceNumber/cnote", queryParameters: filter.toJson());
      List<InvoiceCnoteModel> invoices = [];

      response.data["payload"].forEach((invoice) {
        invoices.add(InvoiceCnoteModel.fromJson(invoice));
      });

      return DefaultResponseModel.fromJson(response.data, invoices);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }

}
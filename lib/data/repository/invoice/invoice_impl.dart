import 'package:css_mobile/data/model/advance_filter_model.dart';
import 'package:css_mobile/data/model/default_page_filter_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_detail_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_detail_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/data/model/response_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/invoice/invoice_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class InvoiceImpl extends InvoiceRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<ResponseModel<num>> getInvoiceCount(AdvanceFilterModel advanceFilter) async {
    var token = await storageSecure.read(key: "token");
    // var token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyaWQiOiIyMzEyMjIxNjI1NTAxNTQ1OSIsImlhdCI6MTcwODU4MDg0Mn0.Yc5lrv4gxCeZjfNAmxv6PFehfW6HoZVUZ5IYwuqHK9M';
    network.local.options.headers['Authorization'] = 'Bearer $token';

    try {
      var response = await network.local.get("/invoice/count", queryParameters: advanceFilter.toJson());
      return ResponseModel.fromJson(
        response.data,
        (json) => json as num,
      );
    } on DioException catch (e) {
      return ResponseModel.fromJson(
        e.response?.data,
        (json) => json as num,
      );
    }
  }

  @override
  Future<ResponseModel<List<InvoiceModel>>> getInvoices(AdvanceFilterModel advanceFilter) async {
    var token = await storageSecure.read(key: "token");
    // var token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyaWQiOiIyMzEyMjIxNjI1NTAxNTQ1OSIsImlhdCI6MTcwODU4MDg0Mn0.Yc5lrv4gxCeZjfNAmxv6PFehfW6HoZVUZ5IYwuqHK9M';
    network.local.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.local.get(
        "/invoice",
        queryParameters: advanceFilter.toJson(),
      );

      return ResponseModel<List<InvoiceModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<InvoiceModel>(
                  (i) => InvoiceModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return ResponseModel<List<InvoiceModel>>.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<InvoiceModel>(
                  (i) => InvoiceModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }

  @override
  Future<ResponseModel<InvoiceDetailModel>> getInvoiceByNumber(String invoiceNumber) async {
    try {
      var response = await network.local.get("/invoice/$invoiceNumber");
      return ResponseModel.fromJson(
          response.data,
          (json) => InvoiceDetailModel.fromJson(
                json as Map<String, dynamic>,
              ));
    } on DioException catch (e) {
      return ResponseModel.fromJson(
          e.response?.data,
          (json) => InvoiceDetailModel.fromJson(
                json as Map<String, dynamic>,
              ));
    }
  }

  @override
  Future<ResponseModel<InvoiceCnoteDetailModel>> getInvoiceCnoteByAwb(String invoiceNumber, String awb) async {
    try {
      var response = await network.local.get("/invoice/$invoiceNumber/cnote/$awb");
      return ResponseModel.fromJson(
        response.data,
        (json) => InvoiceCnoteDetailModel.fromJson(
          json as Map<String, dynamic>,
        ),
      );
    } on DioException catch (e) {
      return ResponseModel.fromJson(
        e.response?.data,
        (json) => InvoiceCnoteDetailModel.fromJson(
          json as Map<String, dynamic>,
        ),
      );
    }
  }

  @override
  Future<ResponseModel<List<InvoiceCnoteModel>>> getInvoiceCnotes(String invoiceNumber, DefaultPageFilterModel filter) async {
    try {
      var response = await network.local.get("/invoice/$invoiceNumber/cnote", queryParameters: filter.toJson());
      List<InvoiceCnoteModel> invoices = [];

      response.data["payload"].forEach((invoice) {
        invoices.add(InvoiceCnoteModel.fromJson(invoice));
      });

      return ResponseModel.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<InvoiceCnoteModel>(
                  (i) => InvoiceCnoteModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return ResponseModel.fromJson(e.response?.data, (json) => List.empty());
    }
  }
}

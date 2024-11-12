import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_detail_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_detail_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/invoice/invoice_repository.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class InvoiceImpl extends InvoiceRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<BaseResponse<num>> getInvoiceCount(QueryParamModel queryParam) async {
    var token = await storageSecure.read(key: "token");
    // var token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyaWQiOiIyMzEyMjIxNjI1NTAxNTQ1OSIsImlhdCI6MTcwODU4MDg0Mn0.Yc5lrv4gxCeZjfNAmxv6PFehfW6HoZVUZ5IYwuqHK9M';
    network.base.options.headers['Authorization'] = 'Bearer $token';

    AppLogger.i("param toJson ${queryParam.toJson()}");

    try {
      var response = await network.base
          .get("/invoices/count", queryParameters: queryParam.toJson());
      return BaseResponse.fromJson(
        response.data,
        (json) => json as num,
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => json as num,
      );
    }
  }

  @override
  Future<BaseResponse<List<InvoiceModel>>> getInvoices(
      QueryParamModel queryParam) async {
    var token = await storageSecure.read(key: "token");
    // var token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyaWQiOiIyMzEyMjIxNjI1NTAxNTQ1OSIsImlhdCI6MTcwODU4MDg0Mn0.Yc5lrv4gxCeZjfNAmxv6PFehfW6HoZVUZ5IYwuqHK9M';
    network.base.options.headers['Authorization'] = 'Bearer $token';

    AppLogger.i("param toJson ${queryParam.toJson()}");

    try {
      Response response = await network.base.get(
        "/invoices",
        queryParameters: queryParam.toJson(),
      );

      return BaseResponse<List<InvoiceModel>>.fromJson(
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
      return BaseResponse<List<InvoiceModel>>.fromJson(
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
  Future<BaseResponse<InvoiceDetailModel>> getInvoiceByNumber(
      String invoiceNumber) async {
    try {
      var encodedInvoiceNumber = Uri.encodeComponent(invoiceNumber);
      var response = await network.base.get("/invoices/$encodedInvoiceNumber");
      return BaseResponse.fromJson(
          response.data,
          (json) => InvoiceDetailModel.fromJson(
                json as Map<String, dynamic>,
              ));
    } on DioException catch (e) {
      return BaseResponse.fromJson(
          e.response?.data,
          (json) => InvoiceDetailModel.fromJson(
                json as Map<String, dynamic>,
              ));
    }
  }

  @override
  Future<BaseResponse<InvoiceCnoteDetailModel>> getInvoiceCnoteByAwb(
      String invoiceNumber, String awb) async {
    try {
      var encodedInvoiceNumber = Uri.encodeComponent(invoiceNumber);
      var response =
          await network.base.get("/invoices/$encodedInvoiceNumber/cnotes/$awb");
      return BaseResponse.fromJson(
        response.data,
        (json) => InvoiceCnoteDetailModel.fromJson(
          json as Map<String, dynamic>,
        ),
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => InvoiceCnoteDetailModel.fromJson(
          json as Map<String, dynamic>,
        ),
      );
    }
  }

  @override
  Future<BaseResponse<List<InvoiceCnoteModel>>> getInvoiceCnotes(
      String invoiceNumber, QueryParamModel queryParam) async {
    AppLogger.i("param toJson ${queryParam.toJson()}");
    try {
      var encodedInvoiceNumber = Uri.encodeComponent(invoiceNumber);
      var response = await network.base.get(
          "/invoices/$encodedInvoiceNumber/cnotes",
          queryParameters: queryParam.toJson());
      List<InvoiceCnoteModel> invoices = [];

      response.data["data"].forEach((invoice) {
        invoices.add(InvoiceCnoteModel.fromJson(invoice));
      });

      return BaseResponse.fromJson(
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
      return BaseResponse.fromJson(e.response?.data, (json) => List.empty());
    }
  }
}

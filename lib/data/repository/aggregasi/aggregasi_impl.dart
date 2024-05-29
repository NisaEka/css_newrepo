import 'package:css_mobile/data/model/aggregasi/aggregation_minus_doc_model.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_detail_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_total_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/aggregasi/aggregasi_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class AggregasiRepositoryImpl extends AggregasiRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<GetAggregationReportModel> getAggregationReport(
    int page,
    int limit,
    String keyword,
    String aggDate,
    List<String> accounts,
  ) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    network.local.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.local.get(
        "/aggregation",
        queryParameters: {
          "keyword": keyword,
          "page": page,
          "limit": limit,
          "agg_date": aggDate,
          // "account_number": accounts.toString().splitMapJoin(',').replaceAll('[', '').replaceAll(']', '').toString(),
          "account_number": "80563317,80563320",
        },
      );

      return GetAggregationReportModel.fromJson(response.data);
    } on DioException catch (e) {

      return GetAggregationReportModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<DefaultResponseModel<List<AggregationMinusModel>>> getAggregationMinus(
    int page,
    int limit,
    String? keyword,
  ) async {
    try {
      var response = await network.dio.get("/aggregation/minus", queryParameters: {"page": page, "limit": limit, "keyword": keyword});
      List<AggregationMinusModel> aggregations = [];
      response.data["payload"].forEach((aggregation) {
        aggregations.add(AggregationMinusModel.fromJson(aggregation));
      });
      return DefaultResponseModel.fromJson(response.data, aggregations);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }

  @override
  Future<DefaultResponseModel<List<AggregationMinusDocModel>>> getAggregationMinusDoc(String doc, int page, int limit, String? keyword) async {
    try {
      var response = await network.dio.get("/aggregation/minus/$doc", queryParameters: {"page": page, "limit": limit, "keyword": keyword});
      List<AggregationMinusDocModel> aggregations = [];
      response.data["payload"].forEach((aggregation) {
        aggregations.add(AggregationMinusDocModel.fromJson(aggregation));
      });
      return DefaultResponseModel.fromJson(response.data, aggregations);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }

  @override
  Future<GetAggregationTotalModel> getAggregationTotal() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    network.local.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/aggregation/total",
      );
      print('aggregation response: ${response.data}');

      return GetAggregationTotalModel.fromJson(response.data);
    } on DioException catch (e) {
      print("aggregation error : ${e.response?.data}");
      return GetAggregationTotalModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetAggregationDetailModel> getAggregationByDoc(
    int page,
    int limit,
    String aggregationID,
  ) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    network.local.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.local.get(
        "/aggregation/$aggregationID",
      );

      return GetAggregationDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetAggregationDetailModel.fromJson(e.response?.data);
    }
  }
}

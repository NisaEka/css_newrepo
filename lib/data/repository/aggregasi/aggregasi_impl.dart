import 'package:css_mobile/data/model/aggregasi/aggregation_minus_detail_model.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';
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
    String transDate,
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
          "agg_date": transDate,

        },
      );
      print('aggregation response: ${response.data}');

      return GetAggregationReportModel.fromJson(response.data);
    } on DioException catch (e) {
      print("aggregation error : ${e.response?.data}");
      return GetAggregationReportModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<DefaultResponseModel<List<AggregationMinusModel>>> getAggregationMinus() async {
    try {
      var response = await network.dio.get("/aggregation/minus");
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
  Future<DefaultResponseModel<List<AggregationMinusDocModel>>> getAggregationMinusDetail(String doc) async {
    try {
      var response = await network.dio.get("/aggregation/minus/$doc");
      List<AggregationMinusDocModel> aggregations = [];
      response.data["payload"].forEach((aggregation) {
        aggregations.add(AggregationMinusDocModel.fromJson(aggregation));
      });
      return DefaultResponseModel.fromJson(response.data, aggregations);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }

}

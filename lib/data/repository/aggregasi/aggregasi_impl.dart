import 'package:css_mobile/data/model/aggregasi/aggregation_minus_doc_model.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_detail_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_total_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';

import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/aggregasi/aggregasi_repository.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class AggregasiRepositoryImpl extends AggregasiRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<BaseResponse<List<AggregationModel>>> getAggregationReport(
      QueryParamModel param) async {
    AppLogger.i("param toJson ${param.toJson()}");
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.base.get(
        "/aggregations",
        queryParameters: param.toJson(),
      );

      return BaseResponse<List<AggregationModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<AggregationModel>(
                  (i) => AggregationModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<DefaultResponseModel<List<AggregationMinusModel>>> getAggregationMinus(
    int page,
    int limit,
    String? keyword,
  ) async {
    try {
      var response = await network.base.get("/aggregations/minus",
          queryParameters: {"page": page, "limit": limit, "keyword": keyword});
      List<AggregationMinusModel> aggregations = [];
      response.data["data"].forEach((aggregation) {
        aggregations.add(AggregationMinusModel.fromJson(aggregation));
      });
      return DefaultResponseModel.fromJson(response.data, aggregations);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }

  @override
  Future<DefaultResponseModel<List<AggregationMinusDocModel>>>
      getAggregationMinusDoc(
          String doc, int page, int limit, String? keyword) async {
    try {
      var response = await network.base.get("/aggregations/minus/$doc",
          queryParameters: {"page": page, "limit": limit, "keyword": keyword});
      List<AggregationMinusDocModel> aggregations = [];
      response.data["data"].forEach((aggregation) {
        aggregations.add(AggregationMinusDocModel.fromJson(aggregation));
      });
      return DefaultResponseModel.fromJson(response.data, aggregations);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }

  @override
  Future<GetAggregationTotalModel> getAggregationTotal(
      QueryParamModel param) async {
    AppLogger.i("param toJson total ${param.toJson()}");
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.get(
        "/aggregations/total",
        queryParameters: param.toJson(),
      );
      GetAggregationTotalModel resp =
          GetAggregationTotalModel.fromJson(response.data);

      return resp;
    } on DioException catch (e) {
      return GetAggregationTotalModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<BaseResponse<List<AggregationDetailModel>>> getAggregationByDoc(
      String aggregationID, QueryParamModel param) async {
    AppLogger.i("param toJson ${param.toJson()}");
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.get(
        "/aggregations/$aggregationID",
      );

      return BaseResponse<List<AggregationDetailModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<AggregationDetailModel>(
                  (i) => AggregationDetailModel.fromJson(
                      i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}

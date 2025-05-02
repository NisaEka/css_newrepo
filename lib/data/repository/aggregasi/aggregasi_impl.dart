import 'package:css_mobile/data/model/aggregasi/aggregation_minus_doc_model.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_detail_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_total_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
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
  Future<BaseResponse<List<AggregationModel>>> getAggregationReport(QueryModel param) async {
    AppLogger.i("param toJson ${param.toJson()}");
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
      AppLogger.e("error get aggregation : $e");
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse<List<AggregationMinusModel>>> getAggregationMinus(QueryModel param) async {
    try {
      var response = await network.base.get("/aggregations/minus", queryParameters: param.toJson());
      return BaseResponse<List<AggregationMinusModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<AggregationMinusModel>(
                  (i) => AggregationMinusModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.e("dio error agg minus : $e");
      return e.response?.data ?? e;
    }
  }

  @override
  Future<BaseResponse<List<AggregationMinusDocModel>>> getAggregationMinusDoc(String doc, QueryModel param) async {
    AppLogger.i("param toJson ${param.toJson()}");
    try {
      var response = await network.base.get("/aggregations/minus/$doc", queryParameters: param.toJson());
      return BaseResponse<List<AggregationMinusDocModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<AggregationMinusDocModel>(
                  (i) => AggregationMinusDocModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse<AggTotal>> getAggregationTotal(QueryModel param) async {
    AppLogger.i("param toJson total ${param.toJson()}");
    try {
      Response response = await network.base.get(
        "/aggregations/total",
        queryParameters: param.toJson(),
      );
      BaseResponse<AggTotal> resp = BaseResponse.fromJson(
        response.data,
        (json) {
          return AggTotal.fromJson(json as Map<String, dynamic>);
        },
      );
      return resp;
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) {
          return AggTotal.fromJson(json as Map<String, dynamic>);
        },
      );
    }
  }

  @override
  Future<BaseResponse<List<AggregationDetailModel>>> getAggregationByDoc(String aggregationID, QueryModel param) async {
    AppLogger.i("param toJson ${param.toJson()}");
    try {
      Response response = await network.base.get(
        "/aggregations/$aggregationID",
      );

      return BaseResponse<List<AggregationDetailModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<AggregationDetailModel>(
                  (i) => AggregationDetailModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}

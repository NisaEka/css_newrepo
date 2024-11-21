import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/eclaim/eclaim_count_model.dart';
import 'package:css_mobile/data/model/eclaim/eclaim_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/eclaim/eclaim_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:css_mobile/util/logger.dart';

class EclaimRepositoryImpl extends EclaimRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<BaseResponse<List<EclaimModel>>> getEclaim(QueryParamModel param) async {
    var token = await storageSecure.read(key: "token");

    if (token != null) {
      network.base.options.headers['Authorization'] = 'Bearer $token';
    }
    try {
      Response response = await network.base.get(
        '/contact-me/e-claims',
        queryParameters: param.toJson(),
      );
      return BaseResponse<List<EclaimModel>>.fromJson(
        response.data,
            (json) => json is List<dynamic>
            ? json
            .map<EclaimModel>(
              (i) => EclaimModel.fromJson(i as Map<String, dynamic>),
            )
            .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.e('error get origin : ${e.response?.data}');
      return BaseResponse<List<EclaimModel>>.fromJson(
        e.response?.data,
            (json) => json is List<dynamic>
            ? json
            .map<EclaimModel>(
              (i) => EclaimModel.fromJson(i as Map<String, dynamic>),
        )
            .toList()
            : List.empty(),
      );
    }
  }

  @override
  Future<BaseResponse<EclaimCountModel>> getEclaimCount(QueryParamModel param) async {
    var token = await storageSecure.read(key: "token");
    // var token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyaWQiOiIyMzEyMjIxNjI1NTAxNTQ1OSIsImlhdCI6MTcwODU4MDg0Mn0.Yc5lrv4gxCeZjfNAmxv6PFehfW6HoZVUZ5IYwuqHK9M';
    network.base.options.headers['Authorization'] = 'Bearer $token';

    try {
      var response = await network.base
          .get("'/contact-me/e-claims'/count",
          queryParameters: param.toJson());
      return BaseResponse<EclaimCountModel>.fromJson(
        response.data,
            (json) => EclaimCountModel.fromJson(
              json as Map<String, dynamic>,
            ),
      );
    } on DioException catch (e) {
      return BaseResponse<EclaimCountModel>.fromJson(
        e.response?.data,
            (json) => EclaimCountModel.fromJson(
        json as Map<String, dynamic>,),
      );
    }
  }
}
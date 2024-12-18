import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_count_model.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_detail_model.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_list_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/pantau_paketmu/pantau_paketmu_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:css_mobile/util/logger.dart';

class PantauPaketmuRepositoryImpl extends PantauPaketmuRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<BaseResponse<List<PantauPaketmuCountModel>>> getPantauCount(
      QueryModel param) async {
    try {
      Response response = await network.base.get(
        '/transaction/tracks/count',
        queryParameters: param.toJson(),
      );
      return BaseResponse<List<PantauPaketmuCountModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<PantauPaketmuCountModel>(
                  (i) => PantauPaketmuCountModel.fromJson(
                      i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.e('error get origin : ${e.response?.data}');
      return BaseResponse<List<PantauPaketmuCountModel>>.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<PantauPaketmuCountModel>(
                  (i) => PantauPaketmuCountModel.fromJson(
                      i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }

  @override
  Future<BaseResponse<List<PantauPaketmuListModel>>> getPantauList(
      QueryModel param) async {
    try {
      Response response = await network.base.get(
        '/transaction/tracks/count/details',
        queryParameters: param.toJson(),
      );
      return BaseResponse<List<PantauPaketmuListModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<PantauPaketmuListModel>(
                  (i) => PantauPaketmuListModel.fromJson(
                      i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.e('error get origin : ${e.response?.data}');
      return BaseResponse<List<PantauPaketmuListModel>>.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<PantauPaketmuListModel>(
                  (i) => PantauPaketmuListModel.fromJson(
                      i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }

  @override
  Future<BaseResponse<PantauPaketmuDetailModel>> getPantauDetail(
      String awb) async {
    try {
      var response = await network.base.get(
        '/transaction/tracks/count/details/$awb',
      );
      return BaseResponse<PantauPaketmuDetailModel>.fromJson(
        response.data,
        (json) => PantauPaketmuDetailModel.fromJson(
          json as Map<String, dynamic>,
        ),
      );
    } on DioException catch (e) {
      AppLogger.e('Error getPantau detail :  ${e.response?.data}');
      return BaseResponse<PantauPaketmuDetailModel>.fromJson(
        e.response?.data,
        (json) => PantauPaketmuDetailModel.fromJson(
          json as Map<String, dynamic>,
        ),
      );
    }
  }

  @override
  Future<BaseResponse<List<String>>> getPantauStatus() async {
    try {
      Response response = await network.base.get(
        "/transaction/tracks/status",
      );
      AppLogger.d("status pantau : ${response.data}");
      return BaseResponse.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<String>(
                  (i) => i as String,
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.e("status pantau : ${e.response?.data}");
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<String>(
                  (i) => i as String,
                )
                .toList()
            : List.empty(),
      );
    }
  }
}

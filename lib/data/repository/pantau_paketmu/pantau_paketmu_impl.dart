import 'package:css_mobile/data/model/base_response_model.dart';
// import 'package:css_mobile/data/model/eclaim/eclaim_count_model.dart';
// import 'package:css_mobile/data/model/eclaim/eclaim_model.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_count_model.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_detail_model.dart';
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
  Future<BaseResponse<List<PantauPaketmuDetailModel>>> getPantauList(
      QueryModel param) async {
    try {
      Response response = await network.base.get(
        '/transaction/tracks/count/details',
        queryParameters: param.toJson(),
      );
      return BaseResponse<List<PantauPaketmuDetailModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<PantauPaketmuDetailModel>(
                  (i) => PantauPaketmuDetailModel.fromJson(
                      i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.e('error get origin : ${e.response?.data}');
      return BaseResponse<List<PantauPaketmuDetailModel>>.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<PantauPaketmuDetailModel>(
                  (i) => PantauPaketmuDetailModel.fromJson(
                      i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }
}

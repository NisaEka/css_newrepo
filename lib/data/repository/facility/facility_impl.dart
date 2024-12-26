import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/facility/facility_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/facility/facility_repository.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class FacilityImpl extends FacilityRepository {
  final network = Get.find<NetworkCore>();
  final storage = Get.find<StorageCore>();

  Future<String> _getLocale() async {
    return await storage.readString(StorageCore.localeApp);
  }

  @override
  Future<BaseResponse<List<FacilityModel>>> getFacilities() async {
    try {
      final locale = await _getLocale();
      var response = await network.base.get(
        "/facilities",
        options: Options(
          headers: {"Accept-Language": locale},
        ),
      );
      return BaseResponse<List<FacilityModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<FacilityModel>(
                  (i) => FacilityModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return BaseResponse<List<FacilityModel>>.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<FacilityModel>(
                  (i) => FacilityModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }

  @override
  Future<BaseResponse<String>> getFacilityTermsAndConditions(
      String type) async {
    try {
      final locale = await _getLocale();
      var response = await network.base.get(
        "/facilities/terms",
        queryParameters: {'type': type},
        options: Options(
          headers: {"Accept-Language": locale},
        ),
      );
      return BaseResponse<String>.fromJson(
        response.data,
        (json) => response.data['data'],
      );
    } on DioException catch (e) {
      AppLogger.d("getFacilityTermsAndConditions error: ${e.response?.data}");
      return BaseResponse<String>.fromJson(
          e.response?.data, (json) => e.response?.data['data']);
    }
  }
}

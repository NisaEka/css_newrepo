import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/facility/facility_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/facility/facility_repository.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class FacilityImpl extends FacilityRepository {
  final network = Get.find<NetworkCore>();
  final storage = Get.find<StorageCore>();

  Future<String> _getLocale() async {
    return await storage.readString(StorageCore.localeApp);
  }

  @override
  Future<DefaultResponseModel<List<FacilityModel>>> getFacilities() async {
    try {
      final locale = await _getLocale();
      var response = await network.base.get(
        "/facilities",
        options: Options(
          headers: {"Accept-Language": locale},
        ),
      );
      List<FacilityModel> facilities = [];
      response.data["data"].forEach((facility) {
        facilities.add(FacilityModel.fromJson(facility));
      });
      return DefaultResponseModel.fromJson(response.data, facilities);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }

  @override
  Future<DefaultResponseModel<String>> getFacilityTermsAndConditions(
      String type) async {
    try {
      final locale = await _getLocale();
      var response = await network.base.get(
        "/facilities/terms",
        queryParameters: {type: type},
        options: Options(
          headers: {"Accept-Language": locale},
        ),
      );
      return DefaultResponseModel.fromJson(
          response.data, response.data['data']);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, '');
    }
  }
}

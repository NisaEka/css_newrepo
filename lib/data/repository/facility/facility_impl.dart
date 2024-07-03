import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/facility/facility_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/facility/facility_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class FacilityImpl extends FacilityRepository {

  final network = Get.find<NetworkCore>();

  @override
  Future<DefaultResponseModel<List<FacilityModel>>> getFacilities() async {
    try {
      var response = await network.dio.get("/facility");
      List<FacilityModel> facilities = [];
      response.data["payload"].forEach((facility) {
        facilities.add(FacilityModel.fromJson(facility));
      });
      return DefaultResponseModel.fromJson(response.data, facilities);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }

  @override
  Future<DefaultResponseModel<String>> getFacilityTermsAndConditions(String type) async {
    try {
      var response = await network.dio.get("/facility/terms", queryParameters: {
        type: type
      });
      return DefaultResponseModel.fromJson(response.data, response.data['payload']);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, '');
    }
  }

}
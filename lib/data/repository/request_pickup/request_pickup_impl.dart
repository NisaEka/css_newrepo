import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_filter_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/request_pickup/request_pickup_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class RequestPickupImpl extends RequestPickupRepository {
  
  final network = Get.find<NetworkCore>();
  
  @override
  Future<DefaultResponseModel<List<RequestPickupModel>>> getRequestPickups(RequestPickupFilterModel filter) async {
    try {
      var response = await network.dio.get("/transaction/pickup", queryParameters: filter.toJson());
      List<RequestPickupModel> requestPickups = [];

      response.data["payload"].forEach((requestPickup) {
        requestPickups.add(RequestPickupModel.fromJson(requestPickup));
      });

      return DefaultResponseModel.fromJson(response.data, requestPickups);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }

}
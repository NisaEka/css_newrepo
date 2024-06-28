import 'package:css_mobile/data/model/default_page_filter_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_create_request_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_create_request_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_detail_model.dart';
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

  @override
  Future<DefaultResponseModel<String>> createRequestPickup(RequestPickupCreateRequestModel createRequest) async {
    try {
      var response = await network.dio.post('/transaction/pickup', data: createRequest.toJson());
      return DefaultResponseModel.fromJson(response.data, '');
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, '');
    }
  }

  @override
  Future<DefaultResponseModel<String>> createRequestPickupAddress(RequestPickupAddressCreateRequestModel createRequest) async {
    try {
      var response = await network.dio.post('/transaction/pickup/address', data: createRequest.toJson());
      return DefaultResponseModel.fromJson(response.data, '');
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, '');
    }
  }

  @override
  Future<DefaultResponseModel<List<String>>> getRequestPickupTypes() async {
     try {
       var response = await network.dio.get('/transaction/pickup/type');
       return DefaultResponseModel.fromJson(response.data, response.data["payload"]);
    } on DioException catch (e) {
       return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }

  @override
  Future<DefaultResponseModel<List<RequestPickupAddressModel>>> getRequestPickupAddresses() async {
     try {
       var response = await network.dio.get('/transaction/pickup/address');
       List<RequestPickupAddressModel> addresses = [];

       response.data['payload'].forEach((address) {
         addresses.add(RequestPickupAddressModel.fromJson(address));
       });

       return DefaultResponseModel.fromJson(response.data, addresses);
    } on DioException catch (e) {
       return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }

  @override
  Future<DefaultResponseModel<RequestPickupDetailModel>> getRequestPickupByAwb(String awb) async {
     try {
       var response = await network.dio.get('/transaction/pickup/$awb');
       RequestPickupDetailModel payload = RequestPickupDetailModel.fromJson(response.data['payload']);
       return DefaultResponseModel.fromJson(response.data, payload);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, null);
    }
  }

  @override
  Future<DefaultResponseModel<List<String>>> getRequestPickupCities(DefaultPageFilterModel filterModel) async {
     try {
       var response = await network.dio.get('/transaction/pickup/city', queryParameters: filterModel.toJson());
       return DefaultResponseModel.fromJson(response.data, response.data['payload']);
    } on DioException catch (e) {
       return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }

  @override
  Future<DefaultResponseModel<List<String>>> getRequestPickupStatuses() async {
     try {
       var response = await network.dio.get('/transaction/pickup/status');
      return DefaultResponseModel.fromJson(response.data, response.data['payload']);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }

}
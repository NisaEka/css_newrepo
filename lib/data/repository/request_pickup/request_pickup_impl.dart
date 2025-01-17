import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_create_request_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_count_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_create_request_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_create_response_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_detail_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/request_pickup/request_pickup_repository.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class RequestPickupImpl extends RequestPickupRepository {
  final network = Get.find<NetworkCore>();

  @override
  Future<BaseResponse<List<RequestPickupCountModel>>> getRequestPickupCount(
      QueryModel param) async {
    AppLogger.i("getRequestPickupCount param: ${param.toJson()}");
    try {
      var response = await network.base
          .get("/transaction/pickups/count", queryParameters: param.toJson());

      AppLogger.i("getRequestPickupCount response: ${response.data}");

      return BaseResponse<List<RequestPickupCountModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<RequestPickupCountModel>(
                  (i) => RequestPickupCountModel.fromJson(
                      i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.i("getRequestPickupCount error: ${e.response?.data}");
      return BaseResponse<List<RequestPickupCountModel>>.fromJson(
          e.response?.data, (json) => List.empty());
    }
  }

  @override
  Future<BaseResponse<List<RequestPickupModel>>> getRequestPickups(
      QueryModel param, String status) async {
    AppLogger.i("getRequestPickups param: ${param.toJson()}");
    try {
      var response = await network.base.get("/transaction/pickups",
          queryParameters: {
            ...param.toJson(),
            if (status != Constant.allStatus) 'status': status
          });

      AppLogger.i("getRequestPickups response: ${response.data}");

      return BaseResponse<List<RequestPickupModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<RequestPickupModel>(
                  (i) => RequestPickupModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.i("getRequestPickups error: ${e.response?.data}");
      return BaseResponse<List<RequestPickupModel>>.fromJson(
          e.response?.data, (json) => List.empty());
    }
  }

  @override
  Future<BaseResponse<RequestPickupCreateResponseModel>> createRequestPickup(
      RequestPickupCreateRequestModel createRequest) async {
    try {
      var response = await network.base
          .post('/transaction/pickups', data: createRequest.toJson());
      return BaseResponse<RequestPickupCreateResponseModel>.fromJson(
        response.data,
        (json) => RequestPickupCreateResponseModel.fromJson(
            json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return BaseResponse<RequestPickupCreateResponseModel>.fromJson(
        e.response?.data,
        (json) => RequestPickupCreateResponseModel.fromJson(
            json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<BaseResponse<String>> createRequestPickupAddress(
      RequestPickupAddressCreateRequestModel createRequest) async {
    try {
      AppLogger.d(
          "createRequestPickupAddress request: ${createRequest.toJson()}");
      var response = await network.base
          .post('/transaction/pickup-datas', data: createRequest.toJson());
      AppLogger.d("createRequestPickupAddress response: ${response.data}");
      return BaseResponse<String>.fromJson(
        response.data,
        (json) => response.data['message'],
      );
    } on DioException catch (e) {
      AppLogger.d("createRequestPickupAddress error: ${e.response?.data}");
      return BaseResponse<String>.fromJson(
          e.response?.data, (json) => e.response?.data['message']);
    }
  }

  @override
  Future<BaseResponse<List<String>>> getRequestPickupTypes() async {
    try {
      var response = await network.base.get('/transaction/pickups/type');
      return BaseResponse<List<String>>.fromJson(
          response.data,
          (json) => json is List<dynamic>
              ? json.map<String>((i) => i as String).toList()
              : List.empty());
    } on DioException catch (e) {
      return BaseResponse<List<String>>.fromJson(
          e.response?.data, (json) => List.empty());
    }
  }

  @override
  Future<BaseResponse<List<RequestPickupAddressModel>>>
      getRequestPickupAddresses(QueryModel param) async {
    try {
      var response = await network.base
          .get('/transaction/pickup-datas', queryParameters: param.toJson());
      return BaseResponse<List<RequestPickupAddressModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<RequestPickupAddressModel>(
                  (i) => RequestPickupAddressModel.fromJson(
                      i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return BaseResponse<List<RequestPickupAddressModel>>.fromJson(
          e.response?.data, (json) => List.empty());
    }
  }

  @override
  Future<BaseResponse<List<DestinationModel>>> getRequestPickupDestinations(
      QueryModel param) async {
    try {
      var response = await network.base.get('/transaction/pickups/destination',
          queryParameters: param.toJson());
      AppLogger.d("getRequestPickupDestinations response: ${response.data}");
      return BaseResponse<List<DestinationModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<DestinationModel>(
                  (i) => DestinationModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return BaseResponse<List<DestinationModel>>.fromJson(
          e.response?.data, (json) => List.empty());
    }
  }

  @override
  Future<BaseResponse<RequestPickupDetailModel>> getRequestPickupByAwb(
      String awb) async {
    try {
      var response = await network.base.get('/transaction/pickups/$awb');
      return BaseResponse<RequestPickupDetailModel>.fromJson(
        response.data,
        (json) =>
            RequestPickupDetailModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return BaseResponse<RequestPickupDetailModel>.fromJson(
        e.response?.data,
        (json) =>
            RequestPickupDetailModel.fromJson(json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<BaseResponse<List<OriginModel>>> getRequestPickupOrigins(
      QueryModel param) async {
    try {
      var response = await network.base
          .get('/transaction/pickups/origin', queryParameters: param.toJson());
      return BaseResponse<List<OriginModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<OriginModel>(
                  (i) => OriginModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return BaseResponse<List<OriginModel>>.fromJson(
          e.response?.data, (json) => List.empty());
    }
  }

  @override
  Future<BaseResponse<List<String>>> getRequestPickupStatuses() async {
    try {
      var response = await network.base.get('/transaction/pickups/status');
      return BaseResponse<List<String>>.fromJson(
          response.data,
          (json) => json is List<dynamic>
              ? json.map<String>((i) => i as String).toList()
              : List.empty());
    } on DioException catch (e) {
      return BaseResponse<List<String>>.fromJson(
          e.response?.data, (json) => List.empty());
    }
  }
}

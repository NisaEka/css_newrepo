import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
// import 'package:css_mobile/data/model/default_page_filter_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_create_request_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_count_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_create_request_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_create_response_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_detail_model.dart';
// import 'package:css_mobile/data/model/request_pickup/request_pickup_filter_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';

abstract class RequestPickupRepository {
  Future<BaseResponse<List<RequestPickupCountModel>>> getRequestPickupCount(
      QueryModel param);
  Future<BaseResponse<List<RequestPickupModel>>> getRequestPickups(
      QueryModel param, String status);
  Future<BaseResponse<RequestPickupCreateResponseModel>> createRequestPickup(
      RequestPickupCreateRequestModel createRequest);
  Future<BaseResponse<List<RequestPickupAddressModel>>>
      getRequestPickupAddresses(QueryModel param);
  Future<BaseResponse<List<Destination>>> getRequestPickupDestinations(
      QueryModel param);
  Future<BaseResponse<String>> createRequestPickupAddress(
      RequestPickupAddressCreateRequestModel createRequest);
  Future<BaseResponse<List<OriginModel>>> getRequestPickupOrigins(
      QueryModel param);
  Future<BaseResponse<List<String>>> getRequestPickupStatuses();
  Future<BaseResponse<List<String>>> getRequestPickupTypes();
  Future<BaseResponse<RequestPickupDetailModel>> getRequestPickupByAwb(
      String awb);
}

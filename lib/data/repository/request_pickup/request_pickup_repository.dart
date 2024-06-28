import 'package:css_mobile/data/model/default_page_filter_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_create_request_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_create_request_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_detail_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_filter_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';

abstract class RequestPickupRepository {
  Future<DefaultResponseModel<List<RequestPickupModel>>> getRequestPickups(RequestPickupFilterModel filter);
  Future<DefaultResponseModel<String>> createRequestPickup(RequestPickupCreateRequestModel createRequest);
  Future<DefaultResponseModel<List<RequestPickupAddressModel>>> getRequestPickupAddresses();
  Future<DefaultResponseModel<String>> createRequestPickupAddress(RequestPickupAddressCreateRequestModel createRequest);
  Future<DefaultResponseModel<List<String>>> getRequestPickupCities(DefaultPageFilterModel filterModel);
  Future<DefaultResponseModel<List<String>>> getRequestPickupStatuses();
  Future<DefaultResponseModel<List<String>>> getRequestPickupTypes();
  Future<DefaultResponseModel<RequestPickupDetailModel>> getRequestPickupByAwb(String awb);
}
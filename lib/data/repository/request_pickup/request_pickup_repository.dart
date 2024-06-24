import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_filter_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';

abstract class RequestPickupRepository {
  Future<DefaultResponseModel<List<RequestPickupModel>>> getRequestPickups(RequestPickupFilterModel filter);
}
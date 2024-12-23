import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/facility/facility_model.dart';

abstract class FacilityRepository {
  Future<BaseResponse<List<FacilityModel>>> getFacilities();
  Future<BaseResponse<String>> getFacilityTermsAndConditions(String type);
}

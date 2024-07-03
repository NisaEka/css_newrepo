import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/facility/facility_model.dart';

abstract class FacilityRepository {
  Future<DefaultResponseModel<List<FacilityModel>>> getFacilities();
  Future<DefaultResponseModel<String>> getFacilityTermsAndConditions(String type);
}
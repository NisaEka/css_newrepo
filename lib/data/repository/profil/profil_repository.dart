import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_existing_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_activity_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_model.dart';

abstract class ProfilRepository {
  Future<BaseResponse<BasicProfileModel>> getBasicProfil();

  Future<BaseResponse<CcrfProfileModel>> getCcrfProfil();

  Future<BaseResponse> putProfileCCRF(GeneralInfo data);

  Future<DefaultResponseModel<String>> createProfileCcrf(
      FacilityCreateModel data);

  Future<DefaultResponseModel<String>> createProfileCcrfExisting(
      FacilityCreateExistingModel data);

  Future<BaseResponse<List<CcrfActivityModel>>> getCcrfActivity(
      QueryParamModel param);

  Future<BaseResponse> putProfileBasic(UserModel data);

  Future<BaseResponse<List<ShipperModel>>>  getShipper();
}

import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_existing_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/data/model/profile/get_basic_profil_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_activity_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_profil_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_model.dart';

abstract class ProfilRepository {
  Future<GetBasicProfilModel> getBasicProfil();

  Future<GetCcrfProfilModel> getCcrfProfil();

  Future<PostTransactionModel> putProfileCCRF(GeneralInfo data);

  Future<DefaultResponseModel<String>> createProfileCcrf(FacilityCreateModel data);

  Future<DefaultResponseModel<String>> createProfileCcrfExisting(FacilityCreateExistingModel data);

  Future<GetCcrfActivityModel> getCcrfActivity();

  Future putProfileBasic(BasicProfilModel data);
}

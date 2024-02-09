import 'package:css_mobile/data/model/profile/get_basic_profil_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_profil_model.dart';

abstract class ProfilRepository {
  Future<GetBasicProfilModel> getBasicProfil();
  Future<GetCcrfProfilModel> getCcrfProfil();
}

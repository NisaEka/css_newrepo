import 'package:css_mobile/data/model/pengaturan/data_petugas_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_model.dart';

abstract class PengaturanRepository {
  Future<GetPetugasModel> getOfficer(int page, String keyword);

  Future<GetPetugasByidModel> getOfficerByID(String id);

  Future<PostTransactionModel> postOfficer(DataPetugasModel data);

  Future<PostTransactionModel> deleteOfficer(String id);

  Future<PostTransactionModel> putOfficer(DataPetugasModel data);
}

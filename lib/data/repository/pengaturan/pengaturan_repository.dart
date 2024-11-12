import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/dashboard/sticker_label_model.dart';
import 'package:css_mobile/data/model/pengaturan/data_petugas_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_model.dart';

abstract class PengaturanRepository {
  Future<BaseResponse<List<PetugasModel>>> getOfficer(int page, String keyword);

  Future<BaseResponse<PetugasModel>> getOfficerByID(String id);

  Future<BaseResponse> postOfficer(DataPetugasModel data);

  Future<PostTransactionModel> deleteOfficer(String id);

  Future<BaseResponse> putOfficer(DataPetugasModel data);

  Future<BaseResponse<List<StickerLabelModel>>> getSettingLabel();

  Future<BaseResponse> updateSettingLabel(String label, int price);
}

import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_count_model.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_detail_model.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_list_model.dart';
import 'package:css_mobile/data/model/query_model.dart';

abstract class PantauPaketmuRepository {
  Future<BaseResponse<List<PantauPaketmuCountModel>>> getPantauCount(
      QueryModel param);

  Future<BaseResponse<List<PantauPaketmuListModel>>> getPantauList(
      QueryModel param);

  Future<BaseResponse<PantauPaketmuDetailModel>> getPantauDetail(String awb);

  Future<BaseResponse<List<String>>> getPantauStatus();
}

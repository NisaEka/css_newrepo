import 'package:css_mobile/data/model/pantau/get_pantau_paketmu_model.dart';
import 'package:css_mobile/data/model/response_model.dart';

abstract class PantauRepository {
  Future<GetPantauPaketmuModel> getPantauList(
    int page,
    int limit,
    String date,
    String keyword,
    String officer,
    String status,
    String type,
  );

  Future<ResponseModel<List<String>>> getPantauStatus();
}

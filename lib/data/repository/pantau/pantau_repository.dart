import 'package:css_mobile/data/model/pantau/get_pantau_paketmu_model.dart';

abstract class PantauRepository {
  Future<GetPantauPaketmuModel> getPantauList(
    int page,
    int limit,
    String transType,
    String transDate,
    String transStatus,
    String keyword,
    String officer,
  );
}

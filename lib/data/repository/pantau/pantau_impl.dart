import 'package:css_mobile/data/model/pantau/get_pantau_paketmu_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/pantau/pantau_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class PantauRepositoryImpl extends PantauRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<GetPantauPaketmuModel> getPantauList(
    int page,
    int limit,
    String date,
    String keyword,
    String officer,
    String status,
  ) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.dio.get(
        "/pantau",
        queryParameters: {
          "page": page,
          "limit": limit,
          "keyword": keyword.toUpperCase(),
          "date": date,
          "officer_entry": officer,
          "status": status,
        },
      );
      return GetPantauPaketmuModel.fromJson(response.data);
    } on DioException catch (e) {
      e.printError();
      e.response?.data.printError(info: "pantau error");
      return GetPantauPaketmuModel.fromJson(e.response?.data);
    }
  }
}

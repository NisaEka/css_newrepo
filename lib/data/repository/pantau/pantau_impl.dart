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
    String transType,
    String transDate,
    String transStatus,
    String keyword,
    String officer,
  ) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    network.local.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.local.get(
        "/pantau",
        queryParameters: {
          "page": page,
          "limit": limit,
          "keyword": keyword,
        },
      );

      return GetPantauPaketmuModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetPantauPaketmuModel.fromJson(e.response?.data);
    }
  }
}

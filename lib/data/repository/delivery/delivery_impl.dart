import 'package:css_mobile/data/model/delivery/get_account_number_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/delivery/delivery_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class DeliveryRepositoryImpl extends DeliveryRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<GetAccountNumberModel> getAccountNumber() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/account",
      );
      return GetAccountNumberModel.fromJson(response.data);
    } on DioError catch (e) {
      //print("response error: ${e.response?.data}");
      return e.error;
    }
  }
}

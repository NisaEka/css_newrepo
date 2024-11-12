import 'package:css_mobile/data/model/cek_ongkir/post_cekongkir_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/cek_ongkir/cek_ongkir_repository.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class CekOngkirRepositoryImpl extends CekOngkirRepository {
  final network = Get.find<NetworkCore>();

  @override
  Future<PostCekongkirModel> postCekOngkir(
    String from,
    String to,
    String weight,
  ) async {
    try {
      String url =
          '/transaction/fees/external?originCode=$from&destinationCode=$to';

      // Append the weight parameter if it's not empty
      if (weight.isNotEmpty) {
        url += '&weight=$weight';
      }

      Response response = await network.base.get(url);
      return PostCekongkirModel.fromJson(response.data);
    } on DioException catch (e) {
      AppLogger.e('error: ${e.message}');
      return e.response?.data;
    }
  }
}

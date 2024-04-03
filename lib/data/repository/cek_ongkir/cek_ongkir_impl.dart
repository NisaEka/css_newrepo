import 'package:css_mobile/config/api_config.dart';
import 'package:css_mobile/data/model/cek_ongkir/post_cekongkir_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/cek_ongkir/cek_ongkir_repository.dart';
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
      Response response = await network.jne.post('/pricedev',
          data: {
            'username': ApiConfig.username,
            'api_key': ApiConfig.apikey,
            'from': from,
            'thru': to,
            'weight': weight,
          },
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
          ));
      return PostCekongkirModel.fromJson(response.data);
    } on DioException catch (e) {
      print('error ongkir : ${e.response?.data.printError}');
      // return PostCekongkirModel.fromJson(e.response?.data);
      return e.response?.data;
    }
  }

  @override
  Future<GetOriginModel> postDestination(String keyword) async {
    try {
      // Response response = await network.city.post(
      // '/dest/key/$keyword',
      // data: {
      // 'username': ApiConfig.ctUsername,
      // 'api_key': ApiConfig.ctApiKey,
      // },
      // );
      Response response = await network.dio.get(
        '/destination/tracing',
        queryParameters: {
          'keyword': keyword,
        },
      );
      return GetOriginModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetOriginModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetOriginModel> postOrigin(String keyword) async {
    try {
      Response response = await network.dio.get(
        '/origin/tracing',
        queryParameters: {
          'keyword': keyword,
        },
      );
      return GetOriginModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetOriginModel.fromJson(e.response?.data);
    }
  }
}

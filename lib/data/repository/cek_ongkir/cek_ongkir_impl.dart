import 'package:css_mobile/config/api_config.dart';
import 'package:css_mobile/data/model/cek_ongkir/post_cekongkir_city_model.dart';
import 'package:css_mobile/data/model/cek_ongkir/post_cekongkir_model.dart';
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
      Response response = await network.jne.post(
        '/pricedev',
        data: {
          'username': ApiConfig.username,
          'api_key': ApiConfig.apikey,
          'from': from,
          'thru': to,
          'weight': weight,
        },
      );
      return PostCekongkirModel.fromJson(response.data);
    } on DioError catch (e) {
      return PostCekongkirModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostCekongkirCityModel> postDestination(String keyword) async {
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
      return PostCekongkirCityModel.fromJson(response.data);
    } on DioError catch (e) {
      print("error ${e.response?.data}");
      return PostCekongkirCityModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostCekongkirCityModel> postOrigin(String keyword) async {
    try {
      // Response response = await network.city.post(
      //   '/orig/key/$keyword',
      //   data: {
      //     'username': ApiConfig.ctUsername,
      //     'api_key': ApiConfig.ctApiKey,
      //   },
      // );
      // print(' origin ${response.data}');
      Response response = await network.dio.get(
        '/origin/tracing',
        queryParameters: {
          'keyword': keyword,
        },
      );
      return PostCekongkirCityModel.fromJson(response.data);
    } on DioError catch (e) {
      print('error origin ${e.response?.data}');
      return PostCekongkirCityModel.fromJson(e.response?.data);
    }
  }
}

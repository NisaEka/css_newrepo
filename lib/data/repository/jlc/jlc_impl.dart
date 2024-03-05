import 'package:css_mobile/config/api_config.dart';
import 'package:css_mobile/data/model/jlc/post_total_point_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/jlc/jlc_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class JLCRepositoryImpl extends JLCRepository {
  final network = Get.find<NetworkCore>();

  @override
  Future<PostTotalPointModel> postTotalPoint() async {
    try {
      Response response = await network.myJNE.post(
        '/jlctotalpoint',
        data: {
          'username': ApiConfig.jlcUsername,
          'api_key': ApiConfig.jlcAPIKEY,
          'id_member': '1183344222',
        },
      );
      return PostTotalPointModel.fromJson(response.data);
    } on DioError catch (e) {
      return PostTotalPointModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostTotalPointModel> postTransPoint() async {
    try {
      Response response = await network.myJNE.post(
        '/jlctranspoint',
        data: {
          'username': ApiConfig.jlcUsername,
          'api_key': ApiConfig.jlcAPIKEY,
          'id_member': '1183344222',
        },
      );
      return PostTotalPointModel.fromJson(response.data);
    } on DioError catch (e) {
      return PostTotalPointModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostTotalPointModel> postTukarPoint() async {
    try {
      Response response = await network.myJNE.post(
        '/jlctukarpoint',
        data: {
          'username': ApiConfig.jlcUsername,
          'api_key': ApiConfig.jlcAPIKEY,
          'id_member': '1183344222',
        },
      );
      return PostTotalPointModel.fromJson(response.data);
    } on DioError catch (e) {
      return PostTotalPointModel.fromJson(e.response?.data);
    }
  }
}

import 'package:css_mobile/config/api_config.dart';
import 'package:css_mobile/data/model/lacak_kiriman/post_lacak_kiriman_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/lacak_kiriman/lacak_kiriman_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class LacakKirimanRepositoryImpl extends LacakKirimanRepository {
  final network = Get.find<NetworkCore>();

  @override
  Future<PostLacakKirimanModel> postTracingByCnote(String cnote) async {
    try {
      Response response = await network.jne.post(
        '/list/v1/cnote/$cnote',
        data: {
          'username': ApiConfig.traceUsername,
          'api_key': ApiConfig.traceApikey,
        },
      );
      print(response.data);
      return PostLacakKirimanModel.fromJson(response.data);
    } on DioError catch (e) {
      return PostLacakKirimanModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostLacakKirimanModel> postTracingByReference(String referenceNumber) async {
    try {
      Response response = await network.city.post(
        '/v2/refrencenumber',
        data: {
          'username': ApiConfig.username,
          'api_key': ApiConfig.apikey,
          'reference_number': referenceNumber,
        },
      );
      return PostLacakKirimanModel.fromJson(response.data);
    } on DioError catch (e) {
      return PostLacakKirimanModel.fromJson(e.response?.data);
    }
  }
}

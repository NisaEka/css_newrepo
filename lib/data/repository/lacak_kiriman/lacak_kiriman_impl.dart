import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/lacak_kiriman/post_lacak_kiriman_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/lacak_kiriman/lacak_kiriman_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class LacakKirimanRepositoryImpl extends LacakKirimanRepository {
  final network = Get.find<NetworkCore>();

  @override
  Future<BaseResponse<PostLacakKirimanModel>> postTracingByCnote(
      String cnote, String pin) async {
    try {
      Response response = await network.base
          .post('/transaction/traces', data: {'awb': cnote, 'pin': pin});
      return BaseResponse.fromJson(
          response.data,
          (json) => PostLacakKirimanModel.fromJson(
                json as Map<String, dynamic>,
              ));
    } on DioException catch (e) {
      return BaseResponse.fromJson(
          e.response?.data,
          (json) => PostLacakKirimanModel.fromJson(
                json as Map<String, dynamic>,
              ));
    }
  }
}

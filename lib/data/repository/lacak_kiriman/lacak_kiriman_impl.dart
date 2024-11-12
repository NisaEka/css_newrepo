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
      Response response = await network.base.get('/transaction/traces/$cnote');
      return PostLacakKirimanModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      return PostLacakKirimanModel.fromJson(e.response?.data);
    }
  }
}

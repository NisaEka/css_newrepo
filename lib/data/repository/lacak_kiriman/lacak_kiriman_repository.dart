import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/lacak_kiriman/post_lacak_kiriman_model.dart';

abstract class LacakKirimanRepository {
  Future<BaseResponse<PostLacakKirimanModel>> postTracingByCnote(String cnote);
  Future<BaseResponse<PostLacakKirimanModel>> postTracingByCnotePublic(
      String cnote, String phoneNumber);
}

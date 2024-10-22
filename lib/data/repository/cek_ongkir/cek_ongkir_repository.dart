import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/cek_ongkir/post_cekongkir_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';

abstract class CekOngkirRepository {
  Future<PostCekongkirModel> postCekOngkir(
    String from,
    String to,
    String weight,
  );
}

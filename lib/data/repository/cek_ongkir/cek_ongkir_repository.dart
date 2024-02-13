import 'package:css_mobile/data/model/cek_ongkir/post_cekongkir_city_model.dart';
import 'package:css_mobile/data/model/cek_ongkir/post_cekongkir_model.dart';

abstract class CekOngkirRepository {
  Future<PostCekongkirModel> postCekOngkir(
    String from,
    String to,
    String weight,
  );

  Future<PostCekongkirCityModel> postDestination(String keyword);

  Future<PostCekongkirCityModel> postOrigin(String keyword);
}

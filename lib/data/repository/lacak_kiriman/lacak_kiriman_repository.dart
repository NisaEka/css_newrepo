import 'package:css_mobile/data/model/lacak_kiriman/post_lacak_kiriman_model.dart';

abstract class LacakKirimanRepository {
  Future<PostLacakKirimanModel> postTracingByCnote(String cnote);

  Future<PostLacakKirimanModel> postTracingByReference(String referenceNumber);
}

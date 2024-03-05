import 'package:css_mobile/data/model/jlc/post_total_point_model.dart';

abstract class JLCRepository {
  Future<PostTotalPointModel> postTotalPoint();

  Future<PostTotalPointModel> postTukarPoint();

  Future<PostTotalPointModel> postTransPoint();
}

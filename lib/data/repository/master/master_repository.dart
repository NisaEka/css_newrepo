import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/group_owner_model.dart';

abstract class MasterRepository {
  Future<BaseResponse<List<Origin>>> getOrigins(String keyword);

  Future<BaseResponse<List<GroupOwnerModel>>> getReferals(String keyword);
}

import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_agent_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/group_owner_model.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';

abstract class MasterRepository {
  Future<BaseResponse<List<Origin>>> getOrigins(String keyword);

  Future<BaseResponse<List<Destination>>> getDestinations(String keyword);

  Future<BaseResponse<List<GroupOwnerModel>>> getReferals(String keyword);

  Future<BaseResponse<List<AgentModel>>> getAgents(String branch);

  Future<BaseResponse<List<DropshipperModel>>> getDropshippers();

  Future<BaseResponse<List<ReceiverModel>>> getReceivers();
}

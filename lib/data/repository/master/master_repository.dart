import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_agent_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_service_model.dart';
import 'package:css_mobile/data/model/master/group_owner_model.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_branch_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/transaction/data_service_model.dart';

abstract class MasterRepository {
  Future<BaseResponse<List<Origin>>> getOrigins(QueryParamModel param);

  Future<BaseResponse<List<Destination>>> getDestinations(
      QueryParamModel param);

  Future<BaseResponse<List<BranchModel>>> getBranches();

  Future<BaseResponse<List<GroupOwnerModel>>> getReferals(String keyword);

  Future<BaseResponse<List<AgentModel>>> getAgents(String branch);

  Future<BaseResponse<List<DropshipperModel>>> getDropshippers(
      QueryParamModel param);

  Future<BaseResponse> deleteDropshipper(String id);

  Future<BaseResponse> postDropshipper(DropshipperModel data);

  Future<BaseResponse<List<ReceiverModel>>> getReceivers(QueryParamModel param);

  Future<BaseResponse> deleteReceiver(String id);

  Future<BaseResponse> postReceiver(ReceiverModel data);

  Future<BaseResponse<List<Account>>> getAccounts();

  Future<BaseResponse<List<ServiceModel>>> getServices(DataServiceModel param);
}

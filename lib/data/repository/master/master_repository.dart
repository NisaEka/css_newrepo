import 'package:css_mobile/data/model/master/apps_info_model.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_agent_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_branch_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_service_model.dart';
import 'package:css_mobile/data/model/master/group_owner_model.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/master/vehicle_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/model/transaction/data_service_model.dart';

abstract class MasterRepository {
  Future<BaseResponse<List<OriginModel>>> getOrigins(QueryModel param);

  Future<BaseResponse<List<DestinationModel>>> getDestinations(
      QueryModel param);

  Future<BaseResponse<List<BranchModel>>> getBranches(QueryModel param);

  Future<BaseResponse<List<GroupOwnerModel>>> getReferals(String keyword);

  Future<BaseResponse<List<AgentModel>>> getAgents(String branch);

  Future<BaseResponse<List<DropshipperModel>>> getDropshippers(
      QueryModel param);

  Future<BaseResponse> deleteDropshipper(String id);

  Future<BaseResponse> postDropshipper(DropshipperModel data);

  Future<BaseResponse<List<ReceiverModel>>> getReceivers(QueryModel param);

  Future<BaseResponse> deleteReceiver(String id);

  Future<BaseResponse> postReceiver(ReceiverModel data);

  Future<BaseResponse<List<TransAccountModel>>> getAccounts(QueryModel param);

  Future<BaseResponse<int>> getAccountCount(QueryModel countQuery);

  Future<BaseResponse<TransServiceModel>> getServices(DataServiceModel param);

  Future<BaseResponse<List<AppsInfoModel>>> getAppsInfo(QueryModel param);

  Future<BaseResponse<List<VehicleModel>>> getVehicles();
}

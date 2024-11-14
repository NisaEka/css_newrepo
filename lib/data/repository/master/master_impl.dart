import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_agent_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_service_model.dart';
import 'package:css_mobile/data/model/master/group_owner_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_branch_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/transaction/data_service_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:css_mobile/util/logger.dart';

import 'master_repository.dart';

class MasterRepositoryImpl extends MasterRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<BaseResponse<List<Origin>>> getOrigins(QueryParamModel param) async {
    var token = await storageSecure.read(key: "token");

    if (token != null) {
      network.base.options.headers['Authorization'] = 'Bearer $token';
    }
    try {
      Response response = await network.base.get(
        '/master/origins',
        queryParameters: param.toJson(),
      );
      return BaseResponse<List<Origin>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<Origin>(
                  (i) => Origin.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.e('error get origin : ${e.response?.data}');
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse<List<Destination>>> getDestinations(
      QueryParamModel param) async {
    try {
      Response response = await network.base.get(
        '/master/destinations',
        queryParameters: param.toJson(),
      );
      return BaseResponse<List<Destination>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<Destination>(
                  (i) => Destination.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse<List<BranchModel>>> getBranches() async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.get(
        "/master/branches",
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<BranchModel>(
                  (i) => BranchModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse<List<GroupOwnerModel>>> getReferals(
      String keyword) async {
    try {
      Response response = await network.base.get(
        '/master/group-owners',
        queryParameters: {
          'search': keyword.toUpperCase(),
        },
      );
      return BaseResponse<List<GroupOwnerModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<GroupOwnerModel>(
                  (i) => GroupOwnerModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse<List<AgentModel>>> getAgents(String branch) async {
    try {
      Response response = await network.base.get(
        '/master/agents',
        queryParameters: {
          'branch': branch.toUpperCase(),
        },
      );
      return BaseResponse<List<AgentModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<AgentModel>(
                  (i) => AgentModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse<List<DropshipperModel>>> getDropshippers(
      QueryParamModel param) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';

    UserModel user = UserModel.fromJson(
      await StorageCore().readData(StorageCore.basicProfile),
    );
    String registID = '[{"registrationId" : "${user.id}"}]';
    QueryParamModel params = param.copyWith(where: registID, table: true);

    try {
      Response response = await network.base.get(
        '/master/dropshippers',
        queryParameters: params.toJson(),
      );
      return BaseResponse<List<DropshipperModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<DropshipperModel>(
                  (i) => DropshipperModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse> deleteDropshipper(String id) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.delete(
        "/master/dropshippers/$id",
        queryParameters: {
          'permanent': true,
        },
      );
      return BaseResponse.fromJson(response.data, (json) => null);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse> postDropshipper(DropshipperModel data) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    UserModel user = UserModel.fromJson(
      await StorageCore().readData(StorageCore.basicProfile),
    );

    try {
      Response response = await network.base.post(
        "/master/dropshippers",
        data: data.copyWith(
          registrationId: user.id,
          createdDate: DateTime.now().toString(),
        ),
      );
      return BaseResponse.fromJson(response.data, (json) => null);
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => null,
      );
    }
  }

  @override
  Future<BaseResponse<List<ReceiverModel>>> getReceivers(
      QueryParamModel param) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';

    UserModel user = UserModel.fromJson(
      await StorageCore().readData(StorageCore.basicProfile),
    );
    String registID = '[{"registrationId" : "${user.id}"}]';
    QueryParamModel params = param.copyWith(where: registID, table: true);

    try {
      Response response = await network.base.get(
        '/master/receivers',
        queryParameters: params.toJson(),
      );
      return BaseResponse<List<ReceiverModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<ReceiverModel>(
                  (i) => ReceiverModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse> deleteReceiver(String id) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.delete(
        "/master/receivers/$id",
        queryParameters: {
          'permanent': true,
        },
      );
      return BaseResponse.fromJson(response.data, (json) => null);
    } on DioException catch (e) {
      AppLogger.e('delete receiver error : ${e.response?.data}');
      return BaseResponse.fromJson(e.response?.data, (json) => null);
    }
  }

  @override
  Future<BaseResponse> postReceiver(ReceiverModel data) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';

    UserModel user = UserModel.fromJson(
      await StorageCore().readData(StorageCore.basicProfile),
    );

    try {
      Response response = await network.base.post(
        "/master/receivers",
        data: data.copyWith(registrationId: user.id),
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => json,
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => null,
      );
    }
  }

  @override
  Future<BaseResponse<List<Account>>> getAccounts() async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.get(
        '/accounts',
      );
      return BaseResponse<List<Account>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<Account>(
                  (i) => Account.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse<List<ServiceModel>>> getServices(
      DataServiceModel param) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.get(
        "/transaction/fees",
        queryParameters: param.toJson(),
      );

      return BaseResponse<List<ServiceModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<ServiceModel>(
                  (i) => ServiceModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return BaseResponse<List<ServiceModel>>.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<ServiceModel>(
                  (i) => ServiceModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }
}

import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_agent_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/group_owner_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import 'master_repository.dart';

class MasterRepositoryImpl extends MasterRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<BaseResponse<List<Origin>>> getOrigins(String keyword) async {
    try {
      Response response = await network.base.get(
        '/master/origins',
        queryParameters: {
          'search': keyword.toUpperCase(),
        },
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
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse<List<Destination>>> getDestinations(String keyword) async {
    try {
      Response response = await network.base.get(
        '/master/destinations',
        queryParameters: {
          'search': keyword.toUpperCase(),
        },
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
  Future<BaseResponse<List<GroupOwnerModel>>> getReferals(String keyword) async {
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
  Future<BaseResponse<List<DropshipperModel>>> getDropshippers() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';

    UserModel user = UserModel.fromJson(
      await StorageCore().readData(StorageCore.userProfil),
    );
    String registID = '{"registrationId" : "${user.id}"}';

    try {
      Response response = await network.base.get(
        '/master/dropshippers',
        queryParameters: QueryParamModel(
          where: registID,
        ).toJson(),
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
  Future<BaseResponse<List<ReceiverModel>>> getReceivers() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';

    UserModel user = UserModel.fromJson(
      await StorageCore().readData(StorageCore.userProfil),
    );
    String registID = '{"registrationId" : "${user.id}"}';

    try {
      Response response = await network.base.get(
        '/master/receivers',
        queryParameters: QueryParamModel(
          where: registID,
        ).toJson(),
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
}

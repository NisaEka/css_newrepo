import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/group_owner_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import 'master_repository.dart';

class MasterRepositoryImpl extends MasterRepository {
  final network = Get.find<NetworkCore>();

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
}

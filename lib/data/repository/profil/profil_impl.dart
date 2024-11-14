import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_existing_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_activity_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/profil/profil_repository.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class ProfilRepositoryImpl extends ProfilRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<BaseResponse<UserProfileModel>> getBasicProfil() async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.get(
        "/me",
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => UserProfileModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => UserProfileModel.fromJson(json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<BaseResponse<CcrfProfileModel>> getCcrfProfil() async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.get(
        "/me/ccrf",
      );
      return BaseResponse<CcrfProfileModel>.fromJson(
        response.data,
        (json) => CcrfProfileModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      AppLogger.e("ccrf error : ${e.response?.data}");
      return BaseResponse<CcrfProfileModel>.fromJson(
        e.response?.data,
        (json) => CcrfProfileModel.fromJson(json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<BaseResponse> putProfileCCRF(GeneralInfo data) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.put(
        "/me/ccrf",
        data: data,
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => null,
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<DefaultResponseModel<String>> createProfileCcrf(FacilityCreateModel data) async {
    var token = await storageSecure.read(key: 'token');
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      var response = await network.dio.post('/profile/ccrf', data: data.toJson());
      return DefaultResponseModel.fromJson(response.data, '');
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, '');
    }
  }

  @override
  Future<DefaultResponseModel<String>> createProfileCcrfExisting(FacilityCreateExistingModel data) async {
    var token = await storageSecure.read(key: 'token');
    network.dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      var response = await network.dio.post('/profile/ccrf/existing', data: data.toJson());
      return DefaultResponseModel.fromJson(response.data, '');
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, '');
    }
  }

  @override
  Future<BaseResponse<List<CcrfActivityModel>>> getCcrfActivity(QueryParamModel param) async {
    var token = await storageSecure.read(key: 'token');
    network.base.options.headers['Authorization'] = 'Bearer $token';

    try {
      var response = await network.base.get(
        '/master/ccrf-activities',
        queryParameters: param.toJson(),
      );
      return BaseResponse<List<CcrfActivityModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<CcrfActivityModel>(
                  (i) => CcrfActivityModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return BaseResponse<List<CcrfActivityModel>>.fromJson(e.response?.data, (json) => List.empty());
    }
  }

  @override
  Future<BaseResponse> putProfileBasic(UserModel data) async {
    var token = await storageSecure.read(key: "token");
    UserModel user = UserModel.fromJson(await StorageCore().readData(StorageCore.basicProfile));

    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.patch(
        "/me",
        data: {
          "brand": data.brand,
          "name": data.name,
          "phone": data.phone,
          "address": data.address,
          "origin": data.origin?.originCode ?? user.origin?.originCode,
          "zipCode": data.zipCode,
          "language": data.language,
        },
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => null,
      );
    } on DioException catch (e) {
      print('update profile error : ${e.response?.data}');
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse<List<ShipperModel>>> getShipper() async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.get(
        "/me/shipper",
      );
      return BaseResponse<List<ShipperModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<ShipperModel>(
                  (i) => ShipperModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.e("shipper error : ${e.response?.data}");
      return e.response?.data;
    }
  }
}

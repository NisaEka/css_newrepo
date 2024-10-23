import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_existing_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_activity_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/profil/profil_repository.dart';
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
      print("ccrf error : ${e.response?.data}");
      return e.response?.data;
    }
  }

  @override
  Future<PostTransactionModel> putProfileCCRF(GeneralInfo data) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.put(
        "/profile/ccrf",
        data: data,
      );
      return PostTransactionModel.fromJson(response.data);
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
  Future<GetCcrfActivityModel> getCcrfActivity() async {
    var token = await storageSecure.read(key: 'token');
    network.dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      var response = await network.dio.get(
        '/ccrf-activity',
      );
      return GetCcrfActivityModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetCcrfActivityModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<BaseResponse> putProfileBasic(UserModel data) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.patch(
        "/me",
        data: {
          "brand": data.brand,
          "name": data.name,
          "phone": data.phone,
          "address": data.address,
          "origin_code": data.origin?.originCode,
          "zip_code": data.zipCode
        },
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => null,
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}

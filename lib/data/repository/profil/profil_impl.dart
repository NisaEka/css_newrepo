import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_existing_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/data/model/profile/get_basic_profil_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_activity_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_profil_model.dart';
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
  Future<GetBasicProfilModel> getBasicProfil() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/profile",
      );
      return GetBasicProfilModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<GetCcrfProfilModel> getCcrfProfil() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/profile/ccrf",
      );
      return GetCcrfProfilModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetCcrfProfilModel.fromJson(e.response?.data);
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
}

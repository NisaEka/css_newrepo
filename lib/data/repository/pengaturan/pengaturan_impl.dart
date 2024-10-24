import 'package:css_mobile/data/model/pengaturan/data_petugas_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_branch_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_setting_label_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/pengaturan/pengaturan_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class PengaturanRepositoryImpl extends PengaturanRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<GetPetugasModel> getOfficer(int page, String keyword) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/officer",
        queryParameters: {
          "keyword": keyword,
          "page": page,
          "limit": 10,
        },
      );
      return GetPetugasModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<PostTransactionModel> deleteOfficer(String id) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.delete(
        "/officer/$id",
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<GetPetugasByidModel> getOfficerByID(String id) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/officer/$id",
      );
      return GetPetugasByidModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<PostTransactionModel> postOfficer(DataPetugasModel data) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.post(
        "/officer",
        data: data,
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostTransactionModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostTransactionModel> putOfficer(DataPetugasModel data) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    data.toJson().printInfo(info: "kiriman data");
    try {
      Response response = await network.dio.put(
        "/officer/${data.id}",
        data: data,
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<GetBranchModel> getBranch() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/branch",
      );
      return GetBranchModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }



  @override
  Future<GetSettingLabelModel> getSettingLabel() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/setting/label",
      );
      return GetSettingLabelModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetSettingLabelModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostTransactionModel> updateSettingLabel(String label, int price) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.put(
        "/setting/label",
        data: {
          "label_name": label,
          "price_label": price,
        },
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}

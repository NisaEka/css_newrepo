import 'package:css_mobile/data/model/pengaturan/data_petugas_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_branch_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
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
    } on DioError catch (e) {
      return e.error;
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
    } on DioError catch (e) {
      return e.error;
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
    } on DioError catch (e) {
      return e.error;
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
    } on DioError catch (e) {
      return e.error;
    }
  }

  @override
  Future<PostTransactionModel> putOfficer(DataPetugasModel data) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.put("/officer/${data.id}", data: data);
      return PostTransactionModel.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }

  @override
  Future<GetBranchModel> getBranch() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.put(
        "/branch",
      );
      return GetBranchModel.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }

  @override
  Future<GetOriginModel> getOriginGroup(List<String> keyword) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/origin/group",
        queryParameters: {
          'keyword': keyword.toString(),
        },
      );
      return GetOriginModel.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }
}

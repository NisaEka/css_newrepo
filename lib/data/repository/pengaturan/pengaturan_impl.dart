import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/dashboard/sticker_label_model.dart';
import 'package:css_mobile/data/model/pengaturan/data_petugas_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/pengaturan/pengaturan_repository.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class PengaturanRepositoryImpl extends PengaturanRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<BaseResponse<List<PetugasModel>>> getOfficers(
      int page, String keyword, int limit) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    QueryParamModel params = QueryParamModel(
      search: keyword,
      page: page,
      limit: limit,
      table: true,
    );
    try {
      Response response = await network.base.get(
        "/officers",
        queryParameters: params.toJson(),
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<PetugasModel>(
                  (i) => PetugasModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<PostTransactionModel> deleteOfficer(String id) async {
    //todo : implement delete officer
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.delete(
        "/officer/$id",
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse<PetugasModel>> getOfficerByID(String id) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.get(
        "/officers/$id",
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => PetugasModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<BaseResponse> postOfficer(DataPetugasModel data) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.post(
        "/officers",
        data: data,
      );
      return BaseResponse.fromJson(response.data, (json) => null);
    } on DioException catch (e) {
      return BaseResponse.fromJson(e.response?.data, (json) => null);
    }
  }

  @override
  Future<BaseResponse> putOfficer(DataPetugasModel data) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    data.toJson().printInfo(info: "kiriman data");
    try {
      Response response = await network.base.patch(
        "/officers/${data.id}",
        data: data,
      );
      return BaseResponse.fromJson(response.data, (json) => null);
    } on DioException catch (e) {
      return BaseResponse.fromJson(e.response?.data, (json) => null);
    }
  }

  @override
  Future<BaseResponse<List<StickerLabelModel>>> getSettingLabel() async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.get(
        "/settings/label",
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<StickerLabelModel>(
                  (i) => StickerLabelModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<StickerLabelModel>(
                  (i) => StickerLabelModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }

  @override
  Future<BaseResponse> updateSettingLabel(String label, int price) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.patch(
        "/settings/label",
        data: {
          "labelPrinter": label.toInt(),
          "priceLabel": price,
        },
      );
      return BaseResponse.fromJson(response.data, (json) => null);
    } on DioException catch (e) {
      return BaseResponse.fromJson(e.response?.data, (json) => null);
    }
  }
}

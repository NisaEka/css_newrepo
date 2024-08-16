import 'dart:convert';

import 'package:css_mobile/data/model/pantau/get_pantau_paketmu_model.dart';
import 'package:css_mobile/data/model/response_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_count_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/pantau/pantau_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class PantauRepositoryImpl extends PantauRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<GetPantauPaketmuModel> getPantauList(
    int page,
    int limit,
    String date,
    String keyword,
    String officer,
    String status,
    String type,
  ) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.dio.get(
        "/pantau",
        queryParameters: {
          "page": page,
          "limit": limit,
          "keyword": keyword.toUpperCase(),
          "date": date,
          "officer_entry": officer,
          "status": status,
          "awb_type": type,
        },
      );
      return GetPantauPaketmuModel.fromJson(response.data);
    } on DioException catch (e) {
      e.printError();
      e.response?.data.printError(info: "pantau error");
      return GetPantauPaketmuModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<ResponseModel<List<String>>> getPantauStatus() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.dio.get(
        "/pantau/status",
      );
      return ResponseModel<List<String>>.fromJson(
        response.data,
        (json) => json is List<dynamic> ? response.data['payload'].cast<String>() : List.empty(),
      );
    } on DioException catch (e) {
      return ResponseModel<List<String>>.fromJson(
        e.response?.data,
        (json) => json is List<dynamic> ? e.response?.data['payload'].cast<String>() : List.empty(),
      );
    }
  }

  @override
  Future<ResponseModel<TransactionCount>> getPantauCount(String date, String keyword, String officer, String status) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.dio.get(
        "/pantau/count",
        queryParameters: {
          "keyword": keyword.toUpperCase(),
          "date": date,
          "officer_entry": officer,
          "status": status,
        },
      );
      return ResponseModel<TransactionCount>.fromJson(
        response.data,
        (json) => TransactionCount.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      e.printError();
      return ResponseModel<TransactionCount>.fromJson(
        e.response?.data,
        (json) => TransactionCount.fromJson(json as Map<String, dynamic>),
      );
    }
  }
}

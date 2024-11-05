import 'dart:convert';

import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/laporanku/data_post_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_category_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_message_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_summary_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/laporanku/laporanku_repository.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class LaporankuRepositoryImpl extends LaporankuRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<BaseResponse<List<TicketCategory>>> getTicketCategory(
      QueryParamModel param) async {
    AppLogger.i("param toJson ${param.toJson()}");
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.base.get(
        "/master/ticket-categories",
        queryParameters: param.toJson(),
      );

      return BaseResponse<List<TicketCategory>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<TicketCategory>(
                  (i) => TicketCategory.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return BaseResponse<List<TicketCategory>>.fromJson(
          e.response?.data, (json) => List.empty());
    }
  }

  @override
  Future<BaseResponse<TicketSummary>> getTicketSummary(
      QueryParamModel param) async {
    AppLogger.i("param toJson ${param.toJson()}");
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.base
          .get("/transaction/tickets/summary", queryParameters: param.toJson());

      return BaseResponse<TicketSummary>.fromJson(
        response.data,
        (json) => TicketSummary.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return BaseResponse<TicketSummary>.fromJson(
        e.response?.data,
        (json) => TicketSummary.fromJson(json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<BaseResponse<List<TicketModel>>> getTickets(
      QueryParamModel param) async {
    AppLogger.i("param toJson ${param.toJson()}");
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.base
          .get("/transaction/tickets", queryParameters: param.toJson());

      return BaseResponse<List<TicketModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<TicketModel>(
                  (i) => TicketModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return BaseResponse<List<TicketModel>>.fromJson(
        e.response?.data,
        (json) => List.empty(),
      );
    }
  }

  @override
  Future<BaseResponse<TicketModel>> postTicket(DataPostTicketModel data) async {
    AppLogger.i("param toJson ${data.toJson()}");
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response =
          await network.base.post("/transaction/tickets", data: data);

      return BaseResponse<TicketModel>.fromJson(
        response.data,
        (json) => TicketModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return BaseResponse<TicketModel>.fromJson(
        e.response?.data,
        (json) => TicketModel.fromJson(json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<BaseResponse<List<TicketMessageModel>>> getTickeMessage(
      QueryParamModel param) async {
    AppLogger.i("param toJson ${param.toJson()}");
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.base
          .get("/transaction/ticket-messages", queryParameters: param.toJson());

      return BaseResponse<List<TicketMessageModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<TicketMessageModel>(
                  (i) => TicketMessageModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return BaseResponse<List<TicketMessageModel>>.fromJson(
        e.response?.data,
        (json) => List.empty(),
      );
    }
  }

  @override
  Future<BaseResponse<TicketModel>> postTicketMessage(
      DataPostTicketModel data) async {
    AppLogger.i("param toJson ${jsonEncode(data)}");
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.post(
        "/transaction/ticket-messages",
        data: data,
      );

      return BaseResponse<TicketModel>.fromJson(
        response.data,
        (json) => TicketModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return BaseResponse<TicketModel>.fromJson(
        e.response?.data,
        (json) => TicketModel.fromJson(json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<BaseResponse<TicketModel>> putTicket(String id, String status) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.base.patch(
        "/transaction/tickets/$id",
        data: {
          "status": status,
        },
      );

      return BaseResponse<TicketModel>.fromJson(
        response.data,
        (json) => TicketModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return BaseResponse<TicketModel>.fromJson(
        e.response?.data,
        (json) => TicketModel.fromJson(json as Map<String, dynamic>),
      );
    }
  }
}

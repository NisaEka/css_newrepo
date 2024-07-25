import 'package:css_mobile/data/model/laporanku/data_post_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_category_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_summary_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/laporanku/laporanku_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class LaporankuRepositoryImpl extends LaporankuRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<GetTicketCategoryModel> getTicketCategory() async {
    var token = await storageSecure.read(key: "token");
    network.local.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.local.get(
        "/ticket/category",
      );

      return GetTicketCategoryModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetTicketCategoryModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetTicketSummaryModel> getTicketSummary() async {
    var token = await storageSecure.read(key: "token");
    network.local.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.local.get(
        "/ticket/summary",
      );

      return GetTicketSummaryModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetTicketSummaryModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetTicketModel> getTickets(
    int page,
    int limit,
    String status,
    String date,
    String query,
  ) async {
    var token = await storageSecure.read(key: "token");
    network.local.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.local.get(
        "/ticket",
      );

      return GetTicketModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetTicketModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetTicketModel> postTicket(DataPostTicketModel data) async {
    var token = await storageSecure.read(key: "token");
    network.local.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.local.post(
        "/ticket",
        data: data
      );

      return GetTicketModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetTicketModel.fromJson(e.response?.data);
    }
  }
}

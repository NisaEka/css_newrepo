import 'package:css_mobile/config/api_config.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_banner_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_news_model.dart';
import 'package:css_mobile/data/model/jlc/post_jlc_point_reedem_model.dart';
import 'package:css_mobile/data/model/jlc/post_jlc_transactions_model.dart';
import 'package:css_mobile/data/model/jlc/post_total_point_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';

import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/jlc/jlc_repository.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class JLCRepositoryImpl extends JLCRepository {
  final network = Get.find<NetworkCore>();
  final storage = Get.find<StorageCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<PostTotalPointModel> postTotalPoint() async {
    var account = BaseResponse<List<Account>>.fromJson(
      await storage.readData(StorageCore.accounts),
      (json) => json is List<dynamic>
          ? json
              .map<Account>(
                (i) => Account.fromJson(i as Map<String, dynamic>),
              )
              .toList()
          : List.empty(),
    );
    var jlc = account.data?.where((element) => element.accountService == "JLC");

    try {
      Response response = await network.myJNE.post(
        '/jlctotalpoint',
        data: {
          'username': ApiConfig.jlcUsername,
          'api_key': ApiConfig.jlcAPIKEY,
          'id_member': jlc?.first.accountNumber,
        },
      );

      return PostTotalPointModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostTotalPointModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostJlcTransactionsModel> postTransPoint() async {
    var account = BaseResponse<List<Account>>.fromJson(
      await storage.readData(StorageCore.accounts),
      (json) => json is List<dynamic>
          ? json
              .map<Account>(
                (i) => Account.fromJson(i as Map<String, dynamic>),
              )
              .toList()
          : List.empty(),
    );
    var jlc = account.data?.where((element) => element.accountService == "JLC");

    try {
      Response response = await network.myJNE.post(
        '/jlctranspoint',
        data: {
          'username': ApiConfig.jlcUsername,
          'api_key': ApiConfig.jlcAPIKEY,
          'id_member': jlc?.first.accountNumber,
        },
      );
      return PostJlcTransactionsModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostJlcTransactionsModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostJlcPointReedemModel> postTukarPoint() async {
    var account = BaseResponse<List<Account>>.fromJson(
      await storage.readData(StorageCore.accounts),
      (json) => json is List<dynamic>
          ? json
              .map<Account>(
                (i) => Account.fromJson(i as Map<String, dynamic>),
              )
              .toList()
          : List.empty(),
    );
    var jlc = account.data?.where((element) => element.accountService == "JLC");

    try {
      Response response = await network.myJNE.post(
        '/jlctukarpoint',
        data: {
          'username': ApiConfig.jlcUsername,
          'api_key': ApiConfig.jlcAPIKEY,
          'id_member': jlc?.first.accountNumber,
        },
      );
      return PostJlcPointReedemModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostJlcPointReedemModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<DashboardBannerModel> postDashboardBanner() async {
    Dio banner = Dio();
    banner.options = BaseOptions(
      contentType: 'application/x-www-form-urlencoded',
    );
    try {
      Response response = await banner.post(
        'https://apiv2.jne.co.id:10205/myjne/jlcgetbanner',
        data: {
          'username': ApiConfig.jlcUsername,
          'api_key': ApiConfig.jlcAPIKEY,
        },
      );
      return DashboardBannerModel.fromJson(response.data);
    } on DioException catch (e) {
      return DashboardBannerModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<DashboardNewsModel> postDashboardNews(
    String type,
    String fromDate,
    String toDate,
  ) async {
    Dio news = Dio();
    news.options = BaseOptions(
      contentType: 'application/x-www-form-urlencoded',
    );

    try {
      Response response = await news.post(
        'https://cms.jne.co.id/api_webjne/web_base/',
        data: {
          'username': ApiConfig.bannerKey,
          'api_key': ApiConfig.bannerPass,
          'from_date': fromDate,
          'to_date': toDate,
          'type': type,
        },
      );
      return DashboardNewsModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}

import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_banner_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_news_model.dart';
import 'package:css_mobile/data/model/jlc/post_jlc_point_reedem_model.dart';
import 'package:css_mobile/data/model/jlc/post_jlc_transactions_model.dart';
import 'package:css_mobile/data/model/jlc/post_total_point_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/jlc/jlc_repository.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class JLCRepositoryImpl extends JLCRepository {
  final network = Get.find<NetworkCore>();
  final storage = Get.find<StorageCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<BaseResponse<List<JLCTotalPointModel>>> postTotalPoint() async {
    try {
      Response response = await network.base.get('/accounts/jlc/total');
      return BaseResponse.fromJson(
          response.data,
          (json) => json is List<dynamic>
              ? json
                  .map<JLCTotalPointModel>(
                    (i) => JLCTotalPointModel.fromJson(i as Map<String, dynamic>),
                  )
                  .toList()
              : List.empty());
    } on DioException catch (e) {
      AppLogger.e('error: ${e.message}');
      return BaseResponse.fromJson(
          e.response?.data,
          (json) => json is List<dynamic>
              ? json
                  .map<JLCTotalPointModel>(
                    (i) => JLCTotalPointModel.fromJson(i as Map<String, dynamic>),
                  )
                  .toList()
              : List.empty());
    }
  }

  @override
  Future<BaseResponse<List<JLCTransactions>>> postTransPoint() async {
    try {
      Response response = await network.base.get('/accounts/jlc/trans');
      return BaseResponse<List<JLCTransactions>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<JLCTransactions>(
                  (i) => JLCTransactions.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.e('error: ${e.message}');
      return BaseResponse<List<JLCTransactions>>.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<JLCTransactions>(
                  (i) => JLCTransactions.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }

  @override
  Future<BaseResponse<List<JlcPointReedem>>> postTukarPoint() async {
    try {
      Response response = await network.base.get('/accounts/jlc/tukar');
      return BaseResponse.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<JlcPointReedem>(
                  (i) => JlcPointReedem.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.e('error: ${e.message}');
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<JlcPointReedem>(
                  (i) => JlcPointReedem.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }

  @override
  Future<BaseResponse<List<BannerModel>>> postDashboardBanner() async {
    try {
      Response response = await network.base.get('/accounts/jlc/banner', options: Options(extra: {'skipAuth': true}));
      return BaseResponse.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<BannerModel>(
                  (i) => BannerModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.e('error: ${e.message}');
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<BannerModel>(
                  (i) => BannerModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      ) ;
    }
  }

  @override
  Future<BaseResponse<List<NewsModel>>> postDashboardNews() async {
    try {
      Response response = await network.base.get(
        '/news',
        options: Options(extra: {'skipAuth': true}),
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<NewsModel>(
                  (i) => NewsModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      BaseResponse<List<NewsModel>> res = BaseResponse.fromJson(
          e.response?.data,
          (json) => json is List<dynamic>
              ? json
                  .map<NewsModel>(
                    (i) => NewsModel.fromJson(i as Map<String, dynamic>),
                  )
                  .toList()
              : List.empty());
      return res;
    }
  }
}

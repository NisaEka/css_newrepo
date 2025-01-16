import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/model/response_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_ongkir_model.dart';
import 'package:css_mobile/data/model/transaction/get_cod_fee_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_count_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/pantau_count_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_ongkir_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_summary_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/transaction/transaction_repository.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class TransactionRepositoryImpl extends TransactionRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<BaseResponse<TransactionModel>> postTransaction(
      TransactionModel data) async {
    data.toJson().printInfo(info: "kiriman data");
    try {
      Response response = await network.base.post(
        "/transaction/transactions",
        data: data,
      );
      return BaseResponse<TransactionModel>.fromJson(
        response.data,
        (json) => TransactionModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return BaseResponse<TransactionModel>.fromJson(
        e.response?.data,
        (json) => TransactionModel.fromJson(json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<BaseResponse<CODFeeModel>> getCODFee(String accountID) async {
    try {
      Response response = await network.base.get(
        "/accounts/$accountID",
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => CODFeeModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => CODFeeModel.fromJson(json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<BaseResponse<List<TransactionModel>>> getAllTransaction(
    int page,
    int limit,
    String transType,
    List<Map<String, dynamic>> transDate,
    String transStatus,
    String keyword,
    String officer,
  ) async {
    // UserModel user = UserModel.fromJson(
    //   await StorageCore().readData(StorageCore.basicProfile),
    // );
    QueryModel params = QueryModel(
      table: true,
      limit: limit,
      page: page,
      search: keyword,
      between: transDate,
      type: transType.isNotEmpty ? transType : null,
      status: transStatus.isNotEmpty ? transStatus : null,
      where: officer.isNotEmpty
          ? [
              {"petugasEntry": officer}
            ]
          : null,
      // where: '[$registID $type $petugasEntry]',
      sort: [
        {"createdDate": "desc"}
      ],
    );
    AppLogger.d("transaction data : ${params.toJson()}");

    try {
      Response response = await network.base.get(
        "/transaction/dashboards/detail",
        queryParameters: params.toJson(),
      );
      AppLogger.i('get all transaction : ${response.data}');
      return BaseResponse.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<TransactionModel>(
                  (i) => TransactionModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<TransactionModel>(
                  (i) => TransactionModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }

  @override
  Future<BaseResponse<TransactionModel>> getTransactionByAWB(String awb) async {
    try {
      Response response = await network.base.get(
        "/transaction/transactions/$awb",
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => TransactionModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => TransactionModel.fromJson(json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<BaseResponse<TransactionCount>> getTransactionCount(
    String transType,
    List<Map<String, dynamic>> transDate,
    String transStatus,
    String keyword,
    String officer,
  ) async {
    AppLogger.w('transDate : $transDate');

    QueryModel params = QueryModel(
      table: true,
      search: keyword,
      between: transDate,
      type: transType.isNotEmpty ? transType : null,
      status: transStatus.isNotEmpty ? transStatus : null,
      where: officer.isNotEmpty
          ? [
              {"petugasEntry": officer}
            ]
          : null,
      sort: [
        {"createdDate": "desc"}
      ],
    );

    AppLogger.d("transaction count data : ${params.toJson()}");

    try {
      Response response = await network.base.get(
        "/transaction/dashboards/count",
        queryParameters: params.toJson(),
      );
      AppLogger.i('get transaction count : ${response.data}');

      return BaseResponse<TransactionCount>.fromJson(
        response.data,
        (json) => TransactionCount.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      AppLogger.e('error transaction count : ${e.response?.data}');
      return BaseResponse<TransactionCount>.fromJson(
        e.response?.data,
        (json) => TransactionCount.fromJson(json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<BaseResponse<TransactionModel>> deleteTransaction(String awb) async {
    try {
      Response response = await network.base.delete(
        "/transaction/transactions/$awb",
        queryParameters: {
          'permanent': true,
        },
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => TransactionModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => TransactionModel.fromJson(json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<BaseResponse<List<String>>> getTransactionStatus() async {
    try {
      Response response = await network.base.get(
        "/transaction/statuses",
      );
      AppLogger.d("status transaksi : ${response.data}");
      return BaseResponse.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<String>(
                  (i) => i as String,
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<String>(
                  (i) => i as String,
                )
                .toList()
            : List.empty(),
      );
    }
  }

  @override
  Future<BaseResponse<TransactionModel>> putTransaction(
    TransactionModel data,
    String awb,
  ) async {
    try {
      Response response = await network.base.patch(
        "/transaction/transactions/$awb",
        data: data,
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => TransactionModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      AppLogger.e('error update transaksi : ${e.response?.data}');
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => TransactionModel.fromJson(json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<BaseResponse<List<PetugasModel>>> getTransOfficer(
      QueryModel param) async {
    // UserModel user = UserModel.fromJson(
    //   await StorageCore().readData(StorageCore.basicProfile),
    // );

    QueryModel params = param.copyWith(table: true, limit: 0);
    try {
      Response response = await network.base.get(
        "/transaction/officers",
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
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<PetugasModel>(
                  (i) => PetugasModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }

  @override
  Future<BaseResponse<PostTransactionOngkirModel>> postCalcOngkir(
      DataTransactionOngkirModel data) async {
    data.toJson().printInfo();
    try {
      Response response = await network.base.post(
        "/transaction/fees/ongkir",
        data: data,
        options: Options(extra: {'skipAuth': true}),
      );

      return BaseResponse<PostTransactionOngkirModel>.fromJson(
        response.data,
        (json) =>
            PostTransactionOngkirModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return BaseResponse<PostTransactionOngkirModel>.fromJson(
        e.response?.data,
        (json) =>
            PostTransactionOngkirModel.fromJson(json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<ResponseModel<TransactionSummaryModel>> postTransactionDashboard(
      QueryModel param) async {
    var now = DateTime.now().toLocal();
    var startDate = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 6))
        .toIso8601String();
    var endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999)
        .toIso8601String();
    network.base.options.copyWith(connectTimeout: const Duration(seconds: 20));

    try {
      Response response = await network.base.get(
        "/transaction/dashboards",
        options: Options(
          receiveTimeout: const Duration(seconds: 20),
        ),
        queryParameters: param.copyWith(
          between: [
            {
              "createdDateSearch": [startDate, endDate]
            }
          ],
        ).toJson(),
      );

      final test = ResponseModel<TransactionSummaryModel>.fromJson(
        response.data,
        (json) {
          // Deserialize the PropertySummary
          return TransactionSummaryModel.fromJson(json as Map<String, dynamic>);
        },
      );
      return test;
    } on DioException catch (e) {
      return ResponseModel<TransactionSummaryModel>.fromJson(
        e.response?.data,
        (json) =>
            TransactionSummaryModel.fromJson(json as Map<String, dynamic>),
      );
    }
  }

  @override
  Future<BaseResponse<List<PantauCountModel>>> getPantauCount(
      QueryModel param) async {
    network.base.options.copyWith(connectTimeout: const Duration(seconds: 20));

    try {
      Response response = await network.base.get(
        '/transaction/tracks/count/dashboard',
        options: Options(receiveTimeout: const Duration(seconds: 20)),
        queryParameters: param.toJson(),
      );

      var trans = BaseResponse<List<PantauCountModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<PantauCountModel>(
                  (i) => PantauCountModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );

      return trans;
    } on DioException catch (e) {
      AppLogger.e("error get pantau count : $e");
      return BaseResponse<List<PantauCountModel>>.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<PantauCountModel>(
                  (i) => PantauCountModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }
}

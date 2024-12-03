import 'dart:convert';

import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/response_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_ongkir_model.dart';
import 'package:css_mobile/data/model/transaction/get_cod_fee_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_count_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_ongkir_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_summary_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/transaction/transaction_repository.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

// import 'package:css_mobile/data/model/profile/user_profile_model.dart';
// import 'package:css_mobile/data/storage_core.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<BaseResponse<TransactionModel>> postTransaction(
      TransactionModel data) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
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
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';

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
    String transDate,
    String transStatus,
    String keyword,
    String officer,
  ) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    // UserModel user = UserModel.fromJson(
    //   await StorageCore().readData(StorageCore.basicProfile),
    // );
    QueryParamModel params = QueryParamModel(
      table: true,
      limit: limit,
      page: page,
      search: keyword,
      between: transDate,
      type: transType.isNotEmpty ? transType : null,
      status: transStatus.isNotEmpty ? transStatus : null,
      where: officer.isNotEmpty
          ? jsonEncode([
              {"petugasEntry": officer}
            ])
          : null,
      // where: '[$registID $type $petugasEntry]',
      sort: '[{"createdDateSearch":"desc"}]',
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
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
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
    String transDate,
    String transStatus,
    String keyword,
    String officer,
  ) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    AppLogger.w('transDate : $transDate');
    // UserModel user = UserModel.fromJson(
    //   await StorageCore().readData(StorageCore.basicProfile),
    // );
    QueryParamModel params = QueryParamModel(
      table: true,
      search: keyword,
      between: transDate,
      type: transType.isNotEmpty ? transType : null,
      status: transStatus.isNotEmpty ? transStatus : null,
      // where: '[$registID $type $petugasEntry]',
      // where: officer.isNotEmpty && user.userType == 'PEMILIK'
      //     ? jsonEncode([
      //         {"petugasEntry": officer}
      //       ])
      //     : jsonEncode([
      //         {"petugasEntry": user.name}
      //       ]),
      where: officer.isNotEmpty
          ? jsonEncode([
              {"petugasEntry": officer}
            ])
          : null,
      sort: '[{"createdDateSearch":"desc"}]',
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
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
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
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
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
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
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
  Future<BaseResponse<List<PetugasModel>>> getTransOfficer() async {
    var token = await storageSecure.read(key: 'token');
    network.base.options.headers['Authorization'] = 'Bearer $token';
    // UserModel user = UserModel.fromJson(
    //   await StorageCore().readData(StorageCore.basicProfile),
    // );

    QueryParamModel params = QueryParamModel(table: true, limit: 0);
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
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
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
      QueryParamModel param) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    var startDate = DateTime.now().subtract(const Duration(days: 7));
    var endDate = DateTime.now();

    try {
      Response response = await network.base.get(
        "/transaction/dashboards",
        queryParameters: param
            .copyWith(
              between: '[{"createdDateSearch":["$startDate","$endDate"]}]',
            )
            .toJson(),
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
}

import 'package:css_mobile/data/model/transaction/data_service_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_fee_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_cod_fee_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/model/transaction/get_receiver_model.dart';
import 'package:css_mobile/data/model/transaction/get_service_model.dart';
import 'package:css_mobile/data/model/transaction/get_shipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_by_awb_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_count_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_fee_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_officer_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_status_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/transaction/transaction_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class TransactionRepositoryImpl extends TransactionRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<GetAccountNumberModel> getAccountNumber() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/account",
      );
      return GetAccountNumberModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<GetDropshipperModel> getDropshipper() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/dropshipper",
      );
      return GetDropshipperModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<GetShipperModel> getSender() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/shipper",
      );
      return GetShipperModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<GetOriginModel> getOrigin(String? keyword, String accountID) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    keyword.printInfo(info: "keyword");
    try {
      Response response = await network.dio.get(
        "/origin",
        queryParameters: {
          "keyword": keyword,
          "account_id": accountID,
        },
      );
      return GetOriginModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<GetDestinationModel> getDestination(String? keyword) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/destination",
        queryParameters: {
          "keyword": keyword,
        },
      );
      return GetDestinationModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<GetReceiverModel> getReceiver() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/receiver",
      );
      return GetReceiverModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<GetServiceModel> getService(DataServiceModel param) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.dio.get(
        "/transaction/service",
        queryParameters: {
          'account_id': param.accountId,
          'origin_code': param.originCode,
          'destination_code': param.destinationCode,
        },
      );
      return GetServiceModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetServiceModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetTransactionFeeModel> getTransactionFee(DataTransactionFeeModel params) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.dio.get(
        "/transaction/fee",
        queryParameters: {
          "origin_code": params.originCode,
          "destination_code": params.destinationCode,
          "service_code": params.serviceCode,
          "weight": params.weight,
          "cust_no": params.custNo,
        },
      );
      return GetTransactionFeeModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<PostTransactionModel> postTransaction(DataTransactionModel data) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    network.local.options.headers['Authorization'] = 'Bearer $token';
    data.toJson().printInfo(info: "kiriman data");
    try {
      Response response = await network.local.post(
        "/transaction",
        data: data,
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostTransactionModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetCodFeeModel> getCODFee(String accountID) async {
    try {
      Response response = await network.dio.get(
        "/account/cod/fee",
        queryParameters: {
          'account_id': accountID,
        },
      );
      return GetCodFeeModel.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  @override
  Future<PostTransactionModel> postDropshipper(DropshipperModel data) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    data.toJson().printInfo();
    try {
      Response response = await network.dio.post(
        "/dropshipper",
        data: data,
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostTransactionModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostTransactionModel> postReceiver(ReceiverModel data) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    data.toJson().printInfo(info: 'receiverData');
    try {
      Response response = await network.dio.post(
        "/receiver",
        data: data,
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostTransactionModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostTransactionModel> deleteDropshipper(String id) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.delete(
        "/dropshipper/$id",
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostTransactionModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostTransactionModel> deleteReceiver(String id) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.delete(
        "/receiver/$id",
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostTransactionModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetTransactionModel> getTransaction(
    int page,
    int limit,
    String transType,
    String transDate,
    String transStatus,
    String keyword,
    String officer,
  ) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    transDate.printInfo(info: "transaction date");
    try {
      Response response = await network.dio.get(
        "/transaction",
        queryParameters: {
          "transaction_status": transStatus,
          "transaction_date": transDate,
          "transaction_type": transType,
          "keyword": keyword,
          "officer": officer,
          "page": page,
          "limit": limit,
        },
      );
      return GetTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetTransactionModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetTransactionByAwbModel> getTransactionByAWB(String awb) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    network.local.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/transaction/$awb",
      );
      return GetTransactionByAwbModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetTransactionByAwbModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetTransactionCountModel> getTransactionCount(
    String transType,
    String transDate,
    String transStatus,
    String keyword,
    String officer,
  ) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    print("transStatus${transStatus}");
    try {
      Response response = await network.dio.get(
        "/transaction/count",
        queryParameters: {
          "transaction_status": transStatus,
          "transaction_date": transDate,
          "transaction_type": transType,
          "keyword": keyword,
          "officer": officer,
        },
      );
      return GetTransactionCountModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetTransactionCountModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostTransactionModel> deleteTransaction(String awb) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.delete(
        "/transaction/$awb",
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostTransactionModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetTransactionStatusModel> getTransactionStatus() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/transaction/status",
      );
      return GetTransactionStatusModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetTransactionStatusModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostTransactionModel> putTransaction(
    DataTransactionModel data,
    String awb,
  ) async {
    print("weigh: ${data.goods?.weight}");
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.put(
        "/transaction/$awb",
        data: data
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostTransactionModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetTransactionOfficerModel> getTransOfficer() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/transaction/officer",
      );
      return GetTransactionOfficerModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetTransactionOfficerModel.fromJson(e.response?.data);
    }
  }
}

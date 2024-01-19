import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/model/transaction/get_receiver_model.dart';
import 'package:css_mobile/data/model/transaction/get_service_model.dart';
import 'package:css_mobile/data/model/transaction/get_shipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_fee_model.dart';
import 'package:css_mobile/data/model/transaction/service_data_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_fee_data_model.dart';
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
    } on DioError catch (e) {
      //print("response error: ${e.response?.data}");
      return e.error;
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
    } on DioError catch (e) {
      //print("response error: ${e.response?.data}");
      return e.error;
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
    } on DioError catch (e) {
      //print("response error: ${e.response?.data}");
      return e.error;
    }
  }

  @override
  Future<GetOriginModel> getOrigin(String? keyword, String accountID) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response = await network.dio.get(
        "/origin",
        queryParameters: {
          "keyword": keyword,
          "account_id": accountID,
        },
      );
      return GetOriginModel.fromJson(response.data);
    } on DioError catch (e) {
      //print("response error: ${e.response?.data}");
      return e.error;
    }
  }

  @override
  Future<GetDestinationModel> getDestination(String? keyword) async {
    try {
      Response response = await network.dio.get(
        "/destination",
        queryParameters: {
          "keyword": keyword,
        },
      );
      return GetDestinationModel.fromJson(response.data);
    } on DioError catch (e) {
      //print("response error: ${e.response?.data}");
      return e.error;
    }
  }

  @override
  Future<GetReceiverModel> getReceiver() async {
    try {
      Response response = await network.dio.get(
        "/receiver",
      );
      return GetReceiverModel.fromJson(response.data);
    } on DioError catch (e) {
      //print("response error: ${e.response?.data}");
      return e.error;
    }
  }

  @override
  Future<GetServiceModel> getService(ServiceDataModel param) async {
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
    } on DioError catch (e) {
      //print("response error: ${e.response?.data}");
      return e.error;
    }
  }

  @override
  Future<GetTransactionFeeModel> getTransactionFee(TransactionFeeDataModel params) async {
    try {
      Response response = await network.dio.get(
        "/transaction/fee",
        // queryParameters: {
        //   "origin_code": "AMI10000",
        //   "destination_code": "CGK10302",
        //   "service_code": "JTR",
        //   "weight": 1,
        //   "cust_no": "1624166223" //account number
        // }
        options: Options(method: "GET"),
        queryParameters: {
          "origin_code": params.originCode,
          "destination_code": params.destinationCode,
          "service_code": params.serviceCode,
          "weight": params.weight,
          "cust_no": params.custNo,
        },
      );
      print(response.data);
      return GetTransactionFeeModel.fromJson(response.data);
    } on DioError catch (e) {
      //print("response error: ${e.response?.data}");
      return e.error;
    }
  }
}

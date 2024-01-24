import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_cod_fee_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/model/transaction/get_receiver_model.dart';
import 'package:css_mobile/data/model/transaction/get_service_model.dart';
import 'package:css_mobile/data/model/transaction/get_shipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_fee_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/service_data_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_data_model.dart';
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
    } on DioError catch (e) {
      //print("response error: ${e.response?.data}");
      return e.error;
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
    } on DioError catch (e) {
      //print("response error: ${e.response?.data}");
      return e.error;
    }
  }

  @override
  Future<GetServiceModel> getService(ServiceDataModel param) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.dio.get(
        "/transaction/service",
        queryParameters: param.toJson(),
        // queryParameters: {
        //   'account_id': param.accountId,
        //   'origin_code': param.originCode,
        //   'destination_code': param.destinationCode,
        // },
      );
      return GetServiceModel.fromJson(response.data);
    } on DioError catch (e) {
      //print("response error: ${e.response?.data}");
      return e.error;
    }
  }

  @override
  Future<GetTransactionFeeModel> getTransactionFee(TransactionFeeDataModel params) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';

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
        // options: Options(method: "GET"),
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

  @override
  Future<PostTransactionModel> postTransaction(TransactionDataModel data) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    data.toJson().printInfo();
    try {
      Response response = await network.dio.post(
        "/transaction",
        // data: jsonEncode(data.toJson()),
        data: {
          "delivery": {
            "service_code": data.delivery?.serviceCode,
            "wood_packaging": data.delivery?.woodPackaging,
            "special_instruction": data.delivery?.specialInstruction,
            "cod_flag": data.delivery?.codFlag,
            "cod_ongkir": data.delivery?.codOngkir,
            "cod_fee": data.delivery?.codFee,
            "insurance_flag": data.delivery?.insuranceFlag,
            "insurance_fee": data.delivery?.insuranceFee,
            "flat_rate": data.delivery?.flatRate,
            "flat_rate_with_insurance": data.delivery?.flatRateWithInsurance,
            "freight_charge": data.delivery?.freightCharge,
            "freight_charge_with_insurance": data.delivery?.freightCharge,
          },
          "account": {
            "number": data.account?.number,
            "service": data.account?.service,
          },
          "origin": {
            "code": data.origin?.code,
            "desc": data.origin?.desc,
            "branch": data.origin?.branch,
          },
          "destination": {
            "code": data.destination?.code,
            "desc": data.destination?.desc,
          },
          "goods": {
            "type": data.goods?.type,
            "desc": data.goods?.desc,
            "amount": data.goods?.amount,
            "quantity": data.goods?.quantity,
            "weight": data.goods?.weight,
          },
          "shipper": {
            "name": data.shipper?.name,
            "address": data.shipper?.address,
            "address1": data.shipper?.address1,
            "address2": data.shipper?.address2,
            "address3": data.shipper?.address3,
            "city": data.shipper?.city,
            "zip": data.shipper?.zip,
            "region": data.shipper?.region,
            "country": data.shipper?.country,
            "contact": data.shipper?.contact,
            "phone": data.shipper?.phone,
          },
          "receiver": {
            "name": data.receiver?.name,
            "address": data.receiver?.address,
            "address1": data.receiver?.address1,
            "address2": data.receiver?.address2,
            "address3": data.receiver?.address3,
            "city": data.receiver?.city,
            "zip": data.receiver?.zip,
            "region": data.receiver?.region,
            "country": data.receiver?.country,
            "contact": data.receiver?.contact,
            "phone": data.receiver?.phone,
            "district": data.receiver?.district,
            "sub_district": data.receiver?.subDistrict,
          },
        },
      );
      print(response.data);
      // return response.data;
      return PostTransactionModel.fromJson(response.data);
      // return PostTransactionModel();
    } on DioError catch (e) {
      print("response error: ${e.response?.data}");
      return e.error;
    }
  }

  @override
  Future<GetCodFeeModel> getCODFee(String accountId) async {
    try {
      Response response = await network.dio.get(
        "/account/cod/fee",
        queryParameters: {
          'account_id': accountId,
        },
      );
      return GetCodFeeModel.fromJson(response.data);
    } on DioError catch (e) {
      //print("response error: ${e.response?.data}");
      return e.error;
    }
  }
}

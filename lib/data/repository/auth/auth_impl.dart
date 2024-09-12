import 'package:css_mobile/data/model/auth/get_agent_model.dart';
import 'package:css_mobile/data/model/auth/get_check_mail_model.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/auth/get_referal_model.dart';
import 'package:css_mobile/data/model/auth/input_login_model.dart';
import 'package:css_mobile/data/model/auth/input_new_password_model.dart';
import 'package:css_mobile/data/model/auth/input_pinconfirm_model.dart';
import 'package:css_mobile/data/model/auth/input_register_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/auth/auth_repository.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/login/login_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class AuthRepositoryImpl extends AuthRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<LoginModel> postLogin(InputLoginModel loginData) async {
    try {
      Response response = await network.dio.post(
        '/auth/login',
        data: loginData,
      );
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      return LoginModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostTransactionModel> postRegistPinConfirm(InputPinconfirmModel data) async {
    try {
      Response response = await network.dio.post(
        '/auth/registration/pin/confirm',
        data: data,
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostTransactionModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostTransactionModel> postRegistPinResend(InputPinconfirmModel data) async {
    try {
      Response response = await network.dio.post(
        '/auth/registration/pin/resend',
        data: data,
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostTransactionModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostTransactionModel> postRegister(InputRegisterModel data) async {
    try {
      Response response = await network.dio.post(
        '/auth/registration',
        data: data,
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostTransactionModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetAgentModel> getAgent(String branchCode) async {
    try {
      Response response = await network.dio.get(
        '/agent?branch_code=$branchCode',
      );
      return GetAgentModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetAgentModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetReferalModel> getReferal(String keyword) async {
    try {
      Response response = await network.dio.get(
        '/referral?keyword=$keyword',
      );
      return GetReferalModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetReferalModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostTransactionModel> postEmailForgotPassword(String email) async {
    try {
      Response response = await network.dio.post(
        '/auth/password/forgot',
        data: {
          "email": email,
        },
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostTransactionModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<PostTransactionModel> postPasswordChage(InputNewPasswordModel data) async {
    try {
      Response response = await network.dio.post(
        '/auth/password/change',
        data: data,
      );
      return PostTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      return PostTransactionModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<LoginModel> postPasswordPinConfirm(InputPinconfirmModel data) async {
    try {
      Response response = await network.dio.post(
        '/auth/password/pin/confirm',
        data: data,
      );
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      return LoginModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetCheckMailModel> getCheckMail(String email) async {
    try {
      Response response = await network.dio.get(
        '/auth/registration/mail_check/$email',
      );
      // Response response = await Dio().get(
      //   'https://api.mailcheck.ai/email/$email',
      // );
      return GetCheckMailModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetCheckMailModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<LoginModel> postFcmToken(Device data) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.dio.post(
        '/device_info',
        data: data,
      );
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      return LoginModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<LoginModel> logout() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    var fcmToken = await StorageCore().readString(StorageCore.fcmToken);

    var deviceInfo = await LoginController().getDeviceinfo(fcmToken);
    String id = deviceInfo?.deviceId ?? '';

    try {
      Response response = await network.dio.delete(
        '/device_info/$id',
      );
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      return LoginModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<LoginModel> postFcmTokenNonAuth(Device data) async {
    try {
      Response response = await network.dio.post(
        '/device_info/save',
        data: data,
      );
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      return LoginModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<LoginModel> updateDeviceInfo(Device data) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.dio.put(
        '/device_info',
        data: data,
      );
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      return LoginModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<LoginModel> updateDeviceInfoNonAuth(Device data) async {
    try {
      Response response = await network.dio.put(
        '/device_info/update',
        data: data,
      );
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      return LoginModel.fromJson(e.response?.data);
    }
  }
}

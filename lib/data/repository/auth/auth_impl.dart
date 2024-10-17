import 'package:css_mobile/data/model/auth/get_agent_model.dart';
import 'package:css_mobile/data/model/auth/get_check_mail_model.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/auth/get_referal_model.dart';
import 'package:css_mobile/data/model/auth/input_login_model.dart';
import 'package:css_mobile/data/model/auth/input_new_password_model.dart';
import 'package:css_mobile/data/model/auth/input_pinconfirm_model.dart';
import 'package:css_mobile/data/model/auth/input_register_model.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
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
  Future<BaseResponse<PostLoginModel>> postLogin(InputLoginModel loginData) async {
    try {
      Response response = await network.base.post(
        '/authentications/login',
        data: loginData,
      );
      return BaseResponse<PostLoginModel>.fromJson(
        response.data,
        (json) => PostLoginModel.fromJson(
          json as Map<String, dynamic>,
        ),
      );
    } on DioException catch (e) {
      return BaseResponse<PostLoginModel>.fromJson(
        e.response?.data,
        (json) => PostLoginModel.fromJson(
          json as Map<String, dynamic>,
        ),
      );
    }
  }

  @override
  Future<BaseResponse> postRegistPinConfirm(InputPinconfirmModel data) async {
    try {
      Response response = await network.dio.post(
        '/auth/registration/pin/confirm',
        data: data,
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => null,
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => null,
      );
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
  Future<BaseResponse> postRegister(InputRegisterModel data) async {
    try {
      Response response = await network.dio.post(
        '/auth/registration',
        data: data,
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => null,
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => null,
      );
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
      Response response = await network.local.get(
        '/master/group-owners?search=$keyword',
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
  Future<GetLoginModel> postPasswordPinConfirm(InputPinconfirmModel data) async {
    try {
      Response response = await network.dio.post(
        '/auth/password/pin/confirm',
        data: data,
      );
      return GetLoginModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetLoginModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<BaseResponse<MailCheckModel>> getCheckMail(String email) async {
    try {
      Response response = await network.base.get(
        '/authentications/email-check/$email',
      );
      // Response response = await Dio().get(
      //   'https://api.mailcheck.ai/email/$email',
      // );
      return BaseResponse<MailCheckModel>.fromJson(
        response.data,
        (json) => MailCheckModel.fromJson(
          json as Map<String, dynamic>,
        ),
      );
    } on DioException catch (e) {
      return BaseResponse<MailCheckModel>.fromJson(
        e.response?.data,
        (json) => MailCheckModel.fromJson(
          json as Map<String, dynamic>,
        ),
      );
    }
  }

  @override
  Future<BaseResponse> postFcmToken(Device data) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.base.post(
        '/auth/device-infos',
        data: data,
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => null,
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => null,
      );
    }
  }

  @override
  Future<BaseResponse> logout() async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';
    var fcmToken = await StorageCore().readString(StorageCore.fcmToken);

    var deviceInfo = await LoginController().getDeviceinfo(fcmToken);
    String id = deviceInfo?.deviceId ?? '';

    try {
      Response response = await network.base.patch(
        '/auth/device-infos/update',
      );

      Response logout = await network.base.post(
        'authentications/logout',
      );
      return BaseResponse.fromJson(
        logout.data,
        (json) => null,
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => null,
      );
    }
  }

  @override
  Future<GetLoginModel> postFcmTokenNonAuth(Device data) async {
    try {
      Response response = await network.dio.post(
        '/device_info/save',
        data: data,
      );
      return GetLoginModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetLoginModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetLoginModel> updateDeviceInfo(Device data) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.dio.put(
        '/device_info',
        data: data,
      );
      return GetLoginModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetLoginModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<GetLoginModel> updateDeviceInfoNonAuth(Device data) async {
    try {
      Response response = await network.dio.put(
        '/device_info/update',
        data: data,
      );
      return GetLoginModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetLoginModel.fromJson(e.response?.data);
    }
  }
}

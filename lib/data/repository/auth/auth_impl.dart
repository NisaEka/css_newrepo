import 'package:css_mobile/data/model/auth/get_check_mail_model.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/auth/get_referal_model.dart';
import 'package:css_mobile/data/model/auth/input_login_model.dart';
import 'package:css_mobile/data/model/auth/input_new_password_model.dart';
import 'package:css_mobile/data/model/auth/input_pinconfirm_model.dart';
import 'package:css_mobile/data/model/auth/input_register_model.dart';
import 'package:css_mobile/data/model/auth/pin_confirm_model.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/auth/auth_repository.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class AuthRepositoryImpl extends AuthRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<BaseResponse<PostLoginModel>> postLogin(
      InputLoginModel loginData) async {
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
      Response response = await network.base.post(
        '/authentications/email-confirm',
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
  Future<BaseResponse> postRegistPinResend(InputPinconfirmModel data) async {
    try {
      Response response = await network.base.post(
        '/authentications/email-confirm/resend',
        data: data,
      );
      return BaseResponse.fromJson(response.data, (json) => null);
    } on DioException catch (e) {
      return BaseResponse.fromJson(e.response?.data, (json) => null);
    }
  }

  @override
  Future<BaseResponse> postRegister(InputRegisterModel data) async {
    try {
      Response response = await network.base.post(
        '/authentications/signup',
        data: data,
      );
      return BaseResponse.fromJson(
        response.data,
        (json) => null,
      );
    } on DioException catch (e) {
      return BaseResponse<List<String>>.fromJson(
        e.response?.data,
        (json) => json is List<String>
            ? json
                .map<String>(
                  (i) => i,
                )
                .toList()
            : List.empty(),
      );
    }
  }

  // @override
  // Future<GetAgentModel> getAgent(String branchCode) async {
  //   try {
  //     Response response = await network.dio.get(
  //       '/agent?branch_code=$branchCode',
  //     );
  //     return GetAgentModel.fromJson(response.data);
  //   } on DioException catch (e) {
  //     return GetAgentModel.fromJson(e.response?.data);
  //   }
  // }

  @override
  Future<GetReferalModel> getReferal(String keyword) async {
    try {
      Response response = await network.base.get(
        '/master/group-owners?search=$keyword',
      );
      return GetReferalModel.fromJson(response.data);
    } on DioException catch (e) {
      return GetReferalModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<BaseResponse> postEmailForgotPassword(String email) async {
    try {
      Response response = await network.base.post(
        '/authentications/forgot-password',
        data: {
          "email": email,
        },
      );

      AppLogger.d('post email : ${response.data.toString()}');
      return BaseResponse.fromJson(response.data, (json) => null);
    } on DioException catch (e) {
      AppLogger.e('error post email : ${e.response?.data}');
      return BaseResponse.fromJson(e.response?.data, (json) => null);
    }
  }

  @override
  Future<BaseResponse> postPasswordChage(InputNewPasswordModel data) async {
    try {
      Response response = await network.base.patch(
        '/authentications/reset-password',
        data: data,
      );
      return BaseResponse.fromJson(response.data, (json) => null);
    } on DioException catch (e) {
      return BaseResponse.fromJson(e.response?.data, (json) => null);
    }
  }

  @override
  Future<BaseResponse<PinConfirmModel>> postPasswordPinConfirm(
      InputPinconfirmModel data) async {
    try {
      Response response = await network.base.post(
        '/authentications/forgot-password/confirm',
        data: data,
      );
      return BaseResponse.fromJson(response.data,
          (json) => PinConfirmModel.fromJson(json as Map<String, dynamic>));
    } on DioException catch (e) {
      return BaseResponse.fromJson(
          e.response?.data, (json) => PinConfirmModel());
    }
  }

  @override
  Future<BaseResponse<MailCheckModel>> getCheckMail(String email) async {
    try {
      Response response = await network.base.get(
        '/authentications/email-check/$email',
      );
      return BaseResponse<MailCheckModel>.fromJson(
        response.data,
        (json) => MailCheckModel.fromJson(
          json as Map<String, dynamic>,
        ),
      );
    } on DioException catch (e) {
      return BaseResponse<MailCheckModel>.fromJson(
        e.response?.data,
        (json) => MailCheckModel(),
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
    // var fcmToken = await StorageCore().readString(StorageCore.fcmToken);

    // var deviceInfo = await LoginController().getDeviceinfo(fcmToken);
    // String id = deviceInfo?.deviceId ?? '';

    try {
      Response response = await network.base.post(
        '/authentications/logout',
        data: {},
      );
      // .then((value) async => await network.base.patch(
      //       '/auth/device-infos/update',
      //       data: deviceInfo,
      //     ));
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
  Future<BaseResponse> postFcmTokenNonAuth(Device data) async {
    try {
      Response response = await network.base.post(
        '/auth/device-infos/save',
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
  Future<BaseResponse> updateDeviceInfo(Device data) async {
    var token = await storageSecure.read(key: "token");
    network.base.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.base.patch(
        '/auth/device-infos/update',
        data: data,
      );
      return BaseResponse.fromJson(response.data, (json) => json);
    } on DioException catch (e) {
      return BaseResponse.fromJson(e.response?.data, (json) => json);
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

  @override
  Future<BaseResponse<PostLoginModel>> postRefreshToken() async {
    var token = await storageSecure.read(key: StorageCore.refreshToken);
    // network.dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await network.base.post(
        '/authentications/refresh',
        data: {
          "refreshToken": token,
        },
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
}

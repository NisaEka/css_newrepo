import 'package:css_mobile/data/model/auth/get_check_mail_model.dart';
import 'package:css_mobile/data/model/auth/get_device_info_model.dart';
import 'package:css_mobile/data/model/auth/get_referal_model.dart';
import 'package:css_mobile/data/model/auth/input_login_model.dart';
import 'package:css_mobile/data/model/auth/input_new_password_model.dart';
import 'package:css_mobile/data/model/auth/input_pinconfirm_model.dart';
import 'package:css_mobile/data/model/auth/input_register_model.dart';
import 'package:css_mobile/data/model/auth/pin_confirm_model.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
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
        options: Options(extra: {'skipAuth': true}),
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
        options: Options(extra: {'skipAuth': true}),
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
        options: Options(extra: {'skipAuth': true}),
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
        options: Options(extra: {'skipAuth': true}),
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
        options: Options(extra: {'skipAuth': true}),
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
        options: Options(extra: {'skipAuth': true}),
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
        options: Options(extra: {'skipAuth': true}),
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
        options: Options(extra: {'skipAuth': true}),
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
        options: Options(extra: {'skipAuth': true}),
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
  Future<BaseResponse> postFcmToken(DeviceModel data) async {
    try {
      Response response = await network.base.post(
        '/auth/device-infos',
        data: data,
      );
      AppLogger.d('post fcm token ${response.data.toString()}');
      return BaseResponse.fromJson(
        response.data,
        (json) => null,
      );
    } on DioException catch (e) {
      AppLogger.i('error post fcm token ${e.response?.data.toString()}');
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => null,
      );
    }
  }

  @override
  Future<BaseResponse> logout() async {
    // var fcmToken = await StorageCore().readString(StorageCore.fcmToken);

    // var deviceInfo = await LoginController().getDeviceinfo(fcmToken);
    // String id = deviceInfo?.deviceId ?? '';
    try {
      Response response = await network.base.post(
        '/authentications/logout',
        options: Options(extra: {'skipAuth': true}),
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
  Future<BaseResponse> postFcmTokenNonAuth(DeviceModel data) async {
    try {
      Response response = await network.base.post(
        '/auth/device-infos/public',
        data: data,
        options: Options(extra: {'skipAuth': true}),
      );
      AppLogger.i("post device info non auth : ${response.data}");
      return BaseResponse.fromJson(response.data, (json) => null);
    } on DioException catch (e) {
      AppLogger.i("error post device info non auth : ${e.response?.data}");

      return BaseResponse.fromJson(e.response?.data, (json) => null);
    }
  }

  @override
  Future<BaseResponse> updateDeviceInfo(DeviceModel data) async {
    AppLogger.i("device model : ${data.toJson()}");
    try {
      Response response = await network.base.patch(
        '/auth/device-infos/public',
        data: data,
        options: Options(extra: {'skipAuth': true}),
      );
      AppLogger.i('update device info : ${response.data}');
      return BaseResponse.fromJson(response.data, (json) => json);
    } on DioException catch (e) {
      AppLogger.e('error update device info : ${e.response?.data}');
      return BaseResponse.fromJson(e.response?.data, (json) => json);
    }
  }

  @override
  Future<BaseResponse<List<DeviceModel>>> getFcmToken() async {
    try {
      Response response = await network.base.get(
        "/auth/device-infos",
        queryParameters: QueryModel(
          table: true,
          where: [
            {"fcmToken": await storageSecure.read(key: StorageCore.fcmToken)}
          ],
        ).toJson(),
      );
      AppLogger.i("get fcm token : ${response.data}");
      return BaseResponse.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<DeviceModel>(
                  (i) => DeviceModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      return BaseResponse.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<DeviceModel>(
                  (i) => DeviceModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }
}

import 'package:css_mobile/data/model/auth/get_device_info_model.dart';
import 'package:css_mobile/data/model/auth/pin_confirm_model.dart';
import 'package:css_mobile/data/model/auth/input_login_model.dart';
import 'package:css_mobile/data/model/auth/input_new_password_model.dart';
import 'package:css_mobile/data/model/auth/input_pinconfirm_model.dart';
import 'package:css_mobile/data/model/auth/input_register_model.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';

abstract class AuthRepository {
  Future<BaseResponse<PostLoginModel>> postLogin(InputLoginModel loginData);

  Future<BaseResponse> postRegister(InputRegisterModel data);

  Future<BaseResponse> postRegistPinConfirm(InputPinconfirmModel data);

  Future<BaseResponse> postRegistPinResend(InputPinconfirmModel data);

  Future<BaseResponse> postEmailForgotPassword(String email);

  Future<BaseResponse<PinConfirmModel>> postPasswordPinConfirm(
      InputPinconfirmModel data);

  Future<BaseResponse> postPasswordChage(InputNewPasswordModel data);

  Future<BaseResponse> postFcmToken(DeviceInfoModel data);

  Future<BaseResponse> postFcmTokenNonAuth(DeviceInfoModel data);

  Future<BaseResponse<List<DeviceInfoModel>>> getFcmToken();

  Future<BaseResponse> logout(String refreshToken);

  Future<BaseResponse> updateDeviceInfo(DeviceInfoModel data);

  Future<BaseResponse<PostLoginModel>> updateToken();
}

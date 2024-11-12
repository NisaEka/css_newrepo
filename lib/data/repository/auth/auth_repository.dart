import 'package:css_mobile/data/model/auth/pin_confirm_model.dart';
import 'package:css_mobile/data/model/auth/get_check_mail_model.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/auth/get_referal_model.dart';
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

  Future<GetReferalModel> getReferal(String keyword);

  Future<BaseResponse> postEmailForgotPassword(String email);

  Future<BaseResponse<PinConfirmModel>> postPasswordPinConfirm(
      InputPinconfirmModel data);

  Future<BaseResponse> postPasswordChage(InputNewPasswordModel data);

  Future<BaseResponse<MailCheckModel>> getCheckMail(String email);

  Future<BaseResponse> postFcmToken(Device data);

  Future<BaseResponse> postFcmTokenNonAuth(Device data);

  Future<BaseResponse> logout();

  Future<BaseResponse> updateDeviceInfo(Device data);

  Future<GetLoginModel> updateDeviceInfoNonAuth(Device data);

  Future<BaseResponse<PostLoginModel>> postRefreshToken();
}

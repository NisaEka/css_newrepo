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

abstract class AuthRepository {
  Future<BaseResponseModel<PostLoginModel>> postLogin(InputLoginModel loginData);

  Future<BaseResponseModel> postRegister(InputRegisterModel data);

  Future<BaseResponseModel> postRegistPinConfirm(InputPinconfirmModel data);

  Future<PostTransactionModel> postRegistPinResend(InputPinconfirmModel data);

  Future<GetReferalModel> getReferal(String keyword);

  Future<GetAgentModel> getAgent(String branchCode);

  Future<PostTransactionModel> postEmailForgotPassword(String email);

  Future<GetLoginModel> postPasswordPinConfirm(InputPinconfirmModel data);

  Future<PostTransactionModel> postPasswordChage(InputNewPasswordModel data);

  Future<BaseResponseModel<MailCheckModel>> getCheckMail(String email);

  Future<BaseResponseModel> postFcmToken(Device data);

  Future<GetLoginModel> postFcmTokenNonAuth(Device data);

  Future<BaseResponseModel> logout();

  Future<GetLoginModel> updateDeviceInfo(Device data);

  Future<GetLoginModel> updateDeviceInfoNonAuth(Device data);
}

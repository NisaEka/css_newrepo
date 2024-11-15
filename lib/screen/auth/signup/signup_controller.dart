import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/master/get_agent_model.dart';
import 'package:css_mobile/data/model/auth/get_referal_model.dart';
import 'package:css_mobile/data/model/auth/input_register_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/group_owner_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/signup/signup_otp/signup_otp_screen.dart';
import 'package:css_mobile/screen/auth/signup/signup_state.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class SignUpController extends BaseController {
  final state = SignupState();

  Future<void> initData() async {
    state.locale = await storage.readString(StorageCore.localeApp);
    ValidationBuilder.setLocale(state.locale!);

    update();
  }

  void selectOrigin(OriginModel value) {
    {
      state.selectedOrigin = value;
      state.kotaPengirim.text = state.selectedOrigin?.originName ?? '';
      state.branchCode = state.selectedOrigin?.branchCode;
      update();
      AppLogger.d(state.selectedOrigin as String);

      getAgentList();
    }
  }

  Future<List<ReferalModel>> getReferalList(String code) async {
    var response = await auth.getReferal(code);
    return response.payload?.toList() ?? [];
  }

  Future<void> getAgentList() async {
    state.agenList = [
      AgentModel(custName: 'BELUM KIRIM KE JNE'),
      AgentModel(custName: 'TIDAK TENTU'),
    ];
    state.isLoadAgent = true;
    update();
    await master
        .getAgents(state.selectedOrigin?.branchCode ?? '')
        .then((value) {
      state.agenList.addAll(value.data ?? []);
      update();
    });

    state.isLoadAgent = false;
    update();
  }

  Future<void> mailValidation() async {
    state.isLoading = true;
    update();
    try {
      await auth.getCheckMail(state.email.text).then((value) =>
          value.data?.disposable == true ||
                  value.data?.publicDomain == false ||
                  value.data?.mx == false
              ? Get.showSnackbar(
                  GetSnackBar(
                    icon: const Icon(
                      Icons.warning,
                      color: whiteColor,
                    ),
                    message:
                        'CSS tidak menerima pendaftaran menggunakan email temporary'
                            .tr,
                    isDismissible: true,
                    duration: const Duration(seconds: 3),
                    backgroundColor: errorColor,
                  ),
                )
              : saveRegistration());
    } catch (e) {
      e.printError();
    }
    state.isLoading = false;
    update();
  }

  Future<void> saveRegistration() async {
    state.isLoading = true;
    update();

    await auth
        .postRegister(
      InputRegisterModel(
        fullName: state.namaLengkap.text,
        brandName: state.namaBrand.text,
        phone: state.noHp.text,
        email: state.email.text,
        referralCode: state.kodeReferal.text,
        originCode: state.selectedOrigin?.originCode ?? '',
        alreadyUseJne: state.pakaiJNE ? "YES" : null,
        salesCounter:
            state.selectedAgent?.custNo ?? state.selectedAgent?.custName,
      ),
    )
        .then((value) {
      if (value.code == 201) {
        AppSnackBar.success('Silahkan cek email anda'.tr);
        Get.to(const SignUpOTPScreen(), arguments: {
          'email': state.email.text,
          'isActivation': false,
        });
      } else if (value.code == 409 || value.message == "Conflict") {
        AppSnackBar.error('email atau nomor telepon sudah terdaftar'.tr);
      } else {
        AppSnackBar.error(value.error[0].toString());
      }
    }).catchError((error) {
      AppLogger.e('error signup $error');
    });

    state.isLoading = false;
    update();
  }

  Future<OriginModel> getOrigin(String keyword) async {
    var response =
        await master.getOrigins(QueryParamModel(search: keyword.toUpperCase()));
    var models = response.data?.toList();
    AppLogger.d(models as String);
    return models?.first ?? OriginModel();
  }

  Future<void> onSelectReferal(GroupOwnerModel value) async {
    state.kodeReferal.text = value.groupownerName ?? '';
    state.selectedReferal = value;
    state.selectedOrigin = await getOrigin(value.groupownerOrigin ?? '');
    state.isDefaultOrigin =
        value.groupownerDefaultorigin == "FIXED" ? true : false;
    state.isSelectCounter = value.groupownerCounter == null ? true : false;
    update();
    state.kotaPengirim.text = state.selectedOrigin?.originName ?? '';
    state.branchCode = state.selectedOrigin?.branchCode;
    state.pakaiJNE = value.groupownerCounter != null;
    update();
    getAgentList();
    if (value.groupownerCounter != null) {
      state.selectedAgent = state.agenList
          .where((e) => e.custName == value.groupownerCounter)
          .first;
      update();
      state.selectedAgent?.custName.printInfo(info: "selectedAgent");
    } else {
      state.selectedAgent = null;
      update();
    }
  }

  void unSelectReferal() {
    state.kodeReferal.clear();
    state.selectedReferal = null;
    state.selectedOrigin = null;
    state.isDefaultOrigin = false;
    // state.isSelectCounter = false;
    update();
  }
}

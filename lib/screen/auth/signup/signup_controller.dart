import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/auth/get_agent_model.dart';
import 'package:css_mobile/data/model/auth/get_referal_model.dart';
import 'package:css_mobile/data/model/auth/input_register_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/signup/signup_otp/signup_otp_screen.dart';
import 'package:css_mobile/screen/auth/signup/signup_state.dart';
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
    await auth.getAgent(state.branchCode!).then((value) {
      state.agenList.addAll(value.payload ?? []);
      update();
    });

    state.isLoadAgent = false;
    update();
  }

  Future<void> mailValidation() async {
    state.isLoading = true;
    update();
    try {
      await auth
          .getCheckMail(state.email.text)
          .then((value) => value.data?.disposable == true || value.data?.publicDomain == false || value.data?.mx == false
              ? Get.showSnackbar(
                  GetSnackBar(
                    icon: const Icon(
                      Icons.warning,
                      color: whiteColor,
                    ),
                    message: 'CSS tidak menerima pendaftaran menggunakan state.email temporary'.tr,
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
    try {
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
          salesCounter: state.selectedAgent?.custNo ?? state.selectedAgent?.custName,
        ),
      )
          .then((value) {
        if (value.code == 201) {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.info,
                color: whiteColor,
              ),
              message: 'Silahkan cek state.email anda'.tr,
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: successColor,
            ),
          );
          Get.to(const SignUpOTPScreen(), arguments: {
            'state.email': state.email.text,
            'isActivation': false,
          });
        } else if (value.code == 409 || value.message == "Conflict") {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.warning,
                color: whiteColor,
              ),
              message: 'state.email atau nomor telepon sudah terdaftar'.tr,
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: errorColor,
            ),
          );
        }
      });
    } catch (e) {
      e.printError();
    }

    state.isLoading = false;
    update();
  }

  Future<void> onSelectReferal(ReferalModel value) async {
    state.kodeReferal.text = value.name ?? '';
    state.selectedReferal = value;
    state.selectedOrigin = value.origin;
    state.isDefaultOrigin = value.defaultOrigin == "FIXED" ? true : false;
    state.isSelectCounter = value.counter == null ? true : false;
    update();
    state.kotaPengirim.text = state.selectedOrigin?.originName ?? '';
    state.branchCode = state.selectedOrigin?.branchCode;
    state.pakaiJNE = value.counter != null;
    update();
    getAgentList();
    if (value.counter != null) {
      state.selectedAgent = state.agenList.where((e) => e.custName == value.counter).first;
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
    state.isSelectCounter = false;
    update();
  }


}

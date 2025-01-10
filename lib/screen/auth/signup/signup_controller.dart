import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/master/get_agent_model.dart';
import 'package:css_mobile/data/model/auth/input_register_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/group_owner_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/signup/signup_otp/signup_otp_screen.dart';
import 'package:css_mobile/screen/auth/signup/signup_state.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
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
      state.origin.text = state.selectedOrigin?.originName ?? '';
      state.branchCode = state.selectedOrigin?.branchCode;
      update();

      getAgentList();
    }
  }

  Future<void> getAgentList() async {
    state.agentList = [
      AgentModel(custName: 'BELUM KIRIM KE JNE'),
      AgentModel(custName: 'TIDAK TENTU'),
    ];
    state.isLoadAgent = true;
    update();
    await master
        .getAgents(state.selectedOrigin?.branchCode ?? '')
        .then((value) {
      state.agentList.addAll(value.data ?? []);
      update();
    });

    state.isLoadAgent = false;
    update();
  }

  Future<void> saveRegistration() async {
    state.isLoading = true;
    update();

    await auth
        .postRegister(
      InputRegisterModel(
        fullName: state.fullName.text,
        brandName: state.brandName.text,
        phone: state.phone.text,
        email: state.email.text,
        referralCode: state.referralCode.text,
        originCode: state.selectedOrigin?.originCode ?? '',
        alreadyUseJne: state.useJNE ? "YES" : null,
        salesCounter:
            state.selectedAgent?.custNo ?? state.selectedAgent?.custName,
      ),
    )
        .then((value) {
      if (value.code == 201) {
        AppSnackBar.success('Silahkan cek email anda'.tr);
        Get.to(() => const SignUpOTPScreen(), arguments: {
          'email': state.email.text,
          'isActivation': false,
          'userData': UserModel(
            email: state.email.text,
            phone: state.phone.text,
          ),
        });
      } else if (value.code == 409 || value.message == "Conflict") {
        AppSnackBar.error('email atau nomor telepon sudah terdaftar'.tr);
      } else {
        AppSnackBar.error(value.message.toString().tr);
      }
    }).catchError((error) {
      AppLogger.e('error signup $error');
    });

    state.isLoading = false;
    update();
  }

  Future<OriginModel> getOrigin(String keyword) async {
    var response =
        await master.getOrigins(QueryModel(search: keyword.toUpperCase()));
    var models = response.data?.toList();
    AppLogger.d(models as String);
    return models?.first ?? OriginModel();
  }

  Future<void> onSelectReferal(GroupOwnerModel value) async {
    state.referralCode.text = value.groupownerName ?? '';
    state.selectedReferral = value;
    state.selectedOrigin = await getOrigin(value.groupownerOrigin ?? '');
    state.isDefaultOrigin =
        value.groupownerDefaultorigin == "FIXED" ? true : false;
    state.isSelectCounter = value.groupownerCounter == null ? true : false;
    update();
    state.origin.text = state.selectedOrigin?.originName ?? '';
    state.branchCode = state.selectedOrigin?.branchCode;
    state.useJNE = value.groupownerCounter != null;
    update();
    getAgentList();
    if (value.groupownerCounter != null) {
      state.selectedAgent = state.agentList
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
    state.referralCode.clear();
    state.selectedReferral = null;
    state.selectedOrigin = null;
    state.isDefaultOrigin = false;
    // state.isSelectCounter = false;
    update();
  }

  bool isValidate() {
    state.formKey.currentState?.validate();
    if (state.formKey.currentState?.validate() == true &&
        state.selectedOrigin != null) {
      if (state.useJNE) {
        if (state.selectedAgent == null) {
          state.isValidate = false;
          return false;
        }
        // state.isValidate = true;
        return true;
      }
      // state.isValidate = true;
      return true;
    }
    // state.isValidate = false;
    // update();
    return false;
  }
}

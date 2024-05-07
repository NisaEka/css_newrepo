import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/auth/get_agent_model.dart';
import 'package:css_mobile/data/model/auth/get_referal_model.dart';
import 'package:css_mobile/data/model/auth/input_register_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/screen/auth/signup/signup_otp/signup_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final namaLengkap = TextEditingController();
  final namaBrand = TextEditingController();
  final noHp = TextEditingController();
  final email = TextEditingController();
  final kodeReferal = TextEditingController();
  final kotaPengirim = TextEditingController();
  final agenSales = TextEditingController();

  List<AgentModel> agenList = [];

  String? version;
  String? branchCode;
  bool pakaiJNE = false;
  bool isLoadOrigin = false;
  bool isLoadReferal = false;
  bool isLoadAgent = false;
  bool isLoading = false;
  bool isDefaultOrigin = false;
  bool isSelectCounter = true;
  Origin? selectedOrigin;
  AgentModel? selectedAgent;
  ReferalModel? selectedReferal;

  Future<List<Origin>> getOriginList(String keyword) async {
    isLoadOrigin = true;
    var response = await ongkir.postOrigin(keyword);
    var models = response.payload?.toList();

    isLoadOrigin = false;
    update();
    return models ?? [];
  }

  Future<List<ReferalModel>> getReferalList(String code) async {
    var response = await auth.getReferal(code);
    return response.payload?.toList() ?? [];
  }

  Future<void> getAgentList() async {
    agenList = [
      AgentModel(custName: 'BELUM KIRIM KE JNE'),
      AgentModel(custName: 'TIDAK TENTU'),
    ];
    isLoadAgent = true;
    update();
    await auth.getAgent(branchCode!).then((value) {
      agenList.addAll(value.payload ?? []);
      update();
    });

    isLoadAgent = false;
    update();
  }

  Future<void> saveRegistration() async {
    isLoading = true;
    update();
    try {
      await auth
          .postRegister(
        InputRegisterModel(
          fullName: namaLengkap.text,
          brandName: namaBrand.text,
          phone: noHp.text,
          email: email.text,
          referralCode: kodeReferal.text,
          originCode: selectedOrigin?.originCode ?? '',
          alreadyUseJne: pakaiJNE ? "YES" : null,
          salesCounter: selectedAgent?.custNo ?? selectedAgent?.custName,
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
              message: 'Silahkan cek email anda'.tr,
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: successColor,
            ),
          );
          Get.to(const SignUpOTPScreen(), arguments: {
            'email': email.text,
          });
        } else {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.warning,
                color: whiteColor,
              ),
              message: 'Email atau nomor telepon sudah terdaftar'.tr,
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

    isLoading = false;
    update();
  }

  Future<void> onSelectReferal(ReferalModel value) async {
    kodeReferal.text = value.name ?? '';
    selectedReferal = value;
    selectedOrigin = value.origin;
    isDefaultOrigin = value.defaultOrigin == "FIXED" ? true : false;
    isSelectCounter = value.counter == null ? true : false;
    update();
    kotaPengirim.text = selectedOrigin?.originName ?? '';
    branchCode = selectedOrigin?.branchCode;
    pakaiJNE = value.counter != null;
    update();
    getAgentList();
    if (value.counter != null) {
      selectedAgent = agenList.where((e) => e.custName == value.counter).first;
      update();
      selectedAgent?.custName.printInfo(info: "selectedAgent");
    } else{
      selectedAgent = null;
      update();
    }
  }
}

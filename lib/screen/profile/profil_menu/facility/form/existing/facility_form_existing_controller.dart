import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/facility/facility_create_existing_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
import 'package:css_mobile/widgets/dialog/default_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FacilityFormExistingController extends BaseController {
  final String _facilityType = Get.arguments['facility_type'];

  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();

  bool _showLoadingIndicator = false;

  bool get showLoadingIndicator => _showLoadingIndicator;

  bool _createDataSuccess = false;

  bool get createDataSuccess => _createDataSuccess;

  bool _showInvalidInputMessage = false;

  bool get showInvalidInputMessage => _showInvalidInputMessage;

  onSubmit() async {
    _showLoadingIndicator = true;
    update();

    if (_dataIsValid()) {
      final data = _composeData();
      profil.createProfileCcrfExisting(data).then((response) {
        if (response.code == HttpStatus.created) {
          _createDataSuccess = true;
          Get.to(
            () => SuccessScreen(
              message:
                  'Upgrade profil kamu berhasil diajukan\n Mohon tunggu Approval dari Tim JNE Ya!'
                      .tr,
              thirdButtonTitle: 'Tutup'.tr,
              onThirdAction: () => Get.delete<DashboardController>()
                  .then((_) => Get.offAll(() => const DashboardScreen())),
            ),
          );
        } else {
          _createDataSuccess = false;
          update();
        }
      });
    } else {
      Get.dialog(DefaultAlertDialog(
          title: 'Terdapat input yang tidak valid'.tr,
          subtitle: 'Periksa kembali data yang telah anda masukkan.'.tr,
          confirmButtonTitle: 'OK'.tr,
          onConfirm: () => onRestartValidationState()));
      update();
    }

    _showLoadingIndicator = false;
    update();
  }

  void onRestartValidationState() {
    _showInvalidInputMessage = false;
    update();
  }

  bool _dataIsValid() {
    return name.text.length > 3 &&
        phone.text.isPhoneNumber &&
        email.text.isEmail &&
        (formKey.currentState?.validate() == true);
  }

  FacilityCreateExistingModel _composeData() {
    return FacilityCreateExistingModel(
        name: name.text,
        email: email.text,
        phone: phone.text,
        facilityType: _facilityType);
  }
}

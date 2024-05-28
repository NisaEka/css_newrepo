import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/facility/facility_create_existing_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/facility_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FacilityFormExistingController extends BaseController {

  final String _facilityType = Get.arguments['facility_type'];

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();

  bool _showLoadingIndicator = false;
  bool get showLoadingIndicator => _showLoadingIndicator;

  bool _createDataSuccess = false;
  bool get createDataSuccess => _createDataSuccess;

  onSubmit() async {
    _showLoadingIndicator = true;
    update();
    final data = _composeData();
    profil.createProfileCcrfExisting(data)
      .then((response) {
        if (response.code == HttpStatus.created) {
          _createDataSuccess = true;
          Get.to(
            SuccessScreen(
              message: 'Upgrade profil kamu berhasil diajukan\n Mohon tunggu Approval dari Tim JNE Ya!'.tr,
              buttonTitle: 'Selesai'.tr,
              nextAction: () => Get.offAll(
                  const DashboardScreen()
              ),
            ),
          );
        } else {
          _createDataSuccess = false;
        }
      });
    _showLoadingIndicator = false;
    update();
  }

  FacilityCreateExistingModel _composeData() {
    return FacilityCreateExistingModel(
      name: name.text,
      email: email.text,
      phone: phone.text,
      facilityType: _facilityType
    );
  }

}
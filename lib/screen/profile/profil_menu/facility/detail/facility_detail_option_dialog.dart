import 'package:css_mobile/screen/profile/profil_menu/facility/form/existing/facility_form_existing_screen.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/form/info/facility_form_info_screen.dart';
import 'package:css_mobile/widgets/dialog/default_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FacilityDetailOptionDialog extends StatelessWidget {
  final String facilityType;

  const FacilityDetailOptionDialog({super.key, required this.facilityType});

  @override
  Widget build(BuildContext context) {
    return DefaultAlertDialog(
      title: 'Sudah punya akun kerjasama dengan JNE?'.tr,
      backButtonTitle: 'Belum Punya'.tr,
      onBack: () {
        Get.off(const FacilityFormInfoScreen(),
            arguments: {'facility_type': facilityType});
      },
      confirmButtonTitle: 'Sudah Punya'.tr,
      onConfirm: () {
        Get.off(const FacilityFormExistingScreen(),
            arguments: {'facility_type': facilityType});
      },
    );
  }
}

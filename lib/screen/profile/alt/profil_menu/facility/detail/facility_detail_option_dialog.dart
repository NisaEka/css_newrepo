import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/existing/facility_form_existing_screen.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/info/facility_form_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FacilityDetailOptionDialog extends StatelessWidget {

  final String facilityType;

  const FacilityDetailOptionDialog({
    super.key,
    required this.facilityType
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('Sudah punya akun kerjasama dengan JNE?'.tr),
      actions: [
        TextButton(
            onPressed: () {
              Get.off(const FacilityFormInfoScreen(), arguments: {
                'facility_type': facilityType
              });
            },
            child: Text(
              'Belum',
              style: Theme.of(context).textTheme.titleSmall,
            )
        ),
        TextButton(
            onPressed: () {
              Get.off(const FacilityFormExistingScreen(), arguments: {
                'facility_type': facilityType
              });
            },
            child: Text(
              'Sudah',
              style: Theme.of(context).textTheme.titleSmall,
            )
        )
      ],
    );
  }

}
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:css_mobile/widgets/items/user_photo_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationInfoItem extends StatelessWidget {
  final UserModel data;

  const RegistrationInfoItem({super.key, required this.data});

  String maskingPhone() {
    var phoneNumber = data.phone;
    var masking = data.phone?.replaceRange(
        3, (phoneNumber?.length ?? 0), "*" * ((phoneNumber?.length ?? 0) - 6));
    return '$masking${phoneNumber?.substring(phoneNumber.length - 3)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 100, top: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: infoColor.withOpacity(0.7),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const UserPhotoProfile(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabelText(
                title: 'Email'.tr,
                value: data.email ?? '',
                fontColor: whiteColor,
              ),
              CustomLabelText(
                title: 'Nomor Telepon'.tr,
                value: maskingPhone(),
                fontColor: whiteColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

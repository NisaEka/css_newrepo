import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/widgets/profile/alt_user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:css_mobile/const/color_const.dart';

class ProfileUserInfo extends StatelessWidget {
  final UserModel? basicProfile;
  const ProfileUserInfo({super.key, this.basicProfile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AltUserInfoCard(
          isLoading: basicProfile == null,
          name: basicProfile?.name ?? '-',
          brand: basicProfile?.brand ?? '-',
          mail: basicProfile?.email ?? '-',
          type: basicProfile?.userType ?? '-',
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: blueJNE)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                ImageConstant.userPic,
                height: 50,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
